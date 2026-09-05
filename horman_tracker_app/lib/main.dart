import 'package:flutter/material.dart';
import 'package:horman_tracker_app/app.dart';
import 'package:horman_tracker_app/data/local/guest_store.dart';

/// Entry point of Hormon Tracker. Keep thin: storage init, then [HormanTrackerApp].
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GuestStore.instance.init();
  runApp(const HormanTrackerApp());
}
