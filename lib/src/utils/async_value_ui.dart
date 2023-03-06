import 'package:ecom_example_project/src/localization/string_hardcoded.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../widgets/alert_dialogs.dart';

extension AsyncValueUI on AsyncValue {
  void showAlertDialogOnError(BuildContext context) {
    if (!isLoading && hasError) {
      showExceptionAlertDialog(
        context: context,
        title: 'Error'.hardcoded,
        exception: error,
      );
    }
  }
}
