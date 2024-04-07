import 'package:flutter/material.dart';
import 'package:flutter_restaurant/localization/language_constrants.dart';
import 'package:flutter_restaurant/provider/language_provider.dart';
import 'package:flutter_restaurant/utill/dimensions.dart';
import 'package:flutter/services.dart';
import 'package:flutter_restaurant/utill/styles.dart';

class CustomTextField extends StatefulWidget {
  final String? hintText;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final FocusNode? nextFocus;
  final TextInputType inputType;
  final TextInputAction inputAction;
  final Color? fillColor;
  final int maxLines;
  final bool isPassword;
  final bool isCountryPicker;
  final bool isShowBorder;
  final bool isIcon;
  final bool isShowSuffixIcon;
  final bool isShowPrefixIcon;
  final Function? onTap;
  final Function? onChanged;
  final Function? onSuffixTap;
  final String? suffixIconUrl;
  final String? prefixIconUrl;
  final String? prefixText;
  final bool isSearch;
  final Function? onSubmit;
  final bool isEnabled;
  final TextCapitalization capitalization;
  final LanguageProvider? languageProvider;
  final InputDecoration? inputDecoration;
  final String? Function(String? )? onValidate;


  const CustomTextField(
      {Key? key, this.hintText,
      this.controller,
      this.focusNode,
      this.nextFocus,
      this.isEnabled = true,
      this.inputType = TextInputType.text,
      this.inputAction = TextInputAction.next,
      this.maxLines = 1,
      this.onSuffixTap,
      this.fillColor,
      this.onSubmit,
      this.onChanged,
      this.capitalization = TextCapitalization.none,
      this.isCountryPicker = false,
      this.isShowBorder = false,
      this.isShowSuffixIcon = false,
      this.isShowPrefixIcon = false,
      this.onTap,
      this.isIcon = false,
      this.isPassword = false,
      this.suffixIconUrl,
      this.prefixIconUrl,
      this.prefixText = '',
      this.isSearch = false,
      this.languageProvider,
        this.inputDecoration,
        this.onValidate,
      }) : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: widget.maxLines,
      controller: widget.controller,
      focusNode: widget.focusNode,
      style: Theme.of(context).textTheme.displayMedium!.copyWith(color: Theme.of(context).textTheme.bodyLarge!.color, fontSize: Dimensions.fontSizeLarge),
      textInputAction: widget.inputAction,
      keyboardType: widget.inputType,
      cursorColor: Theme.of(context).primaryColor,
      textCapitalization: widget.capitalization,
      enabled: widget.isEnabled,
      autofocus: false,
      //onChanged: widget.isSearch ? widget.languageProvider.searchLanguage : null,
      obscureText: widget.isPassword ? _obscureText : false,
      inputFormatters: widget.inputType == TextInputType.phone ? <TextInputFormatter>[FilteringTextInputFormatter.allow(RegExp('[0-9+]'))] : null,
      decoration: widget.inputDecoration ?? InputDecoration(
        errorStyle: rubikRegular.copyWith(color: Theme.of(context).colorScheme.error, fontSize: Dimensions.fontSizeSmall),
        focusedBorder: getBorder(),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(width: 1,
            color: Theme.of(context).primaryColor.withOpacity(0.4),
          ),
        ),
        enabledBorder: getBorder(),
        contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 22),
        border: getBorder(),
        isDense: true,
        hintText: widget.hintText ?? getTranslated('write_something', context),
        fillColor: widget.fillColor ?? Theme.of(context).cardColor,
        hintStyle: Theme.of(context).textTheme.displayMedium!.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).hintColor.withOpacity(0.7)),
        filled: true,
        prefixIcon: widget.prefixText != ''? Padding(
          padding: const EdgeInsets.only(left: 10.0,right: 10.0),
          child: Text(widget.prefixText??'',style: Theme.of(context).textTheme.displayMedium!.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).hintColor.withOpacity(0.7)) ,),
        ):widget.isShowPrefixIcon ? Padding(
          padding: const EdgeInsets.only(left: Dimensions.paddingSizeLarge, right: Dimensions.paddingSizeSmall),
          child: Image.asset(widget.prefixIconUrl!, color: Theme.of(context).textTheme.bodyLarge?.color),
        ) : const SizedBox.shrink(),
        prefixIconConstraints: const BoxConstraints(minWidth: 23, maxHeight: 20),
        suffixIcon: widget.isShowSuffixIcon
            ? widget.isPassword
                ? IconButton(
                    icon: Icon(_obscureText ? Icons.visibility_off : Icons.visibility, color: Theme.of(context).hintColor.withOpacity(0.3)),
                    onPressed: _toggle)
                : widget.isIcon
                    ? IconButton(
                        onPressed: widget.onSuffixTap as void Function()?,
                        icon: Image.asset(
                          widget.suffixIconUrl!,
                          width: 15,
                          height: 15,
                          color: Theme.of(context).textTheme.bodyLarge?.color,
                        ),
                      )
                    : null
            : null,
      ),
      onTap: widget.onTap as void Function()?,
      onFieldSubmitted: (text) => widget.nextFocus != null ? FocusScope.of(context).requestFocus(widget.nextFocus)
          : widget.onSubmit != null ? widget.onSubmit!(text) : null,
      onChanged: widget.onChanged as void Function(String)?,
      validator: widget.onValidate != null ? widget.onValidate!: null,

    );
  }

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  OutlineInputBorder getBorder() => OutlineInputBorder(
    borderRadius: BorderRadius.circular(10.0),
    borderSide: BorderSide(
      style: widget.isShowBorder ? BorderStyle.solid : BorderStyle.none,
      width: widget.isShowBorder ?  1 : 0,
      color: Theme.of(context).primaryColor.withOpacity(0.2),
    ),
  );
}
