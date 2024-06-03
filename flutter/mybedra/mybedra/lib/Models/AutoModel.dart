import 'dart:convert';

class AutoModel {
  static List<Autos> autolist = [];

  // Get Item by ID
  // Item getById(int id) =>
  //     items.firstWhere((element) => element.id == id, orElse: null);

  // Get Item by position
  Autos getByPosition(int pos) => autolist[pos];
}

class Autos {
  final String auto_name;
  final String auto_number;
  final String auto_stand;

  Autos({
    required this.auto_name,
    required this.auto_number,
    required this.auto_stand,
  });

  Autos copyWith({
    required String auto_name,
    required String name,
    required String auto_stand,
  }) {
    return Autos(
      auto_name: auto_name,
      auto_number: auto_number,
      auto_stand: auto_stand,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'auto_name': auto_name,
      'auto_number': auto_number,
      'desc': auto_stand,
    };
  }

  factory Autos.fromMap(Map<String, dynamic> map) {
    return Autos(
      auto_name: map['auto_name'],
      auto_number: map['auto_number'],
      auto_stand: map['auto_stand'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Autos.fromJson(String source) => Autos.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Autos(auto_name: $auto_name, auto_number: $auto_number, auto_stand: $auto_stand';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Autos &&
        o.auto_name == auto_name &&
        o.auto_number == auto_number &&
        o.auto_stand == auto_stand;
  }

  @override
  int get hashCode {
    return auto_name.hashCode ^ auto_number.hashCode ^ auto_stand.hashCode;
  }
}
