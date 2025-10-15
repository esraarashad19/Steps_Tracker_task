import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'package:steps_tracker/core/services/shared_pref_service.dart';
import 'package:steps_tracker/features/setup_profile/domain/setup_profile_repo.dart';
import 'package:steps_tracker/features/setup_profile/presentation/cubit/setup_profile_states.dart';



class SetupProfileCubit extends Cubit<SetupProfileState> {
  final SetupProfileRepository repository;

  SetupProfileCubit(this.repository) : super(SetupProfileInitial());


  File? profileImage;


  Future<void> pickImage() async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? picked = await picker.pickImage(source: ImageSource.gallery);

      if (picked == null) return;

      File imageFile = File(picked.path);


      final originalPath = imageFile.path;
      final dir = originalPath.substring(0, originalPath.lastIndexOf('/'));
      final fileName = originalPath.substring(originalPath.lastIndexOf('/') + 1);
      final targetPath = '$dir/compressed_$fileName';

      final compressedFile = await FlutterImageCompress.compressAndGetFile(
        imageFile.absolute.path,
        targetPath,
        quality: 75,
      );

      if (compressedFile != null) {
        imageFile = File(compressedFile.path);
      }

      profileImage = imageFile;
      emit(SuccessImagePick());


    } catch (e) {
      emit(SetupProfileError( e.toString()));
    }
  }


  Future<void> saveProfile({
    required String name,
    required String weight,
    File? profileImage,
  }) async {

    emit(SetupProfileLoading());

    final userId = SharedPrefService.getUserId();
    final result = await repository.saveUserProfile(
      userId: userId,
      name: name,
      weight: double.parse(weight),
      profileImage: profileImage,
    );

    result.fold(
          (failure) => emit(SetupProfileError(failure.message)),
          (_) =>emit(SetupProfileSuccess()),
    );

  }

  /// start tracking on press nutton
  void startTrackingOnPress({
    required GlobalKey<FormState> formKey,
    required String name,
    required String weight,
}){
    if(formKey.currentState!.validate()){
      print('_______________');
       saveProfile(
           name: name,
           weight: weight,
           profileImage: profileImage,
       );
    }
  }
}
