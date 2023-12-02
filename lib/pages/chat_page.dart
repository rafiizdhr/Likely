part of 'pages.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final String currentUserId =
      "fNCsjYWIcWVqoNFE5e0fQpgB8Sp2"; // Ganti dengan ID pengguna Anda
  late Stream<QuerySnapshot<Map<String, dynamic>>> chatsStream;

  @override
  void initState() {
    super.initState();

    chatsStream = FirebaseFirestore.instance
        .collection('chats')
        .where('anggota', arrayContains: currentUserId)
        .snapshots();
    
    Provider.of<DataUserProvider>(context, listen: false)
        .fetchOtherUsersChats("fNCsjYWIcWVqoNFE5e0fQpgB8Sp2");
  }

  @override
  Widget build(BuildContext context) {
    var otherUsers = Provider.of<DataUserProvider>(context).otherUsers;

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
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
            List<Widget> chatTiles = otherUsers.map((DataUser userData) {
              return chatTile(
                context,
                userData.nama!,
                userData.id!,
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
    );
  }

  ListTile chatTile(
    BuildContext context,
    String chatName,
    String otherUserId,
    // String lastMessage,
    // String lastMessageTime,
  ) {
    return ListTile(
      onTap: () {
        Navigator.pushNamed(context, "/chat", arguments: {
          'otherUserId': otherUserId,
          'chatName': chatName,
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
    );
  }
}
