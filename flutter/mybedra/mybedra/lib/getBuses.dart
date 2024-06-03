import 'dart:convert';

class busModel {
  static List<Buses> buslist = [];

  // Get Item by ID
  // Item getById(int id) =>
  //     items.firstWhere((element) => element.id == id, orElse: null);

  // Get Item by position
  Buses getByPosition(int pos) => buslist[pos];
}

class Buses {
  final String bus_name;
  final String bus_time;
  final String destination_name;

  Buses({
    required this.bus_name,
    required this.bus_time,
    required this.destination_name,
  });

  Buses copyWith({
    required String bus_name,
    required String name,
    required String destination_name,
  }) {
    return Buses(
      bus_name: bus_name,
      bus_time: bus_time,
      destination_name: destination_name,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'bus_name': bus_name,
      'bus_time': bus_time,
      'desc': destination_name,
    };
  }

  factory Buses.fromMap(Map<String, dynamic> map) {
    return Buses(
      bus_name: map['bus_name'],
      bus_time: map['bus_time'],
      destination_name: map['destination_name'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Buses.fromJson(String source) => Buses.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Buses(busname: $bus_name, bustime: $bus_time, destination: $destination_name';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Buses &&
        o.bus_name == bus_name &&
        o.bus_time == bus_time &&
        o.destination_name == destination_name;
  }

  @override
  int get hashCode {
    return bus_name.hashCode ^ bus_time.hashCode ^ destination_name.hashCode;
  }
}
