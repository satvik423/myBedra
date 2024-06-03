import 'dart:convert';

class AutoStandModel {
  static List<AutoStand> autoStandlist = [];

  // Get Item by ID
  // Item getById(int id) =>
  //     items.firstWhere((element) => element.id == id, orElse: null);

  // Get Item by position
  AutoStand getByPosition(int pos) => autoStandlist[pos];
}

class AutoStand {
  final String data;

  AutoStand({
    required this.data,
  });

  AutoStand copyWith({
    required String auto_stand,
  }) {
    return AutoStand(
      data: data,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'data': data,
    };
  }

  factory AutoStand.fromMap(Map<String, dynamic> map) {
    return AutoStand(
      data: map['data'],
    );
  }

  String toJson() => json.encode(toMap());

  factory AutoStand.fromJson(String source) =>
      AutoStand.fromMap(json.decode(source));

  @override
  String toString() {
    return '$data';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is AutoStand && o.data == data;
  }

  @override
  int get hashCode {
    return data.hashCode;
  }
}
