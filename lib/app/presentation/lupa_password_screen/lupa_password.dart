import 'package:flutter/material.dart';

class LupaPasswordScreen extends StatelessWidget {
  const LupaPasswordScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            width: 430,
            height: 932,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment(0.00, 0.17),
                end: Alignment(1.00, 0.83),
                colors: [const Color(0xFFABBBD2), const Color(0xE55880B5)],
              ),
            ),
            child: Stack(
              children: [
                Positioned(
                  left: 165,
                  top: 85,
                  child: Container(
                    width: 100,
                    height: 100,
                    child: Image.asset('assets/images/logo.png'),
                  ),
                ),
                Positioned(
                  left: 82,
                  top: 210,
                  child: Text(
                    'Selamat Datang Di Lapor.in',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                Positioned(
                  left: 139,
                  top: 247,
                  child: Text(
                    'Silahkan login terlebih dahulu',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 11,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                Positioned(
                  left: 33,
                  top: 316,
                  child: Container(
                    width: 365,
                    height: 45,
                    decoration: ShapeDecoration(
                      color: const Color(0x47D9D9D9),
                      shape: RoundedRectangleBorder(
                        side: BorderSide(width: 1, color: Colors.white),
                        borderRadius: BorderRadius.circular(9),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 33,
                  top: 422,
                  child: Container(
                    width: 365,
                    height: 45,
                    decoration: ShapeDecoration(
                      color: const Color(0xFFD9D9D9),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(9)),
                    ),
                  ),
                ),
                Positioned(
                  left: 50,
                  top: 332,
                  child: SizedBox(
                    width: 76,
                    height: 19,
                    child: Text(
                      'Email Address',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 156,
                  top: 435,
                  child: SizedBox(
                    width: 118,
                    height: 19,
                    child: Text(
                      'Kirim kode OTP',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 34,
                  top: 21,
                  child: Text(
                    '16.05',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontFamily: 'Jomhuria',
                      fontWeight: FontWeight.w400,
                      height: 1.09,
                      letterSpacing: 0.17,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
