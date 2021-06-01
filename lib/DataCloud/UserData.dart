import 'package:flutter/material.dart';

class UserData {

  String _firstName;
  String _lastName;
  String _userName;
  String _phoneNumber;
  String _email;
  String _password;


  String get firstName => _firstName;

  set firstName(String value) {
    _firstName = value;
  }

  String get lastName => _lastName;

  set lastName(String value) {
    _lastName = value;
  }

  String get userName => _userName;

  set userName(String value) {
    _userName = value;
  }

  String get phoneNumber => _phoneNumber;

  set phoneNumber(String value) {
    _phoneNumber = value;
  }

  String get email => _email;

  set email(String value) {
    _email = value;
  }

  String get password => _password;

  set password(String value) {
    _password = value;
  }
}
