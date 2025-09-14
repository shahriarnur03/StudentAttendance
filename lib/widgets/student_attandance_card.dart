import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:studentattendance/services/database.dart';

class StudentAttandanceCard extends StatefulWidget {
  const StudentAttandanceCard({super.key, required this.ds});
  final DocumentSnapshot ds;

  @override
  State<StudentAttandanceCard> createState() => _StudentAttandanceCardState();
}

class _StudentAttandanceCardState extends State<StudentAttandanceCard> {
  String? attendance;

  @override
  void initState() {
    super.initState();
    if (widget.ds['present'] != null) {
      attendance = widget.ds['present'] ? 'P' : 'A';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text.rich(
                TextSpan(
                  children: [
                    const TextSpan(
                      text: "Student Name: ",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                    TextSpan(
                      text: widget.ds['Name'],
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.blue,
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text("Delete Student"),
                        content: const Text("Are you sure you want to delete this student?"),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text("Cancel"),
                          ),
                          TextButton(
                            onPressed: () {
                              Database().deleteStudent(widget.ds.id);
                              Navigator.of(context).pop();
                            },
                            child: const Text("Delete"),
                          ),
                        ],
                      );
                    },
                  );
                },
                child: const Icon(Icons.delete, color: Colors.red),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text.rich(
            TextSpan(
              children: [
                const TextSpan(
                  text: "Roll No: ",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                TextSpan(
                  text: widget.ds['Roll'],
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Text.rich(
            TextSpan(
              children: [
                const TextSpan(
                  text: "Age: ",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                TextSpan(
                  text: widget.ds['Age'],
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              const Text(
                "Attendance:",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(width: 20),
              GestureDetector(
                onTap: () {
                  setState(() {
                    attendance = 'P';
                  });
                  Database().updateAttendance(widget.ds.id, true);
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: attendance == 'P' ? Colors.green : Colors.white,
                    borderRadius: BorderRadius.circular(6),
                    border: attendance == 'P' ? null : Border.all(color: Colors.black),
                  ),
                  child: Text(
                    "P",
                    style: TextStyle(
                      color: attendance == 'P' ? Colors.white : Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              GestureDetector(
                onTap: () {
                  setState(() {
                    attendance = 'A';
                  });
                  Database().updateAttendance(widget.ds.id, false);
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: attendance == 'A' ? Colors.red : Colors.white,
                    borderRadius: BorderRadius.circular(6),
                    border: attendance == 'A' ? null : Border.all(color: Colors.black),
                  ),
                  child: Text(
                    "A",
                    style: TextStyle(
                      color: attendance == 'A' ? Colors.white : Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
