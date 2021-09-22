import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'router.gr.dart';

// Location bar router.
final appRouter = AppRouter();
// User.
final user = ValueNotifier<User?>(null);
