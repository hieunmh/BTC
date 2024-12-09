import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final _openAI = OpenAI.instance.build(
      token: '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',
      baseOption: HttpSetup(receiveTimeout: const Duration(seconds: 5)),
      enableLog: true);

  final ChatUser _currentUser = ChatUser(
    id: '1',
    firstName: "Vincent",
    lastName: "Test",
  );

  final ChatUser _chatGPT = ChatUser(
    id: '2',
    firstName: "Chat",
    lastName: "GPT",
  );

  List<ChatMessage> _messages = <ChatMessage>[];
  List<ChatUser> _typingUser = <ChatUser>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: const Text(
          'Assistant Chat',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: DashChat(
        currentUser: _currentUser,
        typingUsers: _typingUser,
        messageOptions: MessageOptions(
          currentUserContainerColor: Colors.blueAccent,
          currentUserTextColor: Colors.white,
          containerColor: Colors.grey[300]!,
          textColor: Colors.black,
          
        ),
        onSend: (ChatMessage m) {
          getChatResponse(m);
        },
        messages: _messages,
      ),
    );
  }

  Future<void> getChatResponse(ChatMessage m) async {
    setState(() {
      _messages.insert(0, m);
      _typingUser.add(_chatGPT);
    });

    List<Map<String, dynamic>> _messagesHistory = _messages.reversed.map((m) {
      if (m.user == _currentUser) {
        return Messages(role: Role.user, content: m.text).toJson();
      } else {
        return Messages(role: Role.assistant, content: m.text).toJson();
      }
    }).toList();

    final request = ChatCompleteText(
      model: GptTurboChatModel(),
      messages: _messagesHistory,
      maxToken: 300,
    );

    final response = await _openAI.onChatCompletion(request: request);
    for (var element in response!.choices) {
      if (element.message != null) {
        setState(() {
          _messages.insert(
            0,
            ChatMessage(
              text: element.message!.content,
              user: _chatGPT,
              createdAt: DateTime.now(),
            ),
          );
        });
      }
    }
    setState(() {
      _typingUser.remove(_chatGPT);
    });
  }

  Future<void> sendMessage(String text) async {}
}
