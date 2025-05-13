import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:travelgo_user/core/constants/stripe_constants.dart';
import 'package:travelgo_user/data/hive_model/journal_entry.dart';
import 'package:travelgo_user/features/logic/auth/auth_bloc.dart';
import 'package:travelgo_user/features/logic/journal/journal_bloc.dart';
import 'package:travelgo_user/features/logic/nav/nav_bloc.dart';
import 'package:travelgo_user/features/logic/post/post_bloc.dart';
import 'package:travelgo_user/features/logic/user/user_bloc.dart';
import 'package:travelgo_user/features/view/screens/auth_screens/splash_screen/splash_screen.dart';
import 'package:travelgo_user/core/services/firebase_options.dart';

void main() async {
  await setup(); // Your publishable key from Stripe
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await Hive.initFlutter();
  Hive.registerAdapter(JournalEntryAdapter());
  // ❗️Clear corrupted box BEFORE opening it
  await Hive.deleteBoxFromDisk('journalBox'); // ✅ Fixes DateTime/String issue
  final box = await Hive.openBox<JournalEntry>('journalBox');
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => PostBloc()),
        BlocProvider(create: (context) => UserBloc()),
        BlocProvider(create: (context) => NavBloc()),
        BlocProvider(create: (context) => AuthBloc()),
        BlocProvider(
          create: (_) => JournalBloc(box)..add(LoadJournalEntries()),
        ),
      ],
      child: MyApp(),
    ),
  );
}

Future<void> setup() async {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey = stripePublishableKey;
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: Splashscreen());
  }
}
