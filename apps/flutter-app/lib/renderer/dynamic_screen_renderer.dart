import 'package:flutter/material.dart';
import 'package:poc_design_tokens/tokens.dart';
import 'package:poc_server_driven_ui/blocks/video_block.dart';

import '../blocks/button_block.dart';
import '../blocks/card_block.dart';
import '../blocks/hero_block.dart';
import '../blocks/text_block.dart';
import '../models/dynamic_screen.dart';

class DynamicScreenRenderer extends StatelessWidget {
  const DynamicScreenRenderer({required this.blocks, super.key});

  final List<DynamicBlock> blocks;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: blocks.map(_buildBlock).toList(),
    );
  }

  Widget _buildBlock(DynamicBlock block) {
    final widget = switch (block.type) {
      'hero' => HeroBlock(props: block.props),
      'text' => TextBlock(props: block.props),
      'card' => CardBlock(props: block.props),
      'button' => ButtonBlock(props: block.props),
      'video' => VideoBlock(props: block.props),
      _ => _UnknownBlock(type: block.type),
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
      child: Text('Bloco desconhecido: $type', style: const TextStyle(color: PocColors.muted)),
    );
  }
}
