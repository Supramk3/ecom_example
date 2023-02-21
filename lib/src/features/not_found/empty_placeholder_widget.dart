import 'package:ecom_example_project/src/localization/string_hardcoded.dart';
import 'package:flutter/material.dart';

import '../../constrants/app_sizes.dart';
import '../../widgets/primary_button.dart';

/// Placeholder widget showing a message and CTA to go back to the home screen.
class EmptyPlaceholderWidget extends StatelessWidget {
  const EmptyPlaceholderWidget({super.key, required this.message});
  final String message;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(Sizes.p16),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              message,
              style: Theme.of(context).textTheme.headline4,
              textAlign: TextAlign.center,
            ),
            gapH32,
            PrimaryButton(
              onPressed: () =>
                  // * Pop all routes in the navigation stack until the home
                  // * screen is reached.
                  Navigator.of(context).popUntil((route) => route.isFirst),
              text: 'Go Home'.hardcoded,
            )
          ],
        ),
      ),
    );
  }
}
