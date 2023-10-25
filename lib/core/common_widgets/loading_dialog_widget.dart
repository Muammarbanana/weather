import 'package:flutter/material.dart';

import '../theme/text_style_manager.dart';

class LoadingDialogWidget extends StatelessWidget {
  const LoadingDialogWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 25),
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 25),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(13), color: Colors.white),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircularProgressIndicator(
              color: Colors.deepPurple,
            ),
            const SizedBox(height: 20),
            Text(
              "Please wait ...",
              textAlign: TextAlign.center,
              style: TextStyleManager.mediumText(),
            ),
          ],
        ),
      ),
    );
  }
}
