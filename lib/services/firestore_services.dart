import 'package:cloud_firestore/cloud_firestore.dart';

class FireStoreServices {
  Future<void> deleteMessage(String messageId) async {
    try {
      await FirebaseFirestore.instance
          .collection('chats')
          .doc(messageId)
          .delete();

      print('✅ Message deleted successfully.');
    } catch (e) {
      print('❌ Error deleting message: $e');
      rethrow;
    }
  }
}
