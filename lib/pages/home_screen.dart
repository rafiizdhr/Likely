part of 'pages.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    var lebar = MediaQuery.of(context).size.width;
    var tinggi = MediaQuery.of(context).size.height;

    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      endDrawer: MyDrawer(),
      appBar: AppBar(
        foregroundColor: Colors.white,
        toolbarHeight: 80,
        // actions: [
        //   Padding(
        //     padding: const EdgeInsets.only(right: 25),
        //     child: IconButton(
        //       onPressed: drwr,
        //       icon: const Icon(Icons.menu, size: 25),
        //     ),
        //   ),
        // ],
        title: const Text(
          "Likely",
          style: TextStyle(fontSize: 30),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
      ),
      body: Container(
        height: tinggi,
        width: lebar,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 80),
          child: Swiper(),
        ),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF7512B2),
              Color(0xFFBD94D7),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
      ),
    );
  }
}

class Swiper extends StatelessWidget {
  Future<List<DataUser>> fetchData() async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await FirebaseFirestore.instance.collection('users').get();

    return querySnapshot.docs.map((doc) {
      return DataUser(
        nama: doc['nama'],
        gender: doc['jenis_kelamin'],
        umur: doc['umur'],
        foto: doc['foto'],
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<DataUser>>(
      future: fetchData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          List<Kartu> cards = snapshot.data!.map((user) {
            return Kartu(
              warna: Colors.white,
              teks: user.nama ?? "",
            );
          }).toList();

          return AppinioSwiper(
            cardsCount: cards.length,
            onSwiping: (AppinioSwiperDirection direction) {
              print(direction.toString());
            },
            cardsBuilder: (BuildContext context, int index) {
              return cards[index];
            },
            swipeOptions: const AppinioSwipeOptions.symmetric(horizontal: true),
            onSwipe: (index, direction) {
              if (direction == AppinioSwiperDirection.right) {
                // Handle right swipe
              }
            },
            loop: true,
          );
        }
      },
    );
  }
}

class Kartu extends StatelessWidget {
  Color warna;
  String teks;

  Kartu({super.key, required this.warna, required this.teks});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: warna,
        boxShadow: [
          BoxShadow(color: Colors.black12, spreadRadius: 1, blurRadius: 30)
        ],
      ),
      alignment: Alignment.center,
      child: Text(teks),
    );
  }
}
