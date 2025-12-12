import 'package:get/get.dart';
import 'package:laporin/app/routes/app_routes.dart';
import 'package:laporin/app/widgets/custom_snackbar.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProfileController extends GetxController {
  var user =
      {
        'name': 'Ahmad Sentosa',
        'email': 'Ahmadsanzz@gmail.com',
        'photoUrl': null,
      }.obs;

  void logout() async {
    final user = Supabase.instance.client.auth.currentUser;
    final String username = user?.userMetadata?['username'] ?? '';
    await Supabase.instance.client.auth.signOut();
    Get.offAllNamed(AppRoutes.loginScreen);
    CustomSnackBar.show(
      message: 'Logout: Kamu telah keluar dari akun $username',
      isError: false,
    );
  }
}
