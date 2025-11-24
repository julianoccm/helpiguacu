import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:frontend/constants/colors.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

enum InputType { text, email, phone, cpf, cnpj, cep, password }

class TextInput extends StatefulWidget {
  final TextEditingController controller;
  final String placeholder;
  final String label;
  final InputType inputType;

  const TextInput({
    super.key,
    required this.controller,
    required this.placeholder,
    required this.label,
    this.inputType = InputType.text,
  });

  @override
  TextInputState createState() => TextInputState();
}

class TextInputState extends State<TextInput> {
  bool _obscureText = true;
  bool _isValid = true;
  late MaskTextInputFormatter _maskFormatter;

  bool get isValid => _isValid;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.inputType == InputType.password;

    switch (widget.inputType) {
      case InputType.phone:
        _maskFormatter = MaskTextInputFormatter(
          mask: '(##) #####-####',
          filter: {"#": RegExp(r'[0-9]')},
        );
        break;
      case InputType.cpf:
        _maskFormatter = MaskTextInputFormatter(
          mask: '###.###.###-##',
          filter: {"#": RegExp(r'[0-9]')},
        );
        break;
      case InputType.cnpj:
        _maskFormatter = MaskTextInputFormatter(
          mask: '##.###.###/####-##',
          filter: {"#": RegExp(r'[0-9]')},
        );
        break;
      case InputType.cep:
        _maskFormatter = MaskTextInputFormatter(
          mask: '#####-###',
          filter: {"#": RegExp(r'[0-9]')},
        );
        break;
      default:
        _maskFormatter = MaskTextInputFormatter();
    }
  }

  bool _validate(String value) {
    switch (widget.inputType) {
      case InputType.email:
        return RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value);
      case InputType.phone:
        return RegExp(r'^\(\d{2}\) \d{4,5}-\d{4}$').hasMatch(value);
      case InputType.cpf:
        return RegExp(r'^\d{3}\.\d{3}\.\d{3}-\d{2}$').hasMatch(value);
      case InputType.cnpj:
        return RegExp(r'^\d{2}\.\d{3}\.\d{3}/\d{4}-\d{2}$').hasMatch(value);
      case InputType.cep:
        return RegExp(r'^\d{5}-\d{3}$').hasMatch(value);
      default:
        return value.isNotEmpty;
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isPassword = widget.inputType == InputType.password;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 5),
          child: Text(
            widget.label,
            style: TextStyle(
              color: NutricanColors.font,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        TextField(
          controller: widget.controller,
          obscureText: isPassword ? _obscureText : false,
          inputFormatters: [_maskFormatter] ,
          keyboardType: _getKeyboardType(widget.inputType),
          onChanged: (value) {
            setState(() {
              _isValid = _validate(value);
            });
          },
          decoration: InputDecoration(
            isDense: !kIsWeb,
            hintStyle: TextStyle(color: NutricanColors.placeholder),
            hintText: widget.placeholder,
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: _isValid
                    ? NutricanColors.inputBorder
                    : Colors.redAccent,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: _isValid
                    ? NutricanColors.primaryButton
                    : Colors.redAccent,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            errorText: null,
            suffixIcon: isPassword
                ? IconButton(
              icon: Icon(
                _obscureText
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined,
                color: NutricanColors.font,
              ),
              onPressed: () {
                setState(() {
                  _obscureText = !_obscureText;
                });
              },
            )
                : null,
          ),
        ),
      ],
    );
  }

  TextInputType _getKeyboardType(InputType type) {
    switch (type) {
      case InputType.email:
        return TextInputType.emailAddress;
      case InputType.phone:
      case InputType.cpf:
      case InputType.cnpj:
      case InputType.cep:
        return TextInputType.number;
      default:
        return TextInputType.text;
    }
  }
}
