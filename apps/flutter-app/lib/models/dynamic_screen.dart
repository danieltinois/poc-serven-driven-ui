class DynamicScreen {
  DynamicScreen({
    required this.screen,
    required this.version,
    required this.blocks,
  });

  final String screen;
  final String version;
  final List<DynamicBlock> blocks;

  factory DynamicScreen.fromJson(Map<String, dynamic> json) {
    final rawBlocks = json['blocks'] as List<dynamic>? ?? [];

    return DynamicScreen(
      screen: json['screen'] as String? ?? 'unknown',
      version: json['version'] as String? ?? 'unknown',
      blocks: rawBlocks
          .whereType<Map<String, dynamic>>()
          .map(DynamicBlock.fromJson)
          .toList(),
    );
  }
}

class DynamicBlock {
  DynamicBlock({
    required this.type,
    required this.props,
  });

  final String type;
  final Map<String, dynamic> props;

  factory DynamicBlock.fromJson(Map<String, dynamic> json) {
    return DynamicBlock(
      type: json['type'] as String? ?? 'unknown',
      props: (json['props'] as Map<String, dynamic>?) ?? {},
    );
  }
}
