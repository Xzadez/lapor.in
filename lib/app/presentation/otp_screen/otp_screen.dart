class  extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
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
                left: 59,
                top: 167,
                child: Text(
                  'Lupa password?\nTenang aja akun anda aman kok',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              Positioned(
                left: 82,
                top: 316,
                child: Text(
                  'Silahkan masukkan kode',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 11,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Positioned(
                left: 96,
                top: 348,
                child: Container(
                  width: 46,
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
                left: 160,
                top: 348,
                child: Container(
                  width: 46,
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
                left: 224,
                top: 348,
                child: Container(
                  width: 46,
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
                left: 288,
                top: 348,
                child: Container(
                  width: 46,
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
                left: 96,
                top: 430,
                child: Container(
                  width: 238,
                  height: 45,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFD9D9D9),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(9)),
                  ),
                ),
              ),
              Positioned(
                left: 179,
                top: 443,
                child: SizedBox(
                  width: 72,
                  height: 19,
                  child: Text(
                    'Verifikasi',
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
    );
  }
}