import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/main.dart';
import 'package:movie_app/bloc/movies_cubit.dart';
import 'package:movie_app/services/movie_api_service.dart';
import 'package:movie_app/screens/home_screen.dart';
import 'package:movie_app/models/movie.dart';

void main() {
  // Simple smoke test to check if the app builds properly
  testWidgets('App renders correctly', (WidgetTester tester) async {
    // Build our app and trigger a frame
    await tester.pumpWidget(const MyApp());

    // Verify that the app builds without errors
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
