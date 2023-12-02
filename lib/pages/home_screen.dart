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
        automaticallyImplyLeading: false,
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
  String currentUserId = "dg9FSY7e4WVh8erpJWC9ghdV7wA2";

  int swipeCounter = 0;

  DocumentSnapshot? lastDocument;

  Future<List<DataUser>> fetchData() async {
    int randomStartingPoint = Random().nextInt(100);
    int limitPerLoop = 10;

    Query<Map<String, dynamic>> baseQuery =
        FirebaseFirestore.instance.collection('users');

    QuerySnapshot<Map<String, dynamic>> querySnapshot = await baseQuery.get();
    List<DocumentSnapshot<Map<String, dynamic>>> allDocuments =
        querySnapshot.docs;

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

  Future<void> checkAndAddMatch(
      String userId, String likedUserId, String likedUsername) async {
    if (userId != null) {
      final likedDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(likedUserId)
          .collection('like')
          .doc(userId)
          .get();

      if (likedDoc.exists) {
        // Tambahkan ke koleksi "matches" di kedua pengguna
        await FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .collection('matches')
            .doc(likedUserId)
            .set({'nama': likedUsername});

        await FirebaseFirestore.instance
            .collection('users')
            .doc(likedUserId)
            .collection('matches')
            .doc(userId)
            .set({'nama': likedUsername});
      }
    }
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

  Future<bool> checkForMatch(String currentUserId, String likedUserIds) async {
    DocumentSnapshot<Map<String, dynamic>> likedUserDoc =
        await FirebaseFirestore.instance
            .collection('users')
            .doc(likedUserIds)
            .collection('like')
            .doc(currentUserId)
            .get();

    return likedUserDoc.exists;
  }

  Future<void> addMatches(String likedUserIds) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(currentUserId)
        .collection("matches")
        .doc(likedUserIds)
        .set({"timestamp": DateTime.now()});

    await FirebaseFirestore.instance
        .collection('users')
        .doc(likedUserIds)
        .collection("matches")
        .doc(currentUserId)
        .set({"timestamp": DateTime.now()});

    await FirebaseFirestore.instance.collection('chats').doc().set({
      "anggota": {currentUserId, likedUserIds},
    });
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
              warna: Theme.of(context).primaryColor,
              teks: user.nama ?? "",
            );
          }).toList();

          return AppinioSwiper(
            cardsCount: cards.length,
            cardsBuilder: (BuildContext context, int index) {
              return cards[index];
            },
            swipeOptions: const AppinioSwipeOptions.symmetric(horizontal: true),
            onSwipe: (index, direction) async {
              if (direction == AppinioSwiperDirection.right) {
                // Handle right swipe
                String likedUserName = snapshot.data![index - 1].nama ?? "";
                String likedUserIds = snapshot.data![index - 1].id ?? "";
                bool isMatch = await checkForMatch(currentUserId, likedUserIds);

                // Add liked user to 'like' subcollection
                await addLikedUserNameToLikes(
                    currentUserId, likedUserName, likedUserIds);

                // If it's a match, add the current user to the liked user's 'match' subcollection
                if (isMatch) {
                  await addMatches(likedUserIds);
                }
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
        ],
      ),
      alignment: Alignment.center,
      child: Text(teks),
    );
  }
}
