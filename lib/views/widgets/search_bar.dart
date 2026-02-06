import 'dart:async';

import 'package:flutter/material.dart';

class AppSearchWidget extends StatefulWidget {
  final TextEditingController controller;
  final String hint;
  final bool autofocus;
  final FocusNode node;
  final VoidCallback onSearch;
  final Function(String)? onChanged; // Triggered on text change (debounced)
  final Function(String)? onSubmitted; // Triggered on Enter / submit

  const AppSearchWidget({
    super.key,
    required this.onSearch,
    required this.node,
    required this.controller,
    this.hint = "Search",
    this.autofocus = false,
    this.onChanged,

    this.onSubmitted,
  });

  @override
  State<AppSearchWidget> createState() => _AppSearchWidgetState();
}

class _AppSearchWidgetState extends State<AppSearchWidget> {
  Timer? _debounce;

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  void _handleChanged(String value) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () {
      if (widget.onChanged != null) widget.onChanged!(value);
    });
    setState(() {}); // update clear button visibility
  }

  void _clearText() {
    widget.controller.clear();
    if (widget.onChanged != null) widget.onChanged!('');
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final isNotEmpty = widget.controller.text.isNotEmpty;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFF1B3B36),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          const Icon(Icons.search, color: Colors.white54),
          const SizedBox(width: 8),
          Expanded(
            child: TextField(
              focusNode: widget.node,
              textInputAction: TextInputAction.done,
              controller: widget.controller,
              autofocus: widget.autofocus,
              style: const TextStyle(color: Colors.white),
              cursorColor: Colors.white,
              decoration: InputDecoration(
                hintText: widget.hint,
                hintStyle: const TextStyle(color: Colors.white54),
                border: InputBorder.none,
              ),
              onChanged: _handleChanged,
              onSubmitted: widget.onSubmitted,
            ),
          ),
          IconButton(
            onPressed: widget.onSearch,
            icon: Icon(Icons.search_rounded, color: Colors.blue),
          ),
          if (isNotEmpty)
            GestureDetector(
              onTap: _clearText,
              child: const Icon(Icons.close, color: Colors.white54),
            ),
        ],
      ),
    );
  }
}
