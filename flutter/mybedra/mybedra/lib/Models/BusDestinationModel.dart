import 'dart:convert';

class BusDestModel {
  static List<BusDestination> Destinationlist = [];

  // Get Item by ID
  // Item getById(int id) =>
  //     items.firstWhere((element) => element.id == id, orElse: null);

  // Get Item by position
  BusDestination getByPosition(int pos) => Destinationlist[pos];
}

class BusDestination {
  final String data;

  BusDestination({
    required this.data,
  });

  BusDestination copyWith({
    required String auto_stand,
  }) {
    return BusDestination(
      data: data,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'data': data,
    };
  }

  factory BusDestination.fromMap(Map<String, dynamic> map) {
    return BusDestination(
      data: map['data'],
    );
  }

  String toJson() => json.encode(toMap());

  factory BusDestination.fromJson(String source) =>
      BusDestination.fromMap(json.decode(source));

  @override
  String toString() {
    return '$data';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is BusDestination && o.data == data;
  }

  @override
  int get hashCode {
    return data.hashCode;
  }
}
