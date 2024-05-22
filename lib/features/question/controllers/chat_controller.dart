import 'package:blended_learning_appmb/data/repositories/authentication/authentication_repository.dart';
import 'package:dash_chat_2/dash_chat_2.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../data/repositories/chat/chat_repository.dart';
import '../../personalization/models/user_model.dart';

class ChatController extends GetxController {
  static ChatController get instance => Get.find();
  final deviceStorage = GetStorage();
  final authenticationRepository = AuthenticationRepository.instance;
  List<ChatMessage> messages = <ChatMessage>[].obs;
  final chatRepository = ChatRepository.instance;

  //Future<UserModel> getListUsers(us)

  ChatUser user = ChatUser(
    id: '1',
    firstName: 'Charles',
    lastName: 'Leclerc',
  );


  List<ChatMessage> messagesData = <ChatMessage>[
    ChatMessage(
      text: 'Hey!',
      user: ChatUser(
        id: '2',
        firstName: 'Charles',
        lastName: 'Leclerc',
      ),
      createdAt: DateTime.now(),
    ),
    ChatMessage(
      text: 'Hello!',
      user: ChatUser(
        id: '2',
        firstName: 'Charles',
        lastName: 'Leclerc',
      ),
      createdAt: DateTime.now(),
    ),
  ];

  Future<List<ChatMessage>> fetchMessages(UserModel receiver) async {
    final sender = authenticationRepository.user;
    final ChatUser currentUser = convertToChatUser(sender);
    final ChatUser receiverUser = convertToChatUser(receiver);
    final listMessagesModel =
        await chatRepository.getMessages(sender.id!, receiver.id!);
    final listMessages = await chatRepository.getMessages(receiver.id!, sender.id!);
    List<ChatMessage> messages = [];
    for(var message in listMessagesModel) {
      messages.add(ChatMessage(
        text: message.content!,
        user: message.sendId == sender.id ? currentUser:receiverUser,
        createdAt: DateTime.parse(message.createdAt!),
      ));
    }
    for(var message in listMessages) {
      messages.add(ChatMessage(
        text: message.content!,
        user: message.sendId == sender.id ? currentUser:receiverUser,
        createdAt: DateTime.parse(message.createdAt!),
      ));
    }
    messages.sort((a, b) => b.createdAt.compareTo(a.createdAt));

    return messages;
  }

  ChatUser convertToChatUser(UserModel user) {

    return ChatUser(
      id: user.id!,
      firstName: user.name,
      lastName: user.role,
    );
  }

  ChatUser getCurrentUser() {
  final sender = authenticationRepository.user;
    return convertToChatUser(sender);
  }

  createMessage(String content, UserModel receiver) async {
    final sender = authenticationRepository.user;
    final message =
        await chatRepository.createMessage(content, sender.id!, receiver.id!);
  }


}
