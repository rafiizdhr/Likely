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
      appBar: AppBar(
        foregroundColor: Colors.white,
        toolbarHeight: 80,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 25),
            child: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.menu, size: 25),
            ),
          ),
        ],
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

class Swiper extends StatefulWidget {
  @override
  State<Swiper> createState() => _SwiperState();
}

class _SwiperState extends State<Swiper> {
  String currentUserId = "fNCsjYWIcWVqoNFE5e0fQpgB8Sp2";

  int swipeCounter = 0;

  DocumentSnapshot? lastDocument;

  Future<List<DataUser>> fetchData() async {
    int limitPerLoop = 10;

    Query<Map<String, dynamic>> baseQuery =
        FirebaseFirestore.instance.collection('users');

    QuerySnapshot<Map<String, dynamic>> querySnapshot = await baseQuery.get();

    List<DocumentSnapshot<Map<String, dynamic>>> allDocuments =
        querySnapshot.docs;

    // Shuffle the documents
    allDocuments.shuffle();

    // Use the shuffled documents for the current loop
    List<DocumentSnapshot<Map<String, dynamic>>> currentDocuments =
        allDocuments.sublist(0, min(limitPerLoop, allDocuments.length));

    // Update lastDocument for pagination
    lastDocument = currentDocuments.isNotEmpty ? currentDocuments.last : null;

    List<String> likedUserIds = await getLikedUserIds(currentUserId);

    return currentDocuments
        .where(
            (doc) => doc.id != currentUserId && !likedUserIds.contains(doc.id))
        .map((doc) {
      return DataUser(
        id: doc.get('id'),
        nama: doc.get('nama'),
        jenis_kelamin: doc.get('jenis_kelamin'),
        umur: doc.get('umur'),
        foto: doc.get('foto'),
      );
    }).toList();
  }

  Future<void> addLikedUserNameToLikes(
      String currentUserId, String likedUserName, String likedUserIds) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(currentUserId)
        .collection('like')
        .doc(likedUserIds)
        .set({"nama": likedUserName});
  }

  Future<List<String>> getLikedUserIds(String currentUserId) async {
    QuerySnapshot<Map<String, dynamic>> likedUsersQuery =
        await FirebaseFirestore.instance
            .collection('users')
            .doc(currentUserId)
            .collection('like')
            .get();
    return likedUsersQuery.docs.map((doc) => doc.id).toList();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<DataUser>>(
      future: fetchData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
              child: Container(
                  width: 100, height: 100, child: CircularProgressIndicator()));
        } else if (snapshot.hasError) {
          return Center(
              child: Container(
                  width: 100,
                  height: 100,
                  child: Text('Error: ${snapshot.error}')));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(
              child: Container(
                  width: 100,
                  height: 100,
                  child: Text(
                    'User Habis WKWKWK',
                    textAlign: TextAlign.center,
                  )));
        } else {
          List<Kartu> cards = snapshot.data!.map((user) {
            return Kartu(
              warna: Colors.white,
              teks: user.nama ?? "",
            );
          }).toList();

          return AppinioSwiper(
            cardsCount: cards.length,
            cardsBuilder: (BuildContext context, int index) {
              return cards[index];
            },
            swipeOptions: const AppinioSwipeOptions.symmetric(horizontal: true),
            onSwipe: (index, direction) {
              if (direction == AppinioSwiperDirection.right) {
                // Handle right swipe
                String likedUserName = snapshot.data![index - 1].nama ?? "";
                String likedUserIds = snapshot.data![index - 1].id ?? "";
                addLikedUserNameToLikes(
                    currentUserId, likedUserName, likedUserIds);
              }
            },
            onEnd: () {
              fetchData().then((newData) {
                // Update the state with the new data
                setState(() {
                  cards = newData.map((user) {
                    return Kartu(
                      warna: Colors.white,
                      teks: user.nama ?? "",
                    );
                  }).toList();
                });
              });
            },
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
          ]),
      alignment: Alignment.center,
      child: Text(teks),
    );
  }
}
