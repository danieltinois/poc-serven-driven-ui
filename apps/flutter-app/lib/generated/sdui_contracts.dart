// GENERATED FILE. Do not edit manually.
// Source: packages/shared-schema/src/generate-flutter-contracts.ts

enum TextVariant {
  defaultValue,
  link;

  static TextVariant fromJson(String? value) {
    return switch (value) {
      'default' => TextVariant.defaultValue,
      'link' => TextVariant.link,
      _ => TextVariant.defaultValue,
    };
  }
}

enum ButtonVariant {
  primary,
  secondary;

  static ButtonVariant fromJson(String? value) {
    return switch (value) {
      'primary' => ButtonVariant.primary,
      'secondary' => ButtonVariant.secondary,
      _ => ButtonVariant.primary,
    };
  }
}

class DynamicScreen {
  DynamicScreen({
    required this.screen,
    required this.version,
    required this.blocks,
  });

  final String screen;
  final String version;
  final List<DynamicBlockContract> blocks;

  factory DynamicScreen.fromJson(Map<String, dynamic> json) {
    final rawBlocks = json['blocks'] as List<dynamic>? ?? [];

    return DynamicScreen(
      screen: json['screen'] as String? ?? 'unknown',
      version: json['version'] as String? ?? 'unknown',
      blocks: rawBlocks
          .whereType<Map<String, dynamic>>()
          .map(DynamicBlockContract.fromJson)
          .toList(),
    );
  }
}

sealed class DynamicBlockContract {
  const DynamicBlockContract(this.type);

  final String type;

  factory DynamicBlockContract.fromJson(Map<String, dynamic> json) {
    final type = json['type'] as String? ?? 'unknown';
    final props = (json['props'] as Map<String, dynamic>?) ?? {};

    return switch (type) {
      'hero' => HeroBlockContract(HeroProps.fromJson(props)),
      'text' => TextBlockContract(TextProps.fromJson(props)),
      'card' => CardBlockContract(CardProps.fromJson(props)),
      'button' => ButtonBlockContract(ButtonProps.fromJson(props)),
      _ => UnknownBlockContract(type),
    };
  }
}

class HeroBlockContract extends DynamicBlockContract {
  const HeroBlockContract(this.props) : super('hero');

  final HeroProps props;
}

class TextBlockContract extends DynamicBlockContract {
  const TextBlockContract(this.props) : super('text');

  final TextProps props;
}

class CardBlockContract extends DynamicBlockContract {
  const CardBlockContract(this.props) : super('card');

  final CardProps props;
}

class ButtonBlockContract extends DynamicBlockContract {
  const ButtonBlockContract(this.props) : super('button');

  final ButtonProps props;
}

class UnknownBlockContract extends DynamicBlockContract {
  const UnknownBlockContract(super.type);
}

class HeroProps {
  const HeroProps({
    required this.title,
    this.subtitle,
  });

  final String title;
  final String? subtitle;

  factory HeroProps.fromJson(Map<String, dynamic> json) {
    return HeroProps(
      title: json['title'] as String? ?? '',
      subtitle: json['subtitle'] as String?,
    );
  }
}

class TextProps {
  const TextProps({
    required this.content,
    required this.variant,
    this.href,
  });

  final String content;
  final TextVariant variant;
  final String? href;

  factory TextProps.fromJson(Map<String, dynamic> json) {
    return TextProps(
      content: json['content'] as String? ?? '',
      variant: TextVariant.fromJson(json['variant'] as String?),
      href: json['href'] as String?,
    );
  }
}

class CardProps {
  const CardProps({
    required this.title,
    required this.description,
  });

  final String title;
  final String description;

  factory CardProps.fromJson(Map<String, dynamic> json) {
    return CardProps(
      title: json['title'] as String? ?? '',
      description: json['description'] as String? ?? '',
    );
  }
}

class ButtonProps {
  const ButtonProps({
    required this.label,
    required this.variant,
    this.action,
  });

  final String label;
  final ButtonVariant variant;
  final DynamicAction? action;

  factory ButtonProps.fromJson(Map<String, dynamic> json) {
    final rawAction = json['action'];

    return ButtonProps(
      label: json['label'] as String? ?? '',
      variant: ButtonVariant.fromJson(json['variant'] as String?),
      action: rawAction is Map<String, dynamic>
          ? DynamicAction.fromJson(rawAction)
          : null,
    );
  }
}

class DynamicAction {
  const DynamicAction({
    required this.type,
    required this.target,
  });

  final String type;
  final String target;

  factory DynamicAction.fromJson(Map<String, dynamic> json) {
    return DynamicAction(
      type: json['type'] as String? ?? 'unknown',
      target: json['target'] as String? ?? '',
    );
  }
}
