import 'mention.dart';

/// An object which can be embedded into a Quill document.
///
/// See also:
///
/// * [BlockEmbed] which represents a block embed.
class Embeddable {
  const Embeddable(this.type, this.data);

  /// The type of this object.
  final String type;

  /// The data payload of this object.
  final dynamic data;

  Map<String, dynamic> toJson() {
    final m = <String, String>{type: data};
    return m;
  }

  static Embeddable fromJson(Map<String, dynamic> json) {
    final m = Map<String, dynamic>.from(json);
    assert(m.length == 1,
        'Embeddable map must only have one key. Origin json is $json');

    // region ---- custom ----
    final key = m.keys.first;
    if (key == BlockEmbed.emojiType) {
      final String emojiCode = (m[key] as Map<String, dynamic>)['unicode'];
      return BlockEmbed(
          key, String.fromCharCode(int.parse(emojiCode, radix: 16)));
    } else if (key == BlockEmbed.mentionType) {
      final mention = Mention.fromJson(m[key] as Map<String, dynamic>);
      return BlockEmbed(key, mention.toPlainText());
    }
    // endregion ---- custom ----

    if (!(m.values.first is String)) {
      return BlockEmbed(m.keys.first, m.values.first.toString());
    } else {
      return BlockEmbed(m.keys.first, m.values.first);
    }
  }
}

/// There are two built-in embed types supported by Quill documents, however
/// the document model itself does not make any assumptions about the types
/// of embedded objects and allows users to define their own types.
class BlockEmbed extends Embeddable {
  const BlockEmbed(String type, String data) : super(type, data);

  static const String imageType = 'image';

  static BlockEmbed image(String imageUrl) => BlockEmbed(imageType, imageUrl);

  static const String videoType = 'video';

  static BlockEmbed video(String videoUrl) => BlockEmbed(videoType, videoUrl);

  static const String emojiType = 'emoji';

  static BlockEmbed emoji(String emojiCode) => BlockEmbed(emojiType, emojiCode);

  static const String mentionType = 'mention';

  static BlockEmbed mention(Mention mention) =>
      BlockEmbed(mentionType, mention.toPlainText());
}
