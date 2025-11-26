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
                left: 82,
                top: 187,
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
                top: 224,
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
                top: 293,
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
                top: 399,
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
                top: 309,
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
                top: 412,
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
                left: 193,
                top: 123,
                child: Container(
                  width: 45,
                  height: 45,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage("https://placehold.co/45x45"),
                      fit: BoxFit.cover,
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