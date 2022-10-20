import 'package:video_example/src/hls/audio_track.dart';
import 'package:video_example/src/hls/subtitle.dart';
import 'package:video_example/src/hls/variant_playlist.dart';

class HlsMasterPlaylist {
  final List<VariantPlaylist> variants;
  final List<Subtitle> subtitles;
  final List<AudioTrack> audios;
  HlsMasterPlaylist({
    required this.variants,
    required this.subtitles,
    required this.audios,
  });
}
