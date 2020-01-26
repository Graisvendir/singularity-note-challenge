import 'dart:math';

import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

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

  static Message createEmail(List<String> recipients, String note, String imageAdress) {
    final mess = Message()
     ..from = Address(username, 'Singularity Note');
     recipients.forEach((f) => mess.recipients.add(f));
     mess.text = note;
     mess.subject = messCut(note);
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

  static Future<void> sendEmail(List<String> recipients, String note, String imageAdress) async{
    Message message = createEmail(recipients, note, imageAdress);
    try {
      final sendReport = await send(message, smtpServer);
      print('Message sent: ' + sendReport.toString());
    } on MailerException catch (e) {
      print('Message not sent.');
      for (var p in e.problems) {
        print('Problem: ${p.code}: ${p.msg}');
      }
    }
  }
}
  // DONE
  
  
  // Let's send another message using a slightly different syntax:
  //
  // Addresses without a name part can be set directly.
  // For instance `..recipients.add('destination@example.com')`
  // If you want to display a name part you have to create an
  // Address object: `new Address('destination@example.com', 'Display name part')`
  // Creating and adding an Address object without a name part
  // `new Address('destination@example.com')` is equivalent to
  // adding the mail address as `String`.
  // final equivalentMessage = Message()
  //     ..from = Address(username, 'Your name')
  //     ..recipients.add(Address('fogelvogel1337@gmail.com'))
  //     ..ccRecipients.addAll([Address('fogelvogel1337@gmail.com'), 'fogelvogel1337@gmail.com'])
  //     ..bccRecipients.add('fogelvogel1337@gmail.com')
  //     ..subject = 'Test Dart Mailer library :: 😀 :: ${DateTime.now()}'
  //     ..text = 'This is the plain text.\nThis is line 2 of the text part.'
  //     ..html = "<h1>Test</h1>\n<p>Hey! Here's some HTML content</p>";
    
  // final sendReport2 = await send(equivalentMessage, smtpServer);
  
  // Sending multiple messages with the same connection
  //
  // Create a smtp client that will persist the connection
  // var connection = PersistentConnection(smtpServer);
  
  // // Send the first message
  // await connection.send(message);
  
  // // send the equivalent message
  // await connection.send(equivalentMessage);
  
  // // close the connection
  // await connection.close();
  