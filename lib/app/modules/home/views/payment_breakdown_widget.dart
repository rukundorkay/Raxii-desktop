import 'package:flutter/material.dart';
import 'package:raxii_desktop/app/shared/extension/string.dart';
import 'package:raxii_desktop/app/shared/size.dart';
import 'package:raxii_desktop/app/theme/app_colors.dart';

class PaymentBreakDown extends StatelessWidget {
  const PaymentBreakDown({
    super.key,
    required this.paymentMode,
    required this.value,
  });

  final String paymentMode;
  final int value;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 70,
      padding: EdgeInsets.all(AppSpaceSize.tiny),
      decoration: BoxDecoration(
          color: AppColors.teaGreen,
          borderRadius: const BorderRadius.all(Radius.circular(4))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            paymentMode,
            style: const TextStyle(
              color: AppColors.deepForestGreen,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(value.toString().formatAmount())
        ],
      ),
    );
  }
}
