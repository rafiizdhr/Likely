part of 'pages.dart';

class ChatField extends StatefulWidget {
  ChatField({super.key});

  @override
  State<ChatField> createState() => _ChatFieldState();
}

class _ChatFieldState extends State<ChatField> {
  final TextEditingController _messageController = TextEditingController();

  String receiverUserID = "";
  final String currentUserId = "dg9FSY7e4WVh8erpJWC9ghdV7wA2";

  @override
  Widget build(BuildContext context) {
    Map arguments = ModalRoute.of(context)?.settings.arguments as Map;
    receiverUserID = arguments['otherUserId'];
    print(arguments['chatId']);

    var lebar = MediaQuery.of(context).size.width;
    var tinggi = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.amber,
            ),
            SizedBox(width: 10),
            Text(arguments['chatName']),
          ],
        ),
        foregroundColor: Colors.black,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
              child: _buildMessageList(arguments['otherUserId'], currentUserId,
                  arguments['chatId'])),
          _buildMessageInput(arguments['otherUserId'], arguments['chatId'])
        ],
      ),
    );
  }

  Future<void> sendMessages(
      String receiverId, String message, String chatId) async {
    //get current user info
    final Timestamp timestamp = Timestamp.now();

    //create a new message
    Message newMessage = Message(
      senderId: currentUserId,
      receiverId: receiverId,
      timestamp: timestamp,
      message: message,
    );

    List<String> ids = [currentUserId, receiverId];
    ids.sort();
    String chatRoomId = chatId;

    //add new message to database
    await FirebaseFirestore.instance
        .collection("chats")
        .doc(chatRoomId)
        .collection("messages")
        .add(
          newMessage.toMap(),
        );
  }

  void sendMessage(String receive, String chat) async {
    if (_messageController.text.isNotEmpty) {
      await sendMessages(receive, _messageController.text, chat);
      //cleat the controller after sending the message
      _messageController.clear();
    }
  }

  Widget _buildMessageInput(String otherUserId, String chatId) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Row(
        children: [
          //textfield
          Expanded(
            child: TextField(
              controller: _messageController,
              obscureText: false,
              decoration: InputDecoration(
                hintText: "Enter Message",
              ),
            ),
          ),

          //send button
          IconButton(
            onPressed: () => sendMessage(otherUserId, chatId),
            icon: const Icon(Icons.arrow_upward, size: 20),
          )
        ],
      ),
    );
  }

  Stream<QuerySnapshot> getMessages(
      String userId, String otherUserId, String chatId) {
    //construct chat room id from user ids (sorted to ensure it matches the id used when sending )
    List<String> ids = [userId, otherUserId];
    ids.sort();

    return FirebaseFirestore.instance
        .collection("chats")
        .doc(chatId)
        .collection("messages")
        .orderBy("timestamp", descending: false)
        .snapshots();
  }

  Widget _buildMessageList(String receive, String current, String chatId) {
    return StreamBuilder(
      stream: getMessages(current, receive, chatId),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text("Error${snapshot.error}");
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading...");
        }

        return ListView(
          children: snapshot.data!.docs
              .map((document) => _buildMessageItem(document))
              .toList(),
        );
      },
    );
  }

//build message item
  Widget _buildMessageItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;

    // align the message to the right if the sender is the current user, otherwise to the left
    var alignment = (data["senderId"] == currentUserId)
        ? Alignment.centerRight
        : Alignment.centerLeft;

    DateTime awu = data['timestamp'].toDate();

    return Container(
      alignment: alignment,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: (data["senderId"] == currentUserId)
              ? CrossAxisAlignment.end
              : CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.only(
                  right: 50, top: 10, left: 10, bottom: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.blue,
              ),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Text(data['message'],
                      style:
                          const TextStyle(fontSize: 16, color: Colors.white)),
                  Positioned(
                    right: -42,
                    bottom: -5,
                    child: Text(
                        awu.hour.toString() + "." + awu.minute.toString(),
                        style:
                            const TextStyle(fontSize: 12, color: Colors.white)),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
