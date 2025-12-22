import 'package:get/get.dart';
import 'package:laporin/app/routes/app_routes.dart';
import 'package:laporin/app/widgets/custom_snackbar.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProfileController extends GetxController {
  final supabase = Supabase.instance.client;

  // Variable Observable untuk menampung data user
  var isLoading = true.obs;
  var userProfile = <String, dynamic>{}.obs;

  @override
  void onInit() {
    super.onInit();
    fetchUserProfile();
  }

  // --- FUNGSI AMBIL DATA PROFIL ---
  void fetchUserProfile() async {
    try {
      isLoading.value = true;
      final currentUser = supabase.auth.currentUser;

      if (currentUser == null) {
        Get.offAllNamed(AppRoutes.loginScreen);
        return;
      }

      // Query ke tabel 'profiles'
      // Kita gunakan select('*, communities(name)') untuk join otomatis ke tabel komunitas
      // Syarat: Kolom community_id di profiles harus Foreign Key ke communities
      final data =
          await supabase
              .from('profiles')
              .select(
                'first_name, last_name, birth_day, community_id, communities(name)',
              )
              .eq('id', currentUser.id)
              .single();

      // Format Data agar siap ditampilkan
      String fullName =
          "${data['first_name'] ?? ''} ${data['last_name'] ?? ''}".trim();
      String communityName = "Belum bergabung";

      // Cek apakah ada data komunitas (karena join mengembalikan Map/JSON)
      if (data['communities'] != null) {
        communityName = data['communities']['name'];
      }

      // Format Tanggal Lahir (Misal: 1990-01-01)
      String birthDay = "-";
      if (data['birth_day'] != null) {
        DateTime dt = DateTime.parse(data['birth_day']);
        // Jika pakai intl: DateFormat('dd MMMM yyyy').format(dt);
        // Manual sederhana:
        birthDay = "${dt.day}-${dt.month}-${dt.year}";
      }

      // Update value userProfile
      userProfile.value = {
        'name': fullName.isEmpty ? 'User Tanpa Nama' : fullName,
        'email': currentUser.email, // Email ambil langsung dari Auth
        'birth_day': birthDay,
        'community_name': communityName,
        'photoUrl': null, // Nanti bisa diupdate jika ada fitur upload foto
      };
    } catch (e) {
      print("Error Fetch Profile: $e");
      // Fallback jika error (misal belum setup foreign key communities)
      userProfile.value = {
        'name': 'Error memuat data',
        'email': '-',
        'birth_day': '-',
        'community_name': '-',
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
