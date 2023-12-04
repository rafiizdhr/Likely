part of 'pages.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final String currentUserId =
      "dg9FSY7e4WVh8erpJWC9ghdV7wA2"; // Ganti dengan ID pengguna Anda
  late Stream<QuerySnapshot<Map<String, dynamic>>> chatsStream;

  @override
  void initState() {
    super.initState();

    chatsStream = FirebaseFirestore.instance
        .collection('chats')
        .where('anggota', arrayContains: currentUserId)
        .snapshots();

    Provider.of<DataUserProvider>(context, listen: false)
        .fetchOtherUsersChats(currentUserId);
  }

  @override
  Widget build(BuildContext context) {
    var otherUsers = Provider.of<DataUserProvider>(context).otherUsers;
    var lebar = MediaQuery.of(context).size.width;
    var tinggi = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        width: lebar,
        height: tinggi,
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
        child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: chatsStream,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return Center(
                child: Text(
                  'Tidak ada obrolan.',
                  style: TextStyle(fontSize: 18),
                ),
              );
            } else {
              List<Widget> chatTiles =
                  List.generate(otherUsers.length, (index) {
                DataUser userData = otherUsers[index];
                String chatSnapshot = snapshot.data!.docs[index].id;

                return chatTile(
                  context,
                  userData.nama!,
                  userData.id!,
                  chatSnapshot,
                );
              }).toList();

              return SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Chat",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 10),
                    ...chatTiles,
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }

  Padding chatTile(
    BuildContext context,
    String chatName,
    String otherUserId,
    String docsid,
    // String lastMessage,
    // String lastMessageTime,
  ) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        onTap: () {
          Navigator.pushNamed(context, "/chat", arguments: {
            'otherUserId': otherUserId,
            'chatName': chatName,
            'chatId': docsid
          });
        },
        leading: Container(
          width: 40,
          height: 40,
          margin: EdgeInsets.only(right: 7),
          decoration: BoxDecoration(
            color: Colors.amber,
            shape: BoxShape.circle,
          ),
        ),
        title: Padding(
          padding: const EdgeInsets.only(bottom: 5),
          child: Text(chatName),
        ),
        // subtitle: Text(lastMessage),
        // trailing: Text(lastMessageTime),
        dense: true,
      ),
    );
  }
}
