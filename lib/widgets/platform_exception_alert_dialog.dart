import 'package:meta/meta.dart';
import 'package:flutter/services.dart';
import 'package:time_tracker/widgets/platform_alert_dialog.dart';

class PlatformExceptionAlertDialog extends PlatformAlertDialog {
  PlatformExceptionAlertDialog({
    @required String title,
    @required PlatformException exception,
  }) : super(
          title: title,
          content: _message(exception),
          defaultActionText: 'OK',
        );

  static String _message(PlatformException exception) {
    return _errors[exception.code] ?? exception.message;
  }

  static Map<String, String> _errors = {
    'ERROR_WEAK_PASSWORD': 'The Password is weak',
    'ERROR_INVALID_EMAIL': 'Enter a valid Email Address',
    'ERROR_EMAIL_ALREADY_IN_USE':
        'Email already registered , Try with different Email or Sign in',
    'ERROR_WRONG_PASSWORD': 'Incorrect Password',
    'ERROR_USER_NOT_FOUND': 'Email not registered , Try Signing up',
    'ERROR_USER_DISABLED': 'Account has been Disabled',
    'ERROR_TOO_MANY_REQUESTS': 'Too many sign-in requests , please wait',
    'ERROR_OPERATION_NOT_ALLOWED': 'Email & Password accounts are not enabled',
    'Error performing setData':
        'You have insufficient permissions for this action.',
  };
}
