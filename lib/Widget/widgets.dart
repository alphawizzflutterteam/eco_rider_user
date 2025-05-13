import 'package:flutter/material.dart';

import '../Helper/Constants.dart';

Widget text(String text,
    {var fontSize = textSizeMedium,
    textColor = const Color(0xffffffff),
    var fontFamily = fontRegular,
    var isCentered = false,
    var isEnd = false,
    var maxLine = 2,
    var latterSpacing = 0.25,
    var textAllCaps = false,
    var isLongText = false,
    var overFlow = false,
    var decoration = false,
    var under = false,
    fontWeight}) {
  return Text(
    textAllCaps ? text.toUpperCase() : text,
    textAlign: isCentered
        ? TextAlign.center
        : isEnd
            ? TextAlign.end
            : TextAlign.start,
    maxLines: isLongText ? null : maxLine,
    softWrap: true,
    overflow: overFlow ? TextOverflow.ellipsis : TextOverflow.clip,
    style: TextStyle(
        fontWeight: fontWeight ?? FontWeight.normal,
        fontFamily: fontFamily,
        fontSize: double.parse(fontSize.toString()),
        color: textColor,
        height: 1.5,
        letterSpacing: latterSpacing,
        decoration: decoration
            ? TextDecoration.lineThrough
            : under
                ? TextDecoration.underline
                : TextDecoration.none),
  );
}
