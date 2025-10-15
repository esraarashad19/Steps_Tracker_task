import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:steps_tracker/core/error/failure.dart';
import 'package:steps_tracker/core/services/shared_pref_service.dart';
import 'package:steps_tracker/features/setup_profile/domain/setup_profile_repo.dart';

class SetupProfileRepositoryImpl implements SetupProfileRepository {
  final FirebaseFirestore firestore;
  final FirebaseStorage storage;

  SetupProfileRepositoryImpl(this.firestore, this.storage);

  @override
  Future<Either<Failure, Unit>>  saveUserProfile({
    required String userId,
    required String name,
    required double weight,
    File? profileImage,
  }) async {
    try {
      String? imageUrl;

      /// upload image if selected
      if (profileImage != null) {
        final bytes = await profileImage.readAsBytes();
        imageUrl = base64Encode(bytes);
      }


      print({
        'name': name,
        'weight': weight,
        'imageUrl': imageUrl,
        'updatedAt': FieldValue.serverTimestamp(),
      }.toString());

      /// save to Firestore
      await firestore.collection('users').doc(userId).set({
        'name': name,
        'weight': weight,
        'imageUrl': imageUrl,
        'updatedAt': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));


      /// save in shared pref
      await SharedPrefService.setUserName(name);
      await SharedPrefService.setUserWeight(weight);
      if (imageUrl != null) {
        await SharedPrefService.setUserImage(imageUrl);
      }

      /// store weight in new collection
      final uid=await SharedPrefService.getUserId();
      await firestore.collection('users').doc(uid).collection('weights').add({
        'weight':weight,
        'date': Timestamp.fromDate(DateTime.now()),

      });
      return Right(unit);
      // success
    } on FirebaseException catch (e) {
      return Left(Failure('Firebase error: ${e.message ?? e.code}'));
    } catch (e) {
      return Left(Failure('Unexpected error: $e'));
    }
  }
}
