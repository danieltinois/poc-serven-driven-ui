import 'package:flutter/material.dart';
import 'package:poc_design_tokens/tokens.dart';

import '../generated/sdui_contracts.dart';

class HeroBlock extends StatelessWidget {
  const HeroBlock({
    required this.props,
    super.key,
  });

  final HeroProps props;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(PocSpacing.xl),
      decoration: BoxDecoration(
        color: PocColors.primary,
        borderRadius: BorderRadius.circular(PocRadius.lg),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            props.title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: PocTypography.titleSize,
              fontWeight: FontWeight.w800,
            ),
          ),
          if (props.subtitle?.isNotEmpty == true) ...[
            const SizedBox(height: PocSpacing.sm),
            Text(
              props.subtitle!,
              style: const TextStyle(
                color: Colors.white,
                fontSize: PocTypography.bodySize,
                height: 1.4,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
