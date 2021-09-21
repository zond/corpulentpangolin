//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'router.gr.dart';

// Location bar router.
final appRouter = AppRouter();
// Database.
//final firestore = FirebaseFirestore.instance;
// User.
final user = ValueNotifier<User?>(null);
