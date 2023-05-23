import 'package:flutter/material.dart';
import 'package:mvvm_architechture_provider_http/res/resources.dart';

extension AppContext on BuildContext {
  Resources get resources => Resources.of(this);
}
