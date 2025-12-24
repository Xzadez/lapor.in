class InvitationModel {
  String? id;
  String code;
  String name;
  String role;
  String communityId;
  String createdBy;
  String status;
  DateTime expiresAt;
  DateTime? createdAt;

  InvitationModel({
    this.id,
    required this.code,
    required this.name,
    required this.role,
    required this.communityId,
    required this.createdBy,
    required this.status,
    required this.expiresAt,
    this.createdAt,
  });

  // Factory: Dari JSON (Database) ke Object Dart
  factory InvitationModel.fromJson(Map<String, dynamic> json) {
    return InvitationModel(
      id: json['id'],
      code: json['code'] ?? '',
      name: json['name'] ?? '',
      role: json['role'] ?? 'warga',
      communityId: json['community_id'] ?? '',
      createdBy: json['created_by'] ?? '',
      status: json['status'] ?? 'pending',
      expiresAt: DateTime.parse(json['expires_at']),
      createdAt:
          json['created_at'] != null
              ? DateTime.parse(json['created_at'])
              : null,
    );
  }

  // Method: Dari Object Dart ke JSON (untuk Insert ke Database)
  Map<String, dynamic> toJson() {
    return {
      // id tidak dikirim karena auto-generate uuid
      'code': code,
      'name': name,
      'role': role,
      'community_id': communityId,
      'created_by': createdBy,
      'status': status,
      'expires_at': expiresAt.toIso8601String(),
    };
  }
}
