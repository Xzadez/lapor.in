import 'package:get/get.dart';
import 'package:laporin/app/routes/app_routes.dart';
import 'package:laporin/app/widgets/custom_snackbar.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProfileController extends GetxController {
  final supabase = Supabase.instance.client;

  var isLoading = true.obs;
  var userProfile = <String, dynamic>{}.obs;

  // Getter untuk Logic Menu (Data Pengurus hanya bisa diakses admin/ketua)
  bool get isAdminOrPengurus {
    final r = (userProfile['role_original'] ?? '').toString().toLowerCase();
    return r.contains('admin') || r.contains('ketua') || r.contains('pengurus');
  }

  @override
  void onInit() {
    super.onInit();
    fetchUserProfile();
  }

  void fetchUserProfile() async {
    try {
      isLoading.value = true;
      final currentUser = supabase.auth.currentUser;

      if (currentUser == null) {
        Get.offAllNamed(AppRoutes.loginScreen);
        return;
      }

      // PERBAIKAN 1: Tambahkan 'role' di dalam .select()
      final data =
          await supabase
              .from('profiles')
              .select(
                'first_name, last_name, birth_day, role, community_id, communities(name)',
              )
              .eq('id', currentUser.id)
              .single();

      String fullName =
          "${data['first_name'] ?? ''} ${data['last_name'] ?? ''}".trim();
      String communityName = "Belum bergabung";

      if (data['communities'] != null) {
        communityName = data['communities']['name'];
      }

      String birthDay = "-";
      if (data['birth_day'] != null) {
        DateTime dt = DateTime.parse(data['birth_day']);
        birthDay = "${dt.day}-${dt.month}-${dt.year}";
      }

      // PERBAIKAN 2: Tambahkan Logika Mapping Role
      String rawRole = (data['role'] ?? 'warga').toString().toLowerCase();
      String displayRole = 'Warga'; // Default awal

      // Cek apakah Admin/Ketua/Pengurus
      if (rawRole == 'admin' ||
          rawRole.contains('ketua') ||
          rawRole == 'pengurus') {
        displayRole = 'Pengurus';
      }

      userProfile.value = {
        'name': fullName.isEmpty ? 'User Tanpa Nama' : fullName,
        'email': currentUser.email,
        'birth_day': birthDay,
        'community_name': communityName,
        'role_display': displayRole, // Data untuk Tampilan (Pengurus/Warga)
        'role_original': rawRole, // Data Asli (admin/ketua_rt/dll)
        'photoUrl': null,
      };
    } catch (e) {
      print("Error Fetch Profile: $e");
      userProfile.value = {
        'name': 'Error memuat data',
        'email': '-',
        'birth_day': '-',
        'community_name': '-',
        'role_display': 'Warga',
        'role_original': 'warga',
      };
    } finally {
      isLoading.value = false;
    }
  }

  void logout() async {
    final user = supabase.auth.currentUser;
    final String email = user?.email ?? '';
    await supabase.auth.signOut();
    Get.offAllNamed(AppRoutes.loginScreen);
    CustomSnackBar.show(message: 'Logout: Sampai jumpa $email', isError: false);
  }
}
