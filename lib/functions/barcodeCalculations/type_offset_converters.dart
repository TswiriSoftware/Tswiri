import 'dart:ui';

import 'package:flutter_google_ml_kit/databaseAdapters/typeAdapters/type_offset_adapter.dart';

TypeOffsetHiveObject offsetToTypeOffset(Offset offset) {
  TypeOffsetHiveObject typeOffset =
      TypeOffsetHiveObject(x: offset.dx, y: offset.dy);
  return typeOffset;
}

Offset typeOffsetToOffset(TypeOffsetHiveObject typeOffset) {
  Offset offset = Offset(typeOffset.x, typeOffset.y);
  return offset;
}
