import 'package:flutter/material.dart';
import 'package:poc_design_tokens/tokens.dart';
import 'package:url_launcher/url_launcher.dart';

class TextBlock extends StatelessWidget {
  const TextBlock({required this.props, super.key});

  final Map<String, dynamic> props;

  Future<void> _openedLink(String href) async {
    final uri = Uri.parse(href);
    await launchUrl(uri);
  }

  @override
  Widget build(BuildContext context) {
    final variant = props['variant'] as String? ?? 'default';
    final content = props['content'] as String? ?? '';
    final href = props['href'] as String?;

    if (variant == 'link') {
      return GestureDetector(
        onTap: href == null ? null : () => _openedLink(href),
        child: Text(
          content,
          style: const TextStyle(
            color: PocColors.primary,
            fontSize: PocTypography.bodySize,
            height: 1.55,
            decoration: TextDecoration.none,
          ),
        ),
      );
    }

    return Text(
      content,
      style: const TextStyle(color: PocColors.text, fontSize: PocTypography.bodySize, height: 1.55),
    );
  }
}
