
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:whole_selle_x_application/src/common/const/static_class.dart';
// import 'package:whole_selle_x_application/src/features/auth/model/usermode.dart';

// class ChatScreen extends StatefulWidget {
//   final String chatroomId;

//   final friendModel profileModel;

//   ChatScreen({
//     required this.chatroomId,
//     required this.profileModel,
//   });
//   @override
//   State<ChatScreen> createState() => _ChatScreenState();
// }

// class _ChatScreenState extends State<ChatScreen> {
//   TextEditingController msgController = TextEditingController();

//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   bool isemoji = false;
//   void onsendMessage(String type, String msg, String duration) async {
//     if (msg.isNotEmpty) {
//       Map<String, dynamic> messages = {
//         "sendBy": StaticData.model!.name,
//         "message": msg,
//         "time": FieldValue.serverTimestamp(),
//         "type": type,
//         "duration": duration
//       };
//       await _firestore
//           .collection('chatroom')
//           .doc(widget.chatroomId)
//           .collection('chats')
//           .add(messages);
//       msgController.clear();
//     } else {
//       print("Enter Some Text");
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     var height = MediaQuery.of(context).size.height;
//     var width = MediaQuery.of(context).size.width;
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: SizedBox(
//           height: height,
//           width: width,
//           child: Column(
//             children: [
//               Container(
//                 color: Color.fromARGB(255, 71, 26, 160),
//                 height: height * 0.04,
//               ),
//               Container(
//                 height: height * 0.08,
//                 width: width,
//                 decoration: BoxDecoration(
//                     color: Color.fromARGB(255, 71, 26, 160),
//                     borderRadius: const BorderRadius.only(
//                         bottomLeft: Radius.circular(10),
//                         bottomRight: Radius.circular(10))),
//                 child: Padding(
//                   padding:
//                       EdgeInsets.only(right: width * 0.02, left: width * 0.02),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       Container(
//                         height: height * 0.05,
//                         width: width * 0.12,
//                         decoration: const BoxDecoration(
//                             shape: BoxShape.circle, color: Colors.white),
//                         child: Icon(Icons.person,
//                             color: Color.fromARGB(255, 151, 71, 255)),
//                       ),
//                       Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text('${widget.profileModel.userName}',
//                               style: const TextStyle(
//                                   color: Colors.white,
//                                   fontWeight: FontWeight.w500)),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               Expanded(
//                 child: SizedBox(
//                   child: StreamBuilder<QuerySnapshot>(
//                     stream: _firestore
//                         .collection('chatroom')
//                         .doc(widget.chatroomId)
//                         .collection('chats')
//                         .orderBy("time", descending: false)
//                         .snapshots(),
//                     builder: (BuildContext context,
//                         AsyncSnapshot<QuerySnapshot> snapshot) {
//                       if (snapshot.data != null) {
//                         return ListView.builder(
//                           itemCount: snapshot.data!.docs.length,
//                           itemBuilder: (context, index) {
//                             Map<String, dynamic> map =
//                                 snapshot.data!.docs[index].data()
//                                     as Map<String, dynamic>;
//                             return messages(
//                                 MediaQuery.of(context).size, map, index);
//                           },
//                         );
//                       } else {
//                         return Container();
//                       }
//                     },
//                   ),
//                 ),
//               ),
//               Divider(color: Color.fromARGB(255, 151, 71, 255)),
//               SizedBox(
//                 height: height * 0.07,
//                 width: width,
//                 child: Padding(
//                   padding: EdgeInsets.only(
//                     left: width * 0.03,
//                   ),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       Container(
//                         height: height,
//                         width: width * 0.2,
//                         decoration: BoxDecoration(
//                             color: Colors.red[100],
//                             borderRadius: const BorderRadius.horizontal(
//                                 left: Radius.circular(10))),
//                         child: Row(
//                           children: [
//                             InkWell(
//                                 onTap: () {
//                                   showModalBottomSheet(
//                                     context: context,
//                                     builder: (BuildContext context) {
//                                       return Container(
//                                         height: 100,
//                                         child: Center(
//                                           child: Column(
//                                             children: [
//                                               Row(
//                                                 mainAxisAlignment:
//                                                     MainAxisAlignment.center,
//                                                 children: [
//                                                   IconButton(
//                                                       onPressed: () {},
//                                                       icon: Icon(Icons
//                                                           .location_on_outlined))
//                                                 ],
//                                               )
//                                             ],
//                                           ),
//                                         ),
//                                       );
//                                     },
//                                   );
//                                 },
//                                 child: Icon(Icons.attachment)),
//                           ],
//                         ),
//                       ),
//                       Expanded(
//                         child: Container(
//                           decoration: BoxDecoration(
//                               color: Colors.red[100],
//                               borderRadius: BorderRadius.horizontal(
//                                 right: Radius.circular(10),
//                               )),
//                           child: Padding(
//                             padding: EdgeInsets.only(left: width * 0.02),
//                             child: Center(
//                               child: TextField(
//                                 controller: msgController,
//                                 decoration: InputDecoration(
//                                   border: InputBorder.none,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                       SizedBox(
//                         width: width * 0.01,
//                       ),
//                       InkWell(
//                           onTap: () {
//                             onsendMessage("text", msgController.text, "");
//                           },
//                           child: Container(
//                             height: height,
//                             width: width * 0.14,
//                             decoration: BoxDecoration(
//                                 shape: BoxShape.circle,
//                                 color: Color.fromARGB(255, 151, 71, 255)),
//                             child: const Center(
//                               child: Icon(
//                                 Icons.send,
//                                 color: Colors.white,
//                               ),
//                             ),
//                           )),
//                     ],
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 height: height * 0.01,
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget messages(Size size, Map<String, dynamic> map, int index) {
//     return Container(
//       width: size.width,
//       alignment: map['sendBy'] == StaticData.model!.name
//           ? Alignment.centerRight
//           : Alignment.centerLeft,
//       child: map['type'] == "video"
//           ? Container(
//               padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
//               margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(10),
//                 color: map['sendBy'] == StaticData.model!.name
//                     ? Color.fromARGB(255, 151, 71, 255)
//                     : Colors.red[100],
//               ),
//               child: Text(
//                 map['message'],
//                 style: TextStyle(
//                     fontWeight: FontWeight.w500,
//                     color: map['sendBy'] == StaticData.model!.name
//                         ? Colors.white
//                         : Colors.black),
//               ),
//             )
//           : null,
//     );
//   }
// }
