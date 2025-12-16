// FILE: lib/features/auth/login/models/login_request_model.dart

/// MODEL DATA
/// ---------------------------------------------------
/// Dev Team: Rachmat Mauluddin, Rafly
/// Deskripsi: Mengatur format data yang akan dikirim ke API
/// ---------------------------------------------------

class LoginRequestModel {
  final String email;
  final String password;

  LoginRequestModel({
    required this.email,
    required this.password,
  });

  // Mengubah data menjadi JSON agar bisa dikirim ke API/Backend
  Map<String, dynamic> toJson() {
    return {
      "email": email,
      "password": password,
    };
  }
}
