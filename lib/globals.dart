library globals;

import 'package:flutter/cupertino.dart';
import 'package:literahub/core/theme/light_colors.dart';

String? AppFlavor;
String? appVersion;

footer() {
  return Container(
    color: LightColors.kLightGrayM,
    child: Text(
      'app version : $appVersion',
      style: LightColors.textvSmallStyle,
      textAlign: TextAlign.center,
    ),
  );
}

convertStringJson(json, key) {
  return json.containsKey(key) && json[key] != null ? json[key] ?? '' : '';
}

convertintJson(json, key) {
  return json.containsKey(key) && json[key] != null ? json[key] ?? 0 : 0;
}

convertBoolJson(json, key) {
  return json.containsKey(key) && json[key] != null
      ? json[key] ?? false
      : false;
}
