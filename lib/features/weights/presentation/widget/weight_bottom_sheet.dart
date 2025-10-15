// widgets/weight_bottom_sheet.dart
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:steps_tracker/core/localization/localization_extention.dart';
import 'package:steps_tracker/core/theme/app_colors.dart';
import 'package:steps_tracker/core/utils/size_extension.dart';
import 'package:steps_tracker/core/widgets/custom_app_button.dart';
import 'package:steps_tracker/core/widgets/custom_text_field.dart';
import 'package:steps_tracker/features/weights/domain/weight_model.dart';


class WeightBottomSheet extends StatefulWidget {
  final WeightModel? model;
  final void Function(double weight, DateTime date) onSave;
  final void Function()? onDelete;

  const WeightBottomSheet({
    Key? key,
    this.model,
    required this.onSave,
    this.onDelete,
  }) : super(key: key);

  @override
  State<WeightBottomSheet> createState() => _WeightBottomSheetState();
}

class _WeightBottomSheetState extends State<WeightBottomSheet> {
  final weightController = TextEditingController();
  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    if (widget.model != null) {
      weightController.text = widget.model!.weight.toStringAsFixed(1);
      selectedDate = widget.model!.date;
    }
  }

  @override
  void dispose() {
    weightController.dispose();
    super.dispose();
  }

  Future<void> pickDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),

    );
    if (date == null) return;
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(selectedDate),
    );
    if (time == null) return;
    setState(() {
      selectedDate = DateTime(
        date.year, date.month, date.day, time.hour, time.minute,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: 3.8.h,
        left: 3.w,
        right: 3,
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomTextField(
            controller: weightController,
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            hintText: 'weight'.tr,
          ),

          1.2.sh,

          InkWell(
            onTap: pickDate,
            child: InputDecorator(
              decoration:InputDecoration(
                hintText: 'date'.tr,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: AppColors.greyColor(context),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: AppColors.primaryColor(context),
                    width: 1.8,
                  ),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(DateFormat('yyyy-MM-dd HH:mm').format(selectedDate)),
                  Icon(Icons.calendar_today, size: 1.8.h,color: AppColors.primaryColor(context),),
                ],
              ),
            ),
          ),
          1.6.sh,

          Row(
            children: [
              if (widget.model != null)
                Expanded(
                  child: CustomAppButton(
                    onPress:()=> widget.onDelete,
                    title:  'delete'.tr,
                    isOutline: true,
                  ),
                ),
              if (widget.model != null) .8.sw,
              Expanded(
                child: CustomAppButton(
                  title: 'saveChanges'.tr,
                  onPress: () {
                    final weight = double.tryParse(weightController.text.trim()) ?? 0.0;
                    widget.onSave(weight, selectedDate);
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ],
          ),
          6.sh,
        ],
      ),
    );
  }
}
