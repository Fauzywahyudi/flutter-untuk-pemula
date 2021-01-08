import 'package:flutter/material.dart';

TextStyle textWhite = TextStyle(color: Colors.white);

InputBorder inputBorder = OutlineInputBorder(
  borderRadius: BorderRadius.circular(5.0),
  borderSide: BorderSide(color: Colors.white),
);

InputDecoration inputDecoration(String hint) => InputDecoration(
      filled: true,
      fillColor: Colors.white,
      enabledBorder: inputBorder,
      border: inputBorder,
      errorBorder:
          inputBorder.copyWith(borderSide: BorderSide(color: Colors.red)),
      labelText: hint,
      labelStyle: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.w300,
        fontSize: 16.0,
      ),
      errorStyle: TextStyle(
        color: Colors.red,
        fontWeight: FontWeight.bold,
      ),
    );

Icon iconSpend = Icon(
  Icons.keyboard_arrow_up,
  size: 35,
  color: Colors.red,
);
Icon iconIncome = Icon(
  Icons.keyboard_arrow_down,
  size: 35,
  color: Colors.green,
);
