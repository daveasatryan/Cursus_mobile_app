import 'package:cursus_app/values/values.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class GenderPicker extends StatelessWidget {
  final String selectedGender;
  final ValueChanged<String?> onChanged;
  const GenderPicker({
    required this.selectedGender,
    required this.onChanged,
    Key? key,
  }) : super(key: key);
  static String? genderValue;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'hints.gender'.tr(),
            style: TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Expanded(
                child: GenderContainer(
                  result: 1,
                  value: 'hints.male'.tr(),
                  groupValue: selectedGender,
                  onChanged: onChanged,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: GenderContainer(
                  result: 2,
                  value: 'hints.female'.tr(),
                  groupValue: selectedGender,
                  onChanged: onChanged,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class GenderContainer extends StatelessWidget {
  final int result;
  final String value;
  final String groupValue;
  final ValueChanged<String?>? onChanged;
  const GenderContainer({
    required this.result,
    required this.value,
    required this.groupValue,
    required this.onChanged,
    Key? key,
  }) : super(key: key);

  static String valueGender = "";

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          width: 2,
          color: AppColors.grey100,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(right: 5),
        child: Row(
          children: [
            InkWell(
              onTap: () {
                if (result == 1) {
                  valueGender = "male";
                  print(valueGender);
                } else if (result == 2) {
                  valueGender = "female";
                  print(valueGender);
                }
              },
              child: Radio(
                onChanged: onChanged,
                value: value.trim().toLowerCase(),
                groupValue: groupValue.trim().toLowerCase(),
                activeColor: AppColors.purpleDark,
              ),
            ),
            Text(
              value,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
