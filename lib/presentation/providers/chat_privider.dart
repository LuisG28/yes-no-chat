import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:yes_no_app/domain/entities/message.dart';

import '../../config/helpers/get_yes_no_answer.dart';

class ChatProvider extends ChangeNotifier {
  final ScrollController chatScrollController = ScrollController();
  final GetYesNoAnswer getYesNoAnswer = GetYesNoAnswer();

  List<Message> messageList = [
    Message(
      text: 'Hola Wuichoo',
      fromWho: FromWho.his,
      imageUrl: 'https://yesno.wtf/assets/no/25-55dc62642f92cf4110659b3c80e0d7ec.gif',
    ),
    Message(
      text: 'Hola Tanjiro',
      fromWho: FromWho.mine,
    )
  ];

  Future<void> sendMessage(String text) async {
    if (text.isEmpty) return;

    final newMessage = Message(text: text, fromWho: FromWho.mine);
    messageList.add(newMessage);

    if (text.endsWith('?')) {
      herRepply();
    }

    //Actualiza el estado
    notifyListeners();
    //Animación de scroll
    moveScrollToBottom();
  }

  Future<void> herRepply() async {
    final herMessage = await getYesNoAnswer.getAnswer();
    messageList.add(herMessage);
    notifyListeners();
    moveScrollToBottom();
  }

  Future<void> moveScrollToBottom() async {
    await Future.delayed(const Duration(milliseconds: 100));
    chatScrollController.animateTo(
        chatScrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.decelerate);
  }
}
