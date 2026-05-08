import 'package:flutter/material.dart';
import 'package:poc_design_tokens/tokens.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class VideoBlock extends StatefulWidget {
  const VideoBlock({required this.props, super.key});

  final Map<String, dynamic> props;

  @override
  State<VideoBlock> createState() => _VideoBlockState();
}

class _VideoBlockState extends State<VideoBlock> {
  YoutubePlayerController? _controller;

  @override
  void initState() {
    super.initState();

    final videoUrl = widget.props['videoUrl'] as String? ?? widget.props['href'] as String? ?? '';
    final videoId = YoutubePlayerController.convertUrlToId(videoUrl);

    if (videoId == null || videoId.isEmpty) {
      debugPrint('[VideoBlock] ERRO: videoId inválido');
      return;
    }

    final controller = YoutubePlayerController.fromVideoId(
      videoId: videoId,
      autoPlay: false,
      params: const YoutubePlayerParams(
        showControls: true,
        showFullscreenButton: true,
        playsInline: true,
        strictRelatedVideos: true,
        origin: 'https://www.youtube-nocookie.com',
      ),
    );

    _controller = controller;
  }

  @override
  void dispose() {
    _controller?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final content = widget.props['content'] as String? ?? '';

    if (_controller == null) {
      return const Text('URL de vídeo inválida.');
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(PocRadius.md),
          child: YoutubePlayer(
            controller: _controller!,
            aspectRatio: 16 / 9,
          ),
        ),
        const SizedBox(height: PocSpacing.sm),
        if (content.isNotEmpty)
          Text(
            content,
            style: const TextStyle(
              color: PocColors.muted,
              fontSize: PocTypography.bodySize,
              height: 1.5,
            ),
          ),
      ],
    );
  }
}
