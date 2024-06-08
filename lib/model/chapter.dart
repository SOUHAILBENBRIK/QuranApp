// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

class ChapterModule {
  String revelation_place;
  int id;
  String name_simple;
  String name_arabic;
  int verses_count;
  ChapterModule({
    required this.revelation_place,
    required this.id,
    required this.name_simple,
    required this.name_arabic,
    required this.verses_count,
  });

  ChapterModule copyWith({
    String? revelation_place,
    int? id,
    String? name_simple,
    String? name_arabic,
    int? verses_count,
  }) {
    return ChapterModule(
      revelation_place: revelation_place ?? this.revelation_place,
      id: id ?? this.id,
      name_simple: name_simple ?? this.name_simple,
      name_arabic: name_arabic ?? this.name_arabic,
      verses_count: verses_count ?? this.verses_count,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'revelation_place': revelation_place,
      'id': id,
      'name_simple': name_simple,
      'name_arabic': name_arabic,
      'verses_count': verses_count,
    };
  }

  factory ChapterModule.fromMap(Map<String, dynamic> map) {
    return ChapterModule(
      revelation_place: map['revelation_place'] as String,
      id: map['id'] as int,
      name_simple: map['name_simple'] as String,
      name_arabic: map['name_arabic'] as String,
      verses_count: map['verses_count'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory ChapterModule.fromJson(String source) =>
      ChapterModule.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ChapterModule(revelation_place: $revelation_place, id: $id, name_simple: $name_simple, name_arabic: $name_arabic, verses_count: $verses_count)';
  }

  @override
  bool operator ==(covariant ChapterModule other) {
    if (identical(this, other)) return true;
  
    return 
      other.revelation_place == revelation_place &&
      other.id == id &&
      other.name_simple == name_simple &&
      other.name_arabic == name_arabic &&
      other.verses_count == verses_count;
  }

  @override
  int get hashCode {
    return revelation_place.hashCode ^
      id.hashCode ^
      name_simple.hashCode ^
      name_arabic.hashCode ^
      verses_count.hashCode;
  }
}
