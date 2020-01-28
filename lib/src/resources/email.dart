import 'dart:io';
import 'dart:math';

import 'package:flutter/widgets.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:note_project/src/models/note_model.dart';

void sendEmail() async {
    final username = 'noteproject@yandex.ru';
   final password = 'G_b-2C!m4ec@nTj';
   final smtpServer = SmtpServer('smtp.yandex.ru', username: username, password: password, port: 465, ssl: true);
  final message = Message()
    ..from = Address(username, 'Singularity Note')
    ..recipients.add('fogelvogel1337@gmail.com')
    ..ccRecipients.addAll(['fogelvogel1337@gmail.com', 'fogelvogel1337@gmail.com'])
    ..bccRecipients.add(Address('fogelvogel1337@gmail.com'))
    ..subject = 'Test Dart Mailer library :: 😀 :: ${DateTime.now()}'
    ..text = 'This is the plain text.\nThis is line 2 of the text part.'
    ..html = "<h1>Test</h1>\n<p>Hey! Here's some HTML content</p>";

 
}

class Sender {
  static final username = 'noteproject@yandex.ru';
  static final password = 'G_b-2C!m4ec@nTj';
  static final smtpServer = SmtpServer('smtp.yandex.ru', username: username, password: password, port: 465, ssl: true);

  static Message createEmail(List<String> recipients, String note, String imagePath) {
    final mess = Message()
     ..from = Address(username, 'Singularity Note')
     ..recipients = recipients
     ..text = note
     ..subject = messCut(note);

    if (imagePath != null) {
      final image = File(imagePath);
    
      if (image != null && image.existsSync()) {
        mess.attachments = [FileAttachment(image)];
      }
    }

    return mess;
    
  }

  static String messCut(String note) {
    List<String> words = note.split(' ');

    String subj = '';
    for (int i = 0; i < min(3, words.length); i++) {
      subj += words[i] + ' ';
    }

    return subj;
  }

  static Future<bool> sendEmail(List<String> recipients, NoteModel noteToSend) async{
    Message message = createEmail(recipients, noteToSend.text, noteToSend.imgPath);
    try {
      final sendReport = await send(message, smtpServer);
      print('Message sent: ' + sendReport.toString());
      return true;
    } on MailerException catch (e) {
      print('Message not sent.');
      for (var p in e.problems) {
        print('Problem: ${p.code}: ${p.msg}');
      }
      return false;
    }
  }
}