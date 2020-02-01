import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter/widgets.dart';
import 'package:mailer/mailer.dart';
import 'package:http/http.dart' as http;
import 'package:mailer/smtp_server.dart';
import 'package:note_project/src/models/note_model.dart';

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
    final auth = base64Encode(Utf8Encoder().convert('fogelvogel1337@gmail.com:3ced8c6d-adbf-4ee1-a48d-b12f07514334'));
    
    // final response = await http.post(
    //   'https://api.singularity-app.com/task', 
    //   headers: {
    //     HttpHeaders.contentTypeHeader: 'application/json',
    //     HttpHeaders.authorizationHeader: 'Basic $auth'
    //   },
    //   body: jsonEncode({
    //     'title': 'test',
    //     'note': 'test'
    //   })
    // );
    // final success = response.statusCode == HttpStatus.created;
    // return false;
    
    try {
      final sendReport = await send(message, smtpServer);
      print('Message sent: ' + sendReport.toString());
      return true;
    } catch (_) {
      print('Message not sent.');
      return false;
    }
  }
}