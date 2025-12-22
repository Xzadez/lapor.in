//
class CommunityModel {
  String? id;
  String name;
  String rt;
  String rw;
  String address;
  String city;
  String createdBy;

  CommunityModel({
    this.id,
    required this.name,
    required this.rt,
    required this.rw,
    required this.address,
    required this.city,
    required this.createdBy,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'rt': rt,
      'rw': rw,
      'address': address,
      'city': city,
      'created_by': createdBy,
    };
  }
}
