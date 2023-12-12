import 'package:flutter/material.dart';
import 'package:github_repo_commit_map/provider/commits_provider.dart';
import 'package:provider/provider.dart';

import 'views/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<CommitsProvider>(create: (_) => CommitsProvider()),
      ],
      child: MaterialApp(
        title: 'Github Repo Commit Map',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: CommitHistoryScreen(),
      ),
    );
  }
}
