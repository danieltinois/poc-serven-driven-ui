import 'package:flutter/material.dart';
import 'package:poc_design_tokens/tokens.dart';

class HeroBlock extends StatelessWidget {
  const HeroBlock({
    required this.props,
    super.key,
  });

  final Map<String, dynamic> props;

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
            props['title'] as String? ?? '',
            style: const TextStyle(
              color: Colors.white,
              fontSize: PocTypography.titleSize,
              fontWeight: FontWeight.w800,
            ),
          ),
          if ((props['subtitle'] as String?)?.isNotEmpty == true) ...[
            const SizedBox(height: PocSpacing.sm),
            Text(
              props['subtitle'] as String,
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
