import 'package:flutter/material.dart';

class Utils {
  Size getScreenSize() {
    return MediaQueryData.fromWindow(WidgetsBinding.instance!.window).size;
  }

  showSnackBar(BuildContext context, String content){
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(content),),);
  }


}

const webScreenSize = 600;
