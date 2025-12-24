import 'package:get/get.dart';
import 'package:laporin/app/routes/app_routes.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../model/manage_member_model.dart'; // Pastikan nama file model disesuaikan

class ManageMemberController extends GetxController {
  final supabase = Supabase.instance.client;

  var isLoading = true.obs;
  var memberList = <ManageMemberModel>[].obs;

  String currentUserId = '';

  @override
  void onInit() {
    super.onInit();
    currentUserId = supabase.auth.currentUser?.id ?? '';
    fetchMemberList();
  }

  void fetchMemberList() async {
    try {
      isLoading.value = true;
      final user = supabase.auth.currentUser;
      if (user == null) return;

      // 1. Ambil community_id user yang login
      final myProfile =
          await supabase
              .from('profiles')
              .select('community_id')
              .eq('id', user.id)
              .single();

      final commId = myProfile['community_id'];

      if (commId == null) {
        memberList.clear();
        return;
      }

      // 2. Ambil SEMUA profile dalam komunitas (Tanpa filter role)
      final data = await supabase
          .from('profiles')
          .select('id, first_name, last_name, role, email')
          .eq('community_id', commId)
          // Urutkan: Admin/Ketua di atas, Warga di bawah
          .order('role', ascending: true);

      final List<dynamic> responseData = data;

      // Mapping ke Model
      memberList.value =
          responseData.map((json) => ManageMemberModel.fromJson(json)).toList();
    } catch (e) {
      print("Error fetch member: $e");
      Get.snackbar("Gagal", "Gagal memuat daftar anggota");
    } finally {
      isLoading.value = false;
    }
  }

  void onTapAddMember() {
    Get.toNamed(AppRoutes.addMember);
  }
}
