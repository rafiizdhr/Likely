part of 'pages.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  String currentUserId = FirebaseAuth.instance.currentUser!.uid;
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
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: Background(
        lebar: lebar,
        tinggi: tinggi,
        child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: chatsStream,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return Center(
                child: Text(
                  'No Matches',
                  style: TextStyle(fontSize: 20, color: Colors.white),
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
                  userData.foto!,
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

  Future<String> getSenderName(String senderId) async {
    if (senderId != '') {
      DocumentSnapshot<Map<String, dynamic>> userSnapshot =
          await FirebaseFirestore.instance
              .collection('users')
              .doc(senderId)
              .get();

      if (userSnapshot.exists) {
        return userSnapshot['nama'];
      }
    }
    return '';
  }

  Future<Message> getLastMessage(String chatId) async {
    QuerySnapshot<Map<String, dynamic>> messagesSnapshot =
        await FirebaseFirestore.instance
            .collection('chats')
            .doc(chatId)
            .collection('messages')
            .orderBy('timestamp', descending: true)
            .limit(1)
            .get();

    if (messagesSnapshot.docs.isNotEmpty) {
      var lastMessageData = messagesSnapshot.docs.first.data();
      return Message(
        message: lastMessageData['message'],
        senderId: lastMessageData['senderId'],
        receiverId: lastMessageData['receiverId'],
        timestamp: lastMessageData['timestamp'],
      );
    } else {
      return Message(
        message: "No Message Yet",
        senderId: '',
        receiverId: '',
      );
    }
  }

  Padding chatTile(
    BuildContext context,
    String chatName,
    String otherUserId,
    String foto,
    String docsid,
  ) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: FutureBuilder<Message>(
        future: getLastMessage(docsid),
        builder: (context, snapshot) {
          Message lastMessage = snapshot.data ??
              Message(message: '', senderId: '', receiverId: '');

          return FutureBuilder<String>(
            future: getSenderName(lastMessage.senderId),
            builder: (context, senderSnapshot) {
              String senderName = senderSnapshot.data ?? '';

              return ListTile(
                onTap: () {
                  Navigator.pushNamed(context, "/chat", arguments: {
                    'otherUserId': otherUserId,
                    'chatName': chatName,
                    'chatId': docsid,
                    'foto': foto,
                  });
                },
                leading: Container(
                  width: 50,
                  height: 50,
                  margin: EdgeInsets.only(right: 7),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(foto),
                      fit: BoxFit.cover,
                    ),
                    shape: BoxShape.circle,
                  ),
                ),
                title: Text(chatName, style: GoogleFonts.poppins(fontSize: 16)),
                subtitle: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        '$senderName: ${lastMessage.message}',
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text(
                      lastMessage.timestamp != null
                          ? '${lastMessage.timestamp!.toDate().hour}.${lastMessage.timestamp!.toDate().minute}'
                          : '',
                    )
                  ],
                ),
                dense: true,
              );
            },
          );
        },
      ),
    );
  }
}
