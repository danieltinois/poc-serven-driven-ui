import 'package:flutter/material.dart';
import 'package:poc_design_tokens/tokens.dart';
import 'package:url_launcher/url_launcher.dart';

import '../generated/sdui_contracts.dart';

class TextBlock extends StatelessWidget {
  const TextBlock({required this.props, super.key});

  final TextProps props;

  Future<void> _openedLink(String href) async {
    final uri = Uri.parse(href);
    await launchUrl(uri);
  }

  @override
  Widget build(BuildContext context) {
    if (props.variant == TextVariant.link) {
      return GestureDetector(
        onTap: props.href == null ? null : () => _openedLink(props.href!),
        child: Text(
          props.content,
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
      props.content,
      style: const TextStyle(color: PocColors.text, fontSize: PocTypography.bodySize, height: 1.55),
    );
  }
}
