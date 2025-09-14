import 'package:cloud_firestore/cloud_firestore.dart';

class Database {
  Future addStudent(Map<String, dynamic> studentInfo, String id) async {
    return await FirebaseFirestore.instance
        .collection('Students')
        .doc(id)
        .set(studentInfo);
  }

  Future<Stream<QuerySnapshot>> getStudentDetails() async {
    return FirebaseFirestore.instance.collection('Students').snapshots();
  }

  Future updateAttendance(String id, bool isPresent) async {
    return await FirebaseFirestore.instance
        .collection('Students')
        .doc(id)
        .update({'present': isPresent});
  }

  Future deleteStudent(String id) async {
    return await FirebaseFirestore.instance.collection('Students').doc(id).delete();
  }
}
