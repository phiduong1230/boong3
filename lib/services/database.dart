
import 'package:cloud_firestore/cloud_firestore.dart';

import 'local.dart';

class DatabaseMethods {
  //Map dữ liệu của người dùng và đưa lên Firebase
  Future addUserInfoToDatabase(
      String userId, Map<String, dynamic> userInfoMap) async {
    return await FirebaseFirestore.instance
        .collection("users")
        .doc(userId)
        .set(userInfoMap);
  }
  // Tìm người dùng hiện tại qua username
  Future<Stream<QuerySnapshot>> getUserByUsername(String username) async {
    return FirebaseFirestore.instance
        .collection("users")
        .where('username', isEqualTo: username)
        .snapshots();
  }
  // Gửi tin nhắn
  Future addMessageToCloud(String chatroomId, String messageId,
      Map<String, dynamic> messageInfoMap) async {
    return FirebaseFirestore.instance
        .collection("chatrooms")
        .doc(chatroomId)
        .collection("chats")
        .doc(messageId)
        .set(messageInfoMap);
  }
  //Cập nhật tin nhắn cuối
  updateLastMessageSent(
      String chatroomId, Map<String, dynamic> lastMessageInfoMap) async {
    return await FirebaseFirestore.instance
        .collection("chatrooms")
        .doc(chatroomId)
        .update(lastMessageInfoMap);
  }
  // Tạo room chat dựa theo tên người dùng
  createChatRoom(
      String chatroomId, Map<String, dynamic> chatroomInfoMap) async {
    final snapShot = await FirebaseFirestore.instance
        .collection("chatrooms")
        .doc(chatroomId)
        .get();
    if (snapShot.exists) {
      //chatroom đã tồn tại
      return true;
    } else {
      //Nếu chatroom chưa tồn tại thì tạo 1 chatroom
      return FirebaseFirestore.instance
          .collection("chatrooms")
          .doc(chatroomId)
          .set(chatroomInfoMap);
    }
  }
  // Lấy tin nhắn được lưu trữ
  Future<Stream<QuerySnapshot>> getChatroomMessage(chatroomId) async {
    return FirebaseFirestore.instance
        .collection('chatrooms')
        .doc(chatroomId)
        .collection('chats')
        .orderBy('ts', descending: true)
        .snapshots();
  }

  // Lấy dữ liệu phòng chat để in ra List
  Future<Stream<QuerySnapshot>> getChatRooms() async {
    String myUsername = await SharedPreferencesHelper().getUserName();
    // print(myUsername);
    return FirebaseFirestore.instance
        .collection("chatrooms")
        .orderBy("lastMessageSendTs", descending: true)
        .where("users", arrayContains: myUsername)
        .snapshots();
  }
  // Lấy thông tin người dùng theo username
  Future<QuerySnapshot> getUserInfo(String username) async {
    return await FirebaseFirestore.instance
        .collection("users")
        .where("username", isEqualTo: username)
        .get();
  }
}
