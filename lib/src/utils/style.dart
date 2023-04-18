import 'package:flutter/material.dart';
import 'package:riverpod_todo/src/utils/colors.dart';

final buttonStyle = ButtonStyle(
  backgroundColor: MaterialStateProperty.all<Color>(Colors.indigo),
  foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
  padding: MaterialStateProperty.all<EdgeInsets>(
    const EdgeInsets.all(20),
  ),
);

const editProfileDialogShape = RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(32.0)));

const SizedBox vpaddingBox = SizedBox(width: 10);
const SizedBox hpaddingBox = SizedBox(height: 10);
const SizedBox hpaddingBoxM = SizedBox(height: 20);
const SizedBox hpaddingBoxL = SizedBox(height: 30);

const TextStyle whiteTextStyle = TextStyle(color: ColorList.white);
TextStyle whiteBoldTextStyle =
    whiteTextStyle.copyWith(fontWeight: FontWeight.bold);
