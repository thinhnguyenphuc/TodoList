import 'package:flutter/material.dart';

/// Button with an optional icon at the beginning
///
class IconWithTextButton extends StatelessWidget {
  final String text;
  final double elevation;
  final double borderRadius;
  final Color color;
  final EdgeInsetsGeometry padding;
  final TextAlign textAlign;
  final TextStyle textStyle;
  final void Function()? onPressedCallback;
  final IconData? iconData;
  final double iconSize;
  final Color iconColor;
  final EdgeInsetsGeometry iconPaddingInsets;
  final String imageIconPath;
  final double buttonHeight;
  final double buttonWidth;
  final List<Color> gradientColor;
  final bool hasGradientColor;

  /// Create a rounded button with an icon at the start
  ///
  /// if iconData has a value, imageIconPath will be ignored whether it has a value or not
  const IconWithTextButton({
    Key? key,
    this.text = "",
    this.elevation = 10,
    this.borderRadius = 15.0,
    this.color = const Color.fromARGB(255, 4, 148, 124),
    this.padding = const EdgeInsets.fromLTRB(20.0, 0, 20.0, 0),
    this.textAlign = TextAlign.center,
    this.textStyle = const TextStyle(
        fontFamily: 'Montserrat',
        fontSize: 20.0,
        color: Colors.white,
        fontWeight: FontWeight.bold),
    this.onPressedCallback,
    this.iconData,
    this.iconSize = 24,
    this.iconColor = Colors.black,
    this.iconPaddingInsets =
    const EdgeInsets.only(top: 0, left: 0, right: 10, bottom: 0),
    this.imageIconPath = "",
    this.buttonHeight = 48.0,
    this.buttonWidth = 300.0,
    this.gradientColor = const [Colors.blue, Colors.purple],
    this.hasGradientColor = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final decorationGradient = BoxDecoration(
      borderRadius: BorderRadius.circular(borderRadius),
      gradient: LinearGradient(
          colors: gradientColor,
          begin: const FractionalOffset(0.0, 0.0),
          end: const FractionalOffset(0.7, 0.0),
          stops: const [0.0, 1],
          tileMode: TileMode.clamp),
    );
    const decoration = BoxDecoration();

    return Material(
        elevation: elevation,
        borderRadius: BorderRadius.circular(borderRadius),
        color: color,
        child: SizedBox(
            width: buttonWidth,
            height: buttonHeight,
            child: Container(
                decoration: hasGradientColor ? decorationGradient : decoration,
                child: MaterialButton(
                    minWidth: MediaQuery.of(context).size.width,
                    height: buttonHeight,
                    padding: padding,
                    onPressed: onPressedCallback,
                    child: Row(mainAxisSize: MainAxisSize.max, children: [
                      Padding(
                        padding: iconData == null && imageIconPath.isEmpty
                            ? const EdgeInsets.only()
                            : iconPaddingInsets,
                        child: iconData != null
                            ? Icon(
                          iconData,
                          color: iconColor,
                          size: iconSize,
                        )
                            : imageIconPath.isNotEmpty
                            ? Image(
                          image: AssetImage(imageIconPath),
                          height: iconSize,
                        )
                            : null,
                      ),
                      Expanded(
                        child: Text(
                          text,
                          textAlign: textAlign,
                          style: textStyle,
                        ),
                      )
                    ])))));
  }
}

///Button that looks like an input field
class InputFieldButton extends StatelessWidget {

  final String? hintText;
  final EdgeInsets? contentPadding;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final double borderRadius;
  final double height;
  final TextInputAction inputAction;
  final TextEditingController controller;

  final void Function(String)? onSubmitted;
  final void Function(String)? onChanged;

  const InputFieldButton({Key? key,
    this.hintText,
    this.contentPadding,
    this.prefixIcon,
    this.suffixIcon,
    this.borderRadius = 200,
    required this.onSubmitted,
    required this.height,
    required this.inputAction,
    required this.onChanged,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        onSubmitted: onSubmitted,
        textInputAction: inputAction,
        decoration: InputDecoration(
          contentPadding: contentPadding,
          border: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.grey),
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          hintText:  hintText,
          hintStyle: TextStyle(
            fontSize: Theme.of(context).textTheme.bodyText2?.fontSize,
            color: Colors.grey,
            fontStyle: FontStyle.italic,
            height: 3
          ),
        ),
      ),
    );
  }

}
