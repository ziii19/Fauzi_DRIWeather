import 'package:flutter/material.dart';

import '../../core/theme/app_color.dart';

class WidgetBack extends StatelessWidget {
  const WidgetBack({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pop(context),
      child: const Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Icons.arrow_back_ios_new_rounded,
            color: AppColor.white,
            size: 20,
          ),
          SizedBox(width: 5),
          Padding(
            padding: EdgeInsets.only(top: 4),
            child: Text(
              'Back',
              style: TextStyle(
                color: AppColor.white,
                fontSize: 24,
                fontWeight: FontWeight.w600,
              ),
            ),
          )
        ],
      ),
    );
  }
}
