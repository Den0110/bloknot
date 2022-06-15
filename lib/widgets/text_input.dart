import 'package:bloknot/constants/colors.dart';
import 'package:flutter/material.dart';

class TextInput extends StatefulWidget {
  const TextInput(
      {Key? key,
      required this.icon,
      required this.hint,
      required this.onChanged,
      this.keyboardType = TextInputType.text,
      this.obscuringEnabled = false,
      this.text})
      : super(key: key);

  final IconData icon;
  final String hint;
  final ValueChanged<String> onChanged;
  final TextInputType keyboardType;
  final bool obscuringEnabled;
  final String? text;

  @override
  _TextInputState createState() => _TextInputState();
}

class _TextInputState extends State<TextInput> {
  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 24),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: const BoxDecoration(
              color: AppColors.iconBg,
              borderRadius: BorderRadius.all(Radius.circular(6)),
            ),
            child: Icon(widget.icon, size: 20, color: AppColors.darkBlue),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 10, top: 0),
              child: TextField(
                controller: widget.text != null ? (TextEditingController()..text = widget.text!) : null,
                maxLines: widget.obscuringEnabled ? 1 : null,
                style: const TextStyle(fontSize: 18),
                textAlign: TextAlign.start,
                cursorColor: Colors.red,
                onChanged: widget.onChanged,
                keyboardType: widget.keyboardType,
                obscureText: widget.obscuringEnabled && _isObscure,
                decoration: InputDecoration(
                  isDense: true,
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  hintStyle: const TextStyle(
                    color: AppColors.secondaryText,
                  ),
                  hintText: widget.hint,
                ),
              ),
            ),
          ),
          if (widget.obscuringEnabled) ...[
            SizedBox(
              width: 38,
              height: 38,
              child: IconButton(
                icon: Icon(_isObscure ? Icons.visibility : Icons.visibility_off,
                    size: 20, color: Colors.red),
                onPressed: () {
                  setState(() {
                    _isObscure = !_isObscure;
                  });
                },
              ),
            ),
          ]
        ],
      ),
    );
  }
}
