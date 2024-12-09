import 'package:btc/controllers/app/application_controller.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';

class ChatController extends GetxController {
  final ApplicationController appcontroller = Get.find<ApplicationController>();

  late final ChatUser userchat;
  late final ChatUser gptchat;
  late final OpenAI openai;

  RxList<ChatMessage> messages = <ChatMessage>[].obs;
  RxList<ChatUser> typingUser = <ChatUser>[].obs;

  @override
  void onInit() {
    super.onInit();
    connectChatGPT();
    userchat = ChatUser(
      id: appcontroller.userId.value,
      firstName: appcontroller.userEmail.value,
    );
    gptchat = ChatUser(
      id: '2',
      firstName: 'GPT',
    );
  }

  void connectChatGPT() async {
    await dotenv.load(fileName: '.env');
    final openaiApiKey = dotenv.env['OPENAI_API_KEY'];

    openai = OpenAI.instance.build(
      token: openaiApiKey,
      baseOption: HttpSetup(receiveTimeout: const Duration(seconds: 5)),
      enableLog: true
    );
  }

  Future<void> getChatResponse(ChatMessage m) async {
    messages.insert(0, m);
    typingUser.add(gptchat);

    List<Map<String, dynamic>> messagesHistory = messages.reversed.map((m) {
      if (m.user == userchat) {
        return Messages(role: Role.user, content: m.text).toJson();
      } else {
        return Messages(role: Role.assistant, content: m.text).toJson();
      }
    }).toList();

    final request = ChatCompleteText(
      model: GptTurboChatModel(),
      messages: messagesHistory,
      maxToken: 300,
    );

    final response = await openai.onChatCompletion(request: request);
    for (var element in response!.choices) {
      if (element.message != null) {
        messages.insert(0, ChatMessage(
          text: element.message!.content, 
          user: gptchat,
          createdAt: DateTime.now()
        ));
      }
    }
  }

}