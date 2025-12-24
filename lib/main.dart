import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_three/offline/cached_user_view.dart';
import 'package:riverpod_three/secure_storage/time_measurement_view.dart';

sealed class AppError implements Exception {}

class SomeSpecificError extends AppError {}

void main() {
  runApp(
    ProviderScope(
      retry: (retryCount, error) {
        if (error is SomeSpecificError) return null;
        if (retryCount > 5) return null;

        return Duration(seconds: retryCount * 2);
      },
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const CachedUserListView(),
    );
  }
}