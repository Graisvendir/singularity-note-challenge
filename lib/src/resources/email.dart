import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter/widgets.dart';
import 'package:mailer/mailer.dart';
import 'package:http/http.dart' as http;
import 'package:mailer/smtp_server.dart';
import 'package:note_project/src/models/note_model.dart';
import 'package:note_project/src/models/settings.dart';

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

  static Future<bool> sendSingularity(Auth auth) async{
    final response = await http.post(
      'https://api.singularity-app.com/task', 
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.authorizationHeader: 'Basic $auth'
      },
      body: jsonEncode({
        'title': 'test',
        'note': 'test'
      })
    );
    final success = response.statusCode == HttpStatus.created;
    print('sing $success');
    return success;
  }

  static Future<bool> sendEmail(Message message) async{
    try {
      final sendReport = await send(message, smtpServer);
      print('Message sent: ' + sendReport.toString());
      return true;
    } catch (_) {
      print('Message not sent.');
      return false;
    }
  
  }

  static Future<bool> sendEveryWhere(List<String> recipients, NoteModel noteToSend, Auth auth) async{
    Message message = createEmail(recipients, noteToSend.text, noteToSend.imgPath);     
    final succesEmail = await sendEmail(message);
    if (succesEmail) {
      final successSing = await sendSingularity(auth);
      return successSing;
    }
    return false;
  }
}