import 'dart:convert';

class UsedContentModel {
  final String usedContentId;
  final String type;
  final String generation;
  UsedContentModel({
    required this.usedContentId,
    required this.type,
    required this.generation,
  });

  UsedContentModel copyWith({
    String? usedContentId,
    String? type,
    String? generation,
  }) {
    return UsedContentModel(
      usedContentId: usedContentId ?? this.usedContentId,
      type: type ?? this.type,
      generation: generation ?? this.generation,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'usedContentId': usedContentId,
      'type': type,
      'generation': generation,
    };
  }

  factory UsedContentModel.fromMap(Map<String, dynamic> map) {
    return UsedContentModel(
      usedContentId: map['usedContentId'] as String,
      type: map['type'] as String,
      generation: map['generation'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UsedContentModel.fromJson(String source) =>
      UsedContentModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'UsedContentModel(usedContentId: $usedContentId, type: $type, generation: $generation)';

  @override
  bool operator ==(covariant UsedContentModel other) {
    if (identical(this, other)) return true;

    return other.usedContentId == usedContentId &&
        other.type == type &&
        other.generation == generation;
  }

  @override
  int get hashCode =>
      usedContentId.hashCode ^ type.hashCode ^ generation.hashCode;
}
