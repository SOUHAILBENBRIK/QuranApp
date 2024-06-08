// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ChapterInfo {
  int id;
  int chapter_id;
  String short_text;
  String source;
  ChapterInfo({
    required this.id,
    required this.chapter_id,
    required this.short_text,
    required this.source,
  });

  ChapterInfo copyWith({
    int? id,
    int? chapter_id,
    String? short_text,
    String? source,
  }) {
    return ChapterInfo(
      id: id ?? this.id,
      chapter_id: chapter_id ?? this.chapter_id,
      short_text: short_text ?? this.short_text,
      source: source ?? this.source,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'chapter_id': chapter_id,
      'short_text': short_text,
      'source': source,
    };
  }

  factory ChapterInfo.fromMap(Map<String, dynamic> map) {
    return ChapterInfo(
      id: map['id'] as int,
      chapter_id: map['chapter_id'] as int,
      short_text: map['short_text'] as String,
      source: map['source'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ChapterInfo.fromJson(String source) =>
      ChapterInfo.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ChapterInfo(id: $id, chapter_id: $chapter_id, short_text: $short_text, source: $source)';
  }

  @override
  bool operator ==(covariant ChapterInfo other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.chapter_id == chapter_id &&
      other.short_text == short_text &&
      other.source == source;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      chapter_id.hashCode ^
      short_text.hashCode ^
      source.hashCode;
  }
}
