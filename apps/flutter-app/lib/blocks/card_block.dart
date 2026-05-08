import 'package:flutter/material.dart';
import 'package:poc_design_tokens/tokens.dart';

import '../generated/sdui_contracts.dart';

class CardBlock extends StatelessWidget {
  const CardBlock({
    required this.props,
    super.key,
  });

  final CardProps props;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(PocSpacing.md),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: PocColors.border),
        borderRadius: BorderRadius.circular(PocRadius.md),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            props.title,
            style: const TextStyle(
              color: PocColors.text,
              fontSize: 18,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: PocSpacing.xs),
          Text(
            props.description,
            style: const TextStyle(
              color: PocColors.muted,
              fontSize: PocTypography.bodySize,
              height: 1.45,
            ),
          ),
        ],
      ),
    );
  }
}
