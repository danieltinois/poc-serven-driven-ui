import 'package:flutter/material.dart';
import 'package:poc_design_tokens/tokens.dart';

class ButtonBlock extends StatelessWidget {
  const ButtonBlock({required this.props, super.key});

  final Map<String, dynamic> props;

  @override
  Widget build(BuildContext context) {
    final variant = props['variant'] as String? ?? 'primary';
    final label = props['label'] as String? ?? '';
    final isSecondary = variant == 'secondary';

    return SizedBox(
      width: double.infinity,
      height: 48,
      child: FilledButton(
        style: FilledButton.styleFrom(
          backgroundColor: isSecondary ? Colors.white : PocColors.primary,
          foregroundColor: isSecondary ? PocColors.primary : Colors.white,
          side: const BorderSide(color: PocColors.primary),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(PocRadius.md)),
        ),
        onPressed: () {
          final action = props['action'] as Map<String, dynamic>?;
          final target = action?['target'] as String? ?? 'sem destino';
          debugPrint('Acao do botao: $target');
        },
        child: Text(label),
      ),
    );
  }
}
