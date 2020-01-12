import 'package:flutter/material.dart';

// class NoteList extends StatefulWidget {
//   @override
//   NoteListState createState() {
//     return NoteListState();
//   }
// }

// class NoteListState extends State<NoteList> {
//   @override
//   Widget build(BuildContext context) {
//     return new ListView.builder(
//       itemCount: 5,
//       itemBuilder: (context, i) => new Column(
//         children: <Widget>[
//           new Divider(
//             height: 10.0,
//           ),
//           new ListTile(
//             leading: new CircleAvatar(
//               foregroundColor: Theme.of(context).primaryColor,
//               backgroundColor: Colors.grey,
//               backgroundImage: new NetworkImage(dummyData[i].avatarUrl),
//             ),
//             title: new Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: <Widget>[
//                 new Text(
//                   dummyData[i].name,
//                   style: new TextStyle(fontWeight: FontWeight.bold),
//                 ),
//                 new Text(
//                   dummyData[i].time,
//                   style: new TextStyle(color: Colors.grey, fontSize: 14.0),
//                 ),
//               ],
//             ),
//             subtitle: new Container(
//               padding: const EdgeInsets.only(top: 5.0),
//               child: new Text(
//                 dummyData[i].message,
//                 style: new TextStyle(color: Colors.grey, fontSize: 15.0),
//               ),
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }