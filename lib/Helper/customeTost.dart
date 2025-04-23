import 'package:flutter/material.dart';

import 'Colors.dart';

void customSnackbar(BuildContext context, String msg) {
  print('tyuiolkoiug');
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        decoration: BoxDecoration(
          color: AppColors.primary, // Change the background color
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Row(
          children: [
            const Icon(Icons.info,
                color: AppColors.whiteTemp), // Change icon color
            const SizedBox(width: 8.0),
            SizedBox(
              width: MediaQuery.of(context).size.width / 1.5,
              child: Text(
                msg,
                maxLines: 4,
                style: const TextStyle(
                    color: AppColors.whiteTemp), // Change text color
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
