import 'package:flutter/material.dart';
import 'package:poc_design_tokens/tokens.dart';

import '../generated/sdui_contracts.dart';

class ButtonBlock extends StatelessWidget {
  const ButtonBlock({
    required this.props,
    super.key,
  });

  final ButtonProps props;

  @override
  Widget build(BuildContext context) {
    final isSecondary = props.variant == ButtonVariant.secondary;

    return SizedBox(
      width: double.infinity,
      height: 48,
      child: FilledButton(
        style: FilledButton.styleFrom(
          backgroundColor: isSecondary ? Colors.white : PocColors.primary,
          foregroundColor: isSecondary ? PocColors.primary : Colors.white,
          side: const BorderSide(color: PocColors.primary),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(PocRadius.md),
          ),
        ),
        onPressed: () {
          final target = props.action?.target ?? 'sem destino';
          debugPrint('Acao do botao: $target');
        },
        child: Text(props.label),
      ),
    );
  }
}
