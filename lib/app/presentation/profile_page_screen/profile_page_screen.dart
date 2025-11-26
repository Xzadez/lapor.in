class  extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 430,
          height: 932,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(color: Colors.white),
          child: Stack(
            children: [
              Positioned(
                left: 0,
                top: 860,
                child: Container(
                  width: 430,
                  height: 87,
                  decoration: ShapeDecoration(
                    color: const Color(0xFF356FBB),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 343,
                top: 838,
                child: Container(
                  width: 59,
                  height: 59,
                  decoration: ShapeDecoration(
                    color: const Color(0xFF356FBB),
                    shape: OvalBorder(),
                  ),
                ),
              ),
              Positioned(
                left: 54,
                top: 904,
                child: Text(
                  'Beranda',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Positioned(
                left: 158,
                top: 905,
                child: Text(
                  'Laporan',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Positioned(
                left: 261,
                top: 905,
                child: Text(
                  'Riwayat',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Positioned(
                left: 357,
                top: 911,
                child: Text(
                  'Profile',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Positioned(
                left: 117,
                top: 90,
                child: Text(
                  'Ahmad Sentosa',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              Positioned(
                left: 117,
                top: 115,
                child: Text(
                  'Ahmadsanzz@gmail.com',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Positioned(
                left: 80,
                top: 210,
                child: Text(
                  'ahmadsanzz@gmail.com',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontFamily: 'Instrument Sans',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Positioned(
                left: 85,
                top: 254,
                child: Text(
                  'Logout',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontFamily: 'Instrument Sans',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Positioned(
                left: 34,
                top: 21,
                child: Text(
                  '16.05',
                  style: TextStyle(
                    color: Colors.black,
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