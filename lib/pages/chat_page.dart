part of 'pages.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text(
                "Chat",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              )
            ]),
            const SizedBox(height: 10),
            chatTile(context),
            chatTile(context),
            chatTile(context),
            chatTile(context),
            chatTile(context),
            chatTile(context),
            chatTile(context),
            chatTile(context),
            chatTile(context),
            chatTile(context),
            chatTile(context),
            chatTile(context),
          ],
        ),
      ),
    );
  }

  ListTile chatTile(BuildContext context) {
    return ListTile(
      onTap: () {
        setState(() {
          Navigator.pushNamed(context, "/chat");
        });
      },
      leading: Container(
        width: 40,
        height: 40,
        margin: EdgeInsets.only(right: 7),
        decoration: BoxDecoration(color: Colors.amber, shape: BoxShape.circle),
      ),
      title: Padding(
        padding: const EdgeInsets.only(bottom: 5),
        child: Text("Name"),
      ),
      subtitle: Text("Message"),
      trailing: Text("12.39"),
      dense: true,
    );
  }
}