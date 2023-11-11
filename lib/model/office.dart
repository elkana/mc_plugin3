import 'dart:convert';

class Office {
  String? id;
  String? name;
  String? address;
  String? city;
  String? zipCode;
  String? phone1;
  String? officeType;
  String? status;
  Office({
    this.id,
    this.name,
    this.address,
    this.city,
    this.zipCode,
    this.phone1,
    this.officeType,
    this.status,
  });

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'address': address,
        'city': city,
        'zipCode': zipCode,
        'phone1': phone1,
        'officeType': officeType,
        'status': status,
      };

  factory Office.fromMap(Map<String, dynamic> map) => Office(
        id: map['id'],
        name: map['name'],
        address: map['address'],
        city: map['city'],
        zipCode: map['zipCode'],
        phone1: map['phone1'],
        officeType: map['officeType'],
        status: map['status'],
      );

  String toJson() => json.encode(toMap());

  factory Office.fromJson(String source) => Office.fromMap(json.decode(source));

  @override
  String toString() =>
      'Office(id: $id, name: $name, address: $address, city: $city, zipCode: $zipCode, phone1: $phone1, officeType: $officeType, status: $status)';
}
