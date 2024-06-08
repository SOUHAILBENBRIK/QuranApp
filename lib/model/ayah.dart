// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names
import 'dart:convert';

class Ayah {
  int id;
  String text_imlaei;
  
  String verse_key;
  Ayah({
    required this.id,
    required this.text_imlaei,
    required this.verse_key,
  });

  Ayah copyWith({
    int? id,
    String? text_imlaei,
    String? verse_key,
  }) {
    return Ayah(
      id: id ?? this.id,
      text_imlaei: text_imlaei ?? this.text_imlaei,
      verse_key: verse_key ?? this.verse_key,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'text_imlaei': text_imlaei,
      'verse_key': verse_key,
    };
  }

  factory Ayah.fromMap(Map<String, dynamic> map) {
    return Ayah(
      id: map['id'] as int,
      text_imlaei: map['text_imlaei'] as String,
      verse_key: map['verse_key'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Ayah.fromJson(String source) =>
      Ayah.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Ayah(id: $id, text_imlaei: $text_imlaei, verse_key: $verse_key)';

  @override
  bool operator ==(covariant Ayah other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.text_imlaei == text_imlaei &&
      other.verse_key == verse_key;
  }

  @override
  int get hashCode => id.hashCode ^ text_imlaei.hashCode ^ verse_key.hashCode;
}
