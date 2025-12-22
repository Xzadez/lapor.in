class ManageMemberModel {
  final String id;
  final String firstName;
  final String lastName;
  final String role;
  final String email;

  ManageMemberModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.role,
    required this.email,
  });

  factory ManageMemberModel.fromJson(Map<String, dynamic> json) {
    return ManageMemberModel(
      id: json['id'] ?? '',
      firstName: json['first_name'] ?? '',
      lastName: json['last_name'] ?? '',
      role: json['role'] ?? 'warga',
      email: json['email'] ?? '-',
    );
  }

  String get fullName {
    String full = "$firstName $lastName".trim();
    return full.isEmpty ? "Tanpa Nama" : full;
  }

  String get displayRole {
    // Ubah format teks role agar lebih rapi
    return role.replaceAll('_', ' ').toUpperCase();
  }
}
