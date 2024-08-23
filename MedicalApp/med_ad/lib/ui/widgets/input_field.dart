import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import '../theme.dart';
import 'package:med_add/ui/theme.dart';
import 'package:get/get.dart';

class MyInputField extends StatelessWidget {
  final String title;
  final String hint;
  final TextEditingController? controller;
  final Widget? widget;
  const MyInputField({Key? key,
     required this.title,
     required this.hint,
     this.controller,
     this.widget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top:16),
      
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style:titleStyle,
          ),
          Container(
            height: 50,
            margin: EdgeInsets.only(top: 4.0),
            padding: EdgeInsets.only(left: 16),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey,
                width: 1.2

              ),
              borderRadius: BorderRadius.circular(12)
            ) ,
            child: Row(
              children: [
                 Expanded(
                child: TextFormField(
                  readOnly: widget==null?false:true,
                  autofocus: false,
                  cursorColor: Get.isDarkMode?Colors.grey[100]:Colors.grey[700],
                  controller: controller,
                  style: subTitleStyle,
                  decoration: InputDecoration(
                    hintText:hint,
                    hintStyle: subTitleStyle,
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: context.theme.backgroundColor,
                        width: 0
                      )
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: context.theme.backgroundColor,
                        width: 0
                      )
                    )
                  ),

                ),
              ),
              widget==null?Container():Container(child:widget)
              ] ,
            ),
          )

        ],
      ),
    );
  }
}