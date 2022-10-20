import 'dart:convert';
import 'package:video_example/src/hls/audio_track.dart';
import 'package:video_example/src/hls/subtitle.dart';
import 'hls_master_playlist.dart';
import 'variant_playlist.dart';

class HlsParser {
  static const String tagStreamInf = '#EXT-X-STREAM-INF';
  static const String tagMedia = '#EXT-X-MEDIA';

  static const String regexpResolutions = 'RESOLUTION=(\\d+x\\d+)';
  static const String regexpSubtitles = 'SUBTITLES="(.+?)"';
  static const String regexpClosedCaptions = 'CLOSED-CAPTIONS="(.+?)"';
  static const String regexpAudio = 'AUDIO="(.+?)"';
  static const String regexpLanguage = 'LANGUAGE="(.+?)"';
  static const String regexpUri = 'URI="(.+?)"';
  static const String regexpName = 'NAME="(.+?)"';
  static const String typeSubtitles = 'TYPE=SUBTITLES';
  static const String typeAudio = 'TYPE=AUDIO';

  static String? matchPattern(String pattern, variant) {
    return RegExp(pattern).firstMatch(variant)?.group(0);
  }

  static HlsMasterPlaylist parsePlaylist(String url, String hlsFile) {
    url = url.replaceAll(url.split("/").last, "");

    List<VariantPlaylist> variants = [];
    // ignore: unused_local_variable
    List<String> resolutions = [];
    List<Subtitle> subtitles = [];

    List<AudioTrack> audios = [];

    String playlist = hlsFile;
    final List<String> lines = const LineSplitter()
        .convert(playlist)
        .where((line) => line.trim().isNotEmpty)
        .toList();
    for (var i = 0; i < lines.length; i++) {
      if (lines[i].startsWith(tagMedia)) {
        if (lines[i].startsWith(tagMedia + ":" + typeSubtitles)) {
          String? subtitle = matchPattern(regexpUri, lines[i]);
          String? subtitleLanguage = matchPattern(regexpName, lines[i]);
          if (subtitle != null && subtitleLanguage != null) {
            subtitles.add(Subtitle(url: subtitle, language: subtitleLanguage));
          }
        } else if (lines[i].startsWith(tagMedia + ":" + typeAudio)) {
          String? audioLanguage = matchPattern(regexpLanguage, lines[i]);
          String? audioUri = matchPattern(regexpUri, lines[i]) ?? "DEFAULT";
          if (audioLanguage != null) {
            audios.add(AudioTrack(url: audioUri, language: audioLanguage));
          }
        }
      }

      if (lines[i].startsWith(tagStreamInf)) {
        String variant = lines[i];
        String variantUri = url + lines[i + 1];
        String? variantResolution = matchPattern(regexpResolutions, variant);
        if (variantResolution != null)
          variantResolution = variantResolution.substring(
              variantResolution.indexOf("x") + 1, variantResolution.length);
        variants.add(VariantPlaylist(
            url: variantUri,
            format: variantResolution,
            subtitle: "",
            audio: ""));
      }
    }

    return HlsMasterPlaylist(
        variants: variants, subtitles: subtitles, audios: audios);
  }
}
