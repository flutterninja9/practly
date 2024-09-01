import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';

Future<void> uploadJsonToFirestore() async {
  try {
    final x = await rootBundle.loadString("excercises.sample.json");
    final json = jsonDecode(x) as List;

    final firestore = FirebaseFirestore.instance;

    json.forEach((doc) async {
      final x2 = await firestore
          .collection('lessons')
          .add({"title": doc["title"], "description": doc["description"]});

      doc["exercises"].forEach((excercise) async {
        await firestore
            .collection('lessons')
            .doc(x2.id)
            .collection("exercises")
            .add(excercise);
      });
    });
  } catch (e, s) {
    print("Upload unsucessfull!");
    print(e.toString());
    print(s.toString());
  }
}
