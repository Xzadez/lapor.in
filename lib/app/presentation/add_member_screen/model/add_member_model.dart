class AddMemberModel {
  String name; // Dulu username, sekarang Name (Nama Lengkap/Label)
  String role;

  AddMemberModel({required this.name, required this.role});

  factory AddMemberModel.fromJson(Map<String, dynamic> json) {
    return AddMemberModel(
      name: json['name'] ?? '',
      role: json['role'] ?? 'warga',
    );
  }

  Map<String, dynamic> toJson() {
    return {'name': name, 'role': role};
  }

  String get displayRole => role.replaceAll('_', ' ').toUpperCase();
}
