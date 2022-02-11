class Mention {
  final String? index;
  final String? denotationChar;
  final String? id;
  final String? value;
  final String? target;

  Mention({this.index, this.denotationChar, this.id, this.value, this.target});

  factory Mention.fromJson(Map<String, dynamic> map) {
    return Mention(
      index: map['index'],
      denotationChar: map['denotationChar'],
      id: map['id'],
      value: map['value'],
      target: map['target'],
    );
  }

  String toPlainText() {
    return '$denotationChar$value';
  }
}
