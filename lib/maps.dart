///////////////////////////////////////////////////////////////////////////////////////
  // Map<String, RealBarcodePosition> realInterBarcodeOffsetsMap = {};

  // realInterBarcodeOffsetsMap.putIfAbsent(
  //     '1', () => RealBarcodePosition('1', const Offset(0, 0), 0));

  // for (int i = 0; i <= realInterBarcodeOffsets.length; i++) {
  //   for (RealInterBarcodeOffset realInterBarcodeOffset
  //       in realInterBarcodeOffsets) {
  //     if (realInterBarcodeOffsetsMap
  //         .containsKey(realInterBarcodeOffset.uidStart)) {
  //       realInterBarcodeOffsetsMap.putIfAbsent(
  //           realInterBarcodeOffset.uidEnd,
  //           () => RealBarcodePosition(
  //               realInterBarcodeOffset.uidEnd,
  //               realInterBarcodeOffsetsMap[realInterBarcodeOffset.uidStart]!
  //                       .interBarcodeOffset! +
  //                   realInterBarcodeOffset.interBarcodeOffset,
  //               realInterBarcodeOffset.timestamp));
  //     } else if (realInterBarcodeOffsetsMap
  //         .containsKey(realInterBarcodeOffset.uidEnd)) {
  //       realInterBarcodeOffsetsMap.putIfAbsent(
  //           realInterBarcodeOffset.uidStart,
  //           () => RealBarcodePosition(
  //               realInterBarcodeOffset.uidStart,
  //               realInterBarcodeOffsetsMap[realInterBarcodeOffset.uidEnd]!
  //                       .interBarcodeOffset! -
  //                   realInterBarcodeOffset.interBarcodeOffset,
  //               realInterBarcodeOffset.timestamp));
  //     }
  //   }
  // }

  // for (RealBarcodePosition realInterBarcodeOffset
  //     in realInterBarcodeOffsetsMap.values) {
  //   print(realInterBarcodeOffset);
  //   realPositionalData.put(
  //       realInterBarcodeOffset.uid,
  //       RealBarcodePostionEntry(
  //           uid: realInterBarcodeOffset.uid,
  //           offset:
  //               offsetToTypeOffset(realInterBarcodeOffset.interBarcodeOffset!),
  //           distanceFromCamera: 0,
  //           fixed: false,
  //           timestamp: realInterBarcodeOffset.timestamp!));
  // }

  //////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////