

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:note_project/src/resources/localisation.dart';

String validateEmail(String value, BuildContext context) {
  if(EmailValidator.validate(value)) {
    return null;
  } else {
    return localize(EMAIL_NOT_CORRECT, context);
  }
}

String validateToken(String value, BuildContext context) {
  if(value.isEmpty) {
    return localize(REQUIRED_FIELD, context);
  } else {
    return null;
  }
}