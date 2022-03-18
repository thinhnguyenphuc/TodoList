
import 'package:flutter/material.dart';

class IconInputField extends StatelessWidget {
  final TextStyle style;
  final bool textObscured;
  final EdgeInsetsGeometry iconPadding;
  final EdgeInsetsGeometry contentPadding;
  final IconData? iconData;
  final double iconSize;
  final Color iconColor;
  ///True if icon is a prefix icon, Else it's a suffix icon
  final bool iconIsPrefix;
  final EdgeInsetsGeometry prefixIconPadding;
  final void Function()? onIconClicked;
  final String hintText;
  final double borderRadius;
  final TextEditingController? textEditingController;
  final FocusNode? focusNode;
  final bool autoFocus;
  final bool passField;
  final IconButton? hidePassButton;
  ///Create an rounded border input field with a prefix icon
  ///
  const IconInputField({Key? key,
    this.style = const TextStyle(fontFamily: 'Montserrat', fontSize: 16.0),
    this.textObscured = false,
    this.iconPadding = EdgeInsets.zero,
    this.prefixIconPadding = const EdgeInsets.only( top: 10, left: 0, right: 0, bottom: 10),
    this.contentPadding = const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
    this.iconData,
    this.hintText = "",
    this.borderRadius = 32.0,
    this.iconSize = 24,
    this.iconColor = Colors.black,
    this.iconIsPrefix = true,
    this.onIconClicked,
    this.textEditingController,
    this.focusNode,
    this.autoFocus = false,
    this.passField = false,
    this.hidePassButton,
  }):
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final decoratePass = InputDecoration(
        prefixIcon: Padding(
          padding: prefixIconPadding,
          child: Icon(
            iconData,
            color: iconColor,
            size: iconSize,
          ),
        ),
        suffixIcon: hidePassButton,
        contentPadding: contentPadding,
        hintText: hintText,
        border:
        OutlineInputBorder(borderRadius: BorderRadius.circular(borderRadius)));

    final decorate = InputDecoration(
        prefixIcon: iconIsPrefix && iconData != null? createIcon(): null,
        contentPadding: contentPadding,
        hintText: hintText,
        border:
        OutlineInputBorder(borderRadius: BorderRadius.circular(borderRadius)));

    return TextField(
      focusNode: focusNode,
      textAlignVertical: TextAlignVertical.center,
      autofocus: autoFocus,
      controller: textEditingController,
      obscureText: textObscured,
      style: style,
      decoration: passField?decoratePass:decorate,
    );
  }

  Widget createIcon() {
    return IconButton(
      padding: iconPadding,
      icon: Icon(
        iconData,
        size: iconSize,
        color: iconColor,
      ),
      onPressed: onIconClicked,
    );
  }
}

class ChatInputField extends StatefulWidget {
  const ChatInputField({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ChatInputFieldState();

}

class _ChatInputFieldState extends State<ChatInputField> {
  final FocusNode _focusNode = FocusNode();


  @override
  void initState() {
    _focusNode.addListener(_onInputFieldFocusChanged);
    super.initState();
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onInputFieldFocusChanged);
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    var emojiIconButton = IconButton(
      icon: Icon(
        Icons.tag_faces,
        color: Theme.of(context).primaryColor,
      ),
      onPressed: () {},
    );

    var inputField = Expanded(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: IconInputField(
            focusNode: _focusNode,
            contentPadding: const EdgeInsets.symmetric(horizontal: 15),
          ),
        )
    );

    var sendIconButton = IconButton(
      icon: Icon(
        Icons.send,
        color: Theme.of(context).primaryColor,
      ),
      onPressed: () {},
    );

    List<Widget> inputFieldRowChildren = [
      emojiIconButton,
      inputField,
      sendIconButton
    ];

    return Container(
        decoration: const BoxDecoration(
            border: Border(
                top: BorderSide(color: Colors.grey)
            )
        ),
        child: Row(
          children: inputFieldRowChildren,
        )
    );
  }

  void _onInputFieldFocusChanged() {
    if (_focusNode.hasFocus) {
      _textFieldFocused();
    } else if (!_focusNode.hasFocus) {
      _textFieldUnfocused();
    }
  }

  void _textFieldUnfocused() {
    setState(() {
    });
  }

  void _textFieldFocused() {
    setState(() {
    });
  }

}