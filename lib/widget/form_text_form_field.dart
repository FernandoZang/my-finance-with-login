import 'package:flutter/material.dart';

class FormTextFormField extends StatefulWidget {
  final String label;
  final String? Function(String?)? validator;
  final bool obscureText;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final IconData? prefixIcon;
  final Widget? suffixIcon;
  final String? hintText;
  final void Function(String)? onChanged;
  final FocusNode? focusNode;

  const FormTextFormField({
    Key? key,
    required this.label,
    this.validator,
    this.obscureText = false,
    this.controller,
    this.keyboardType = TextInputType.text,
    this.prefixIcon,
    this.suffixIcon,
    this.hintText,
    this.onChanged,
    this.focusNode,
  }) : super(key: key);

  @override
  State<FormTextFormField> createState() => _FormTextFormFieldState();
}

class _FormTextFormFieldState extends State<FormTextFormField>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.02).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _handleFocusChange(bool hasFocus) {
    setState(() {
      _isFocused = hasFocus;
      if (hasFocus) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _scaleAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: TextFormField(
            controller: widget.controller,
            validator: widget.validator,
            obscureText: widget.obscureText,
            keyboardType: widget.keyboardType,
            focusNode: widget.focusNode,
            onChanged: widget.onChanged,
            decoration: InputDecoration(
              labelText: widget.label,
              hintText: widget.hintText,
              prefixIcon:
                  widget.prefixIcon != null ? Icon(widget.prefixIcon) : null,
              suffixIcon: widget.suffixIcon,
              floatingLabelBehavior: FloatingLabelBehavior.always,
              labelStyle: TextStyle(
                color:
                    _isFocused ? Theme.of(context).colorScheme.primary : null,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Colors.grey, width: 1),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Theme.of(context).colorScheme.primary, width: 2),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Colors.grey, width: 1),
              ),
            ),
            onTap: () => _handleFocusChange(true),
            onEditingComplete: () => _handleFocusChange(false),
          ),
        );
      },
    );
  }
}
