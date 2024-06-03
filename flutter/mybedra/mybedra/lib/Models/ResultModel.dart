import 'dart:convert';

class ResultModel {
  static List<Result> resultList = [];

  // Get Item by ID
  // Item getById(int id) =>
  //     items.firstWhere((element) => element.id == id, orElse: null);

  // Get Item by position
  Result getByPosition(int pos) => resultList[pos];
}

class Result {
  final String name;
  final String contact1;
  final String contact2;
  final String category;
  final String imgPath;

  Result({
    required this.name,
    required this.contact1,
    required this.contact2,
    required this.category,
    required this.imgPath,
  });

  Result copyWith({
    required String name,
    required String contact1,
    required String contact2,
    required String category,
    required String imgPath,
  }) {
    return Result(
        name: name,
        contact1: contact1,
        contact2: contact2,
        category: category,
        imgPath: imgPath);
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'contact1': contact1,
      'contact2': contact2,
      'category': category,
      'imgPath': imgPath
    };
  }

  factory Result.fromMap(Map<String, dynamic> map) {
    return Result(
      name: map['name'],
      contact1: map['contact1'],
      contact2: map['contact2'],
      category: map['category'],
      imgPath: map['imgPath'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Result.fromJson(String source) => Result.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Result(name: $name, contact1: $contact1, contact2: $contact2, category: $category, imgPath: $imgPath';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Result &&
        o.name == name &&
        o.contact1 == contact1 &&
        o.contact2 == contact2 &&
        o.category == category &&
        o.imgPath == imgPath;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        contact1.hashCode ^
        contact2.hashCode ^
        category.hashCode ^
        imgPath.hashCode;
  }
}
