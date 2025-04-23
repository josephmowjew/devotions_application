import 'package:flutter/material.dart';

class AddNoteSection extends StatefulWidget {
  final Function(String) onSubmit;
  final VoidCallback onClose;

  const AddNoteSection({
    Key? key,
    required this.onSubmit,
    required this.onClose,
  }) : super(key: key);

  @override
  State<AddNoteSection> createState() => _AddNoteSectionState();
}

class _AddNoteSectionState extends State<AddNoteSection> {
  final TextEditingController _controller = TextEditingController();
  bool _hasText = false;

  @override
  void initState() {
    super.initState();
    _controller.addListener(_handleTextChange);
  }

  void _handleTextChange() {
    final hasText = _controller.text.isNotEmpty;
    if (hasText != _hasText) {
      setState(() {
        _hasText = hasText;
      });
    }
  }

  @override
  void dispose() {
    _controller.removeListener(_handleTextChange);
    _controller.dispose();
    super.dispose();
  }

  void _handleSubmit() {
    if (_controller.text.trim().isNotEmpty) {
      widget.onSubmit(_controller.text.trim());
      _controller.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: const Color(0xFFE0E0E0)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Input field container with label
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 16, 24, 16),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                LayoutBuilder(
                  builder: (context, constraints) {
                    return Container(
                      constraints: BoxConstraints(
                        minHeight: 112,
                        maxWidth: constraints.maxWidth,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(color: const Color(0xFF757780)),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
                        child: IntrinsicHeight(
                          child: TextField(
                            controller: _controller,
                            decoration: const InputDecoration(
                              hintText: 'Client has Been Called',
                              hintStyle: TextStyle(
                                color: Color(0xFF999999),
                                fontSize: 16,
                                height: 1.5,
                              ),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.zero,
                              isDense: true,
                              isCollapsed: true,
                            ),
                            style: const TextStyle(
                              fontSize: 16,
                              color: Color(0xFF333333),
                              height: 1.5,
                            ),
                            minLines: null,
                            maxLines: null,
                            expands: true,
                          ),
                        ),
                      ),
                    );
                  },
                ),
                Positioned(
                  top: -8,
                  left: 12,
                  child: Container(
                    color: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: const Text(
                      'Add Note',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF666666),
                        height: 1.5,
                      ),
                    ),
                  ),
                ),
                if (_hasText)
                  Positioned(
                    top: 12,
                    right: 12,
                    child: MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: GestureDetector(
                        onTap: () => _controller.clear(),
                        child: const Icon(
                          Icons.highlight_off,
                          size: 30,
                          color: Color(0xFF666666),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          // Submit button container
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.only(right: 24, bottom: 24),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: _handleSubmit,
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: const Color(0xFF2196F3),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF2196F3).withOpacity(0.25),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.send,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
} 