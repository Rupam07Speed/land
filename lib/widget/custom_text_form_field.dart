import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:land_registration/constant/app_color.dart';

class CustomTextfomField extends StatelessWidget {
  final String labeltxt;
  final int? isExpand;
  final bool? isUnderline;
  final Widget? suffixicon;
  final bool? obstxt;
  final String? hinttxt;
  final TextInputType? inputType;
  final List<TextInputFormatter>? inputformater;
  final FocusNode? focusnode;
  final TextEditingController? txtController;
  final String? Function(String?)? validator;
  final Function(String)? onchanged;
  const CustomTextfomField(
      {super.key,
      required this.labeltxt,
      this.isExpand,
      this.isUnderline = true,
      this.suffixicon,
      this.obstxt = false,
      this.hinttxt,
      this.txtController,
      this.validator,
      this.onchanged,
      this.inputType,
      this.inputformater,
      this.focusnode});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          labeltxt,
          style: TextStyle(
              fontSize: 16,
              color:
                  isUnderline! ? AppColors.whiteColor : AppColors.blackColor),
        ),
        isUnderline!
            ? Container()
            : SizedBox(
                height: 10,
              ),
        TextFormField(
          controller: txtController,
          keyboardType: inputType,
          inputFormatters: inputformater,
          validator: validator,
          onChanged: onchanged,
          focusNode: focusnode,
          decoration: InputDecoration(
            isDense: true,
            hintText: hinttxt,
            border: isUnderline!
                ? UnderlineInputBorder(
                    borderSide: BorderSide(color: AppColors.whiteColor),
                  )
                : OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.primaryColor),
                  ),
            focusedBorder: isUnderline!
                ? UnderlineInputBorder(
                    borderSide: BorderSide(color: AppColors.whiteColor),
                  )
                : OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.primaryColor),
                  ),
            enabledBorder: isUnderline!
                ? UnderlineInputBorder(
                    borderSide: BorderSide(color: AppColors.whiteColor),
                  )
                : OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.primaryColor),
                  ),
            suffixIcon: suffixicon,
          ),
          obscureText: obstxt!,
          style: TextStyle(
              color:
                  isUnderline! ? AppColors.whiteColor : AppColors.blackColor),
          cursorColor:
              isUnderline! ? AppColors.whiteColor : AppColors.blackColor,
          minLines: 1,
          maxLines: isExpand ?? 1,
        ),
      ],
    );
  }
}
