import 'package:flutter/material.dart';
import 'package:poc_design_tokens/tokens.dart';

import '../blocks/button_block.dart';
import '../blocks/card_block.dart';
import '../blocks/hero_block.dart';
import '../blocks/text_block.dart';
import '../generated/sdui_contracts.dart';

class DynamicScreenRenderer extends StatelessWidget {
  const DynamicScreenRenderer({
    required this.blocks,
    super.key,
  });

  final List<DynamicBlockContract> blocks;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: blocks.map(_buildBlock).toList(),
    );
  }

  Widget _buildBlock(DynamicBlockContract block) {
    final widget = switch (block) {
      HeroBlockContract(:final props) => HeroBlock(props: props),
      TextBlockContract(:final props) => TextBlock(props: props),
      CardBlockContract(:final props) => CardBlock(props: props),
      ButtonBlockContract(:final props) => ButtonBlock(props: props),
      UnknownBlockContract(:final type) => _UnknownBlock(type: type),
    };

    return Padding(
      padding: const EdgeInsets.only(bottom: PocSpacing.md),
      child: widget,
    );
  }
}

class _UnknownBlock extends StatelessWidget {
  const _UnknownBlock({required this.type});

  final String type;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(PocSpacing.md),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: PocColors.border),
        borderRadius: BorderRadius.circular(PocRadius.md),
      ),
      child: Text(
        'Bloco desconhecido: $type',
        style: const TextStyle(color: PocColors.muted),
      ),
    );
  }
}
