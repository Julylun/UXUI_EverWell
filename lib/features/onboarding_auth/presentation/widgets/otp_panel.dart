import 'package:flutter/material.dart';

import '../../../../core/presentation/theme/app_colors.dart';

/// Hàng 4 ô OTP (Figma `806:4761`, `806:4768`).
class OtpDigitsRow extends StatelessWidget {
  const OtpDigitsRow({super.key, required this.digits});

  final String digits;

  static const int slotCount = 4;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(slotCount, (i) {
        final ch = i < digits.length ? digits[i] : '';
        return Expanded(
          child: Padding(
            padding: EdgeInsets.only(
              left: i == 0 ? 0 : 5,
              right: i == slotCount - 1 ? 0 : 5,
            ),
            child: Container(
              height: 55,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: AppColors.primary50,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Text(
                ch,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: AppColors.primary900,
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}

/// Bàn phím số OTP.
class OtpKeypad extends StatelessWidget {
  const OtpKeypad({
    super.key,
    required this.onDigit,
    required this.onBackspace,
  });

  final ValueChanged<String> onDigit;
  final VoidCallback onBackspace;

  @override
  Widget build(BuildContext context) {
    final keys = [
      ['1', '2', '3'],
      ['4', '5', '6'],
      ['7', '8', '9'],
      ['*', '0', '#'],
    ];
    return Column(
      children: keys.map((row) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Row(
            children: row.map((k) {
              return Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  child: Material(
                    color: AppColors.primary50,
                    borderRadius: BorderRadius.circular(15),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(15),
                      onTap: () {
                        if (k == '#' || k == '*') {
                          onBackspace();
                        } else {
                          onDigit(k);
                        }
                      },
                      child: SizedBox(
                        height: 52,
                        child: Center(
                          child: Text(
                            k,
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w700,
                              color: AppColors.primary900,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        );
      }).toList(),
    );
  }
}
