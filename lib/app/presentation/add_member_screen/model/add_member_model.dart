class AddMemberModel {
  String firstName;
  String lastName;
  String role;

  AddMemberModel({
    required this.firstName,
    required this.lastName,
    required this.role,
  });

  // Mengubah Object menjadi JSON (Map) untuk dikirim ke API atau Screen lain
  Map<String, dynamic> toJson() {
    return {'first_name': firstName, 'last_name': lastName, 'role': role};
  }

  // Helper untuk menampilkan nama lengkap (Opsional)
  String get fullName => "$firstName $lastName".trim();

  // Helper untuk menampilkan role yang rapi (Opsional)
  String get displayRole => role.replaceAll('_', ' ').toUpperCase();
}
