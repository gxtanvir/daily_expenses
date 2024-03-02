import 'package:daily_expense/screens/auth.dart';
import 'package:daily_expense/screens/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final kColorScheme = ColorScheme.fromSeed(
  seedColor: const Color.fromARGB(255, 13, 211, 119),
);

final kDarkColorScheme = ColorScheme.fromSeed(
  brightness: Brightness.dark,
  seedColor: const Color.fromARGB(255, 38, 62, 197),
);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Khoroch Shomogro',
      debugShowCheckedModeBanner: false,
      theme: ThemeData().copyWith(
        // useMaterial3: false,
        colorScheme: kColorScheme,
        appBarTheme: AppBarTheme(
          backgroundColor: kColorScheme.secondaryContainer,
          titleTextStyle: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: kColorScheme.onPrimaryContainer),
        ),
      ),
      darkTheme: ThemeData().copyWith(
        colorScheme: kDarkColorScheme,
      ),
      themeMode: ThemeMode.dark,
      home: //ExpensesScreen(book: Book(title: "February 2")),
          StreamBuilder(
              stream: FirebaseAuth.instance.userChanges(),
              builder: (ctx, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (snapshot.hasData) {
                  return const HomeScreen();
                }

                return const AuthScreen();
              }),
    );
  }
}
