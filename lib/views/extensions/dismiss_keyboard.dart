import 'package:flutter/material.dart';

extension DimsissKeyBoard on Widget {
  void dismissKeyBoard() => FocusManager.instance.primaryFocus?.unfocus();
}
