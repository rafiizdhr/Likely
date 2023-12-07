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
        title: Text(
          "Likely",
          style: GoogleFonts.poppins(fontSize: 30),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
      ),
      body: Background(
        tinggi: tinggi,
        lebar: lebar,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 80),
          child: Swiper(),
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
  String currentUserId = FirebaseAuth.instance.currentUser!.uid;
  DocumentSnapshot? lastDocument;

  Future<List<DataUser>> fetchData() async {
    int limitPerLoop = 10;

    await Provider.of<DataUserProvider>(context, listen: false)
        .fetchCurrentUser(currentUserId);

    DataUser user =
        Provider.of<DataUserProvider>(context, listen: false).currentUsers;

    Query<Map<String, dynamic>> baseQuery =
        FirebaseFirestore.instance.collection('users');

    QuerySnapshot<Map<String, dynamic>> querySnapshot = await baseQuery.get();
    List<DocumentSnapshot<Map<String, dynamic>>> allDocuments =
        querySnapshot.docs;

    allDocuments.shuffle();

    List<DocumentSnapshot<Map<String, dynamic>>> currentDocuments =
        allDocuments.sublist(0, min(limitPerLoop, allDocuments.length));

    lastDocument = currentDocuments.isNotEmpty ? currentDocuments.last : null;

    List<String> likedUserIds = await getLikedUserIds(currentUserId);

    return currentDocuments
        .where((doc) =>
            doc.id != currentUserId &&
            !likedUserIds.contains(doc.id) &&
            doc.get('jenis_kelamin') != user.jenis_kelamin && doc.get('umur') < user.umur!+10)
        .map((doc) {
      return DataUser(
        id: doc.get('id'),
        nama: doc.get('nama'),
        jenis_kelamin: doc.get('jenis_kelamin'),
        tgl_lahir: doc.get('tgl_lahir'),
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
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(
            child: Text(
              'There\'s no user left',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
          );
        } else {
          List<Kartu> cards = snapshot.data!.map((user) {
            return Kartu(
              warna: Colors.black12,
              user: user,
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
                String likedUserName = snapshot.data![index - 1].nama ?? "";
                String likedUserIds = snapshot.data![index - 1].id ?? "";
                bool isMatch = await checkForMatch(currentUserId, likedUserIds);

                await addLikedUserNameToLikes(
                    currentUserId, likedUserName, likedUserIds);

                if (isMatch) {
                  await addMatches(likedUserIds);
                }
              }
            },
            onEnd: () {
              fetchData().then((newData) {
                setState(() {
                  cards = newData.map((user) {
                    return Kartu(
                      warna: Colors.black12,
                      user: user,
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
  final Color warna;
  final DataUser user;

  Kartu({Key? key, required this.warna, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(color: Colors.black12, spreadRadius: 2, blurRadius: 30),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: Stack(
          children: [

            Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                color: warna,
              ),
            ),

            // Background Image
            Image.network(
              user.foto!,
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
            ),

            Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                color: warna.withOpacity(0.4),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user.nama!,
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 12),
                  Text(
                    '${user.umur} Year',
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

