import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movie_app/screens/movie_detail_screen.dart';
import 'package:movie_app/models/movie.dart';

void main() {
  final testMovie = Movie(
    id: 1,
    title: 'Test Movie',
    posterPath: '/test_poster_path.jpg',
    backdropPath: '/test_backdrop_path.jpg',
    overview: 'This is a test movie overview that describes the plot of the movie.',
    voteAverage: 8.5,
    releaseDate: '2025-01-01',
  );

  group('MovieDetailScreen Widget Tests', () {
    testWidgets('Movie detail screen displays movie information', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: MovieDetailScreen(movie: testMovie),
        ),
      );

      // Wait for any network images or animations to settle
      await tester.pumpAndSettle();

      // Verify that movie title is displayed
      expect(find.text('Test Movie'), findsOneWidget);
      
      // Verify that the rating is displayed
      expect(find.text('8.5'), findsOneWidget);
      
      // Verify that the release date is displayed
      expect(find.text('Release: 2025-01-01'), findsOneWidget);
      
      // Verify that the overview is displayed
      expect(find.text('This is a test movie overview that describes the plot of the movie.'), findsOneWidget);
    });

    testWidgets('Watch Now button is displayed', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: MovieDetailScreen(movie: testMovie),
        ),
      );

      // Wait for any network images or animations to settle
      await tester.pumpAndSettle();

      // Verify watch now button
      expect(find.text('Watch Now'), findsOneWidget);
    });

    testWidgets('Add to watchlist button is displayed', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: MovieDetailScreen(movie: testMovie),
        ),
      );

      // Wait for any network images or animations to settle
      await tester.pumpAndSettle();

      // Find the add button by its icon
      expect(find.byIcon(Icons.add), findsOneWidget);
    });

    testWidgets('Synopsis section is displayed', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: MovieDetailScreen(movie: testMovie),
        ),
      );

      // Wait for any network images or animations to settle
      await tester.pumpAndSettle();

      // Verify the synopsis section
      expect(find.text('Synopsis'), findsOneWidget);
    });

    testWidgets('Similar Movies section is displayed', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: MovieDetailScreen(movie: testMovie),
        ),
      );

      // Wait for any network images or animations to settle
      await tester.pumpAndSettle();

      // Verify the similar movies section
      expect(find.text('Similar Movies'), findsOneWidget);
    });

    testWidgets('Back button is displayed and works', (WidgetTester tester) async {
      bool backButtonPressed = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) => TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MovieDetailScreen(movie: testMovie),
                    ),
                  );
                },
                child: const Text('Go to detail'),
              ),
            ),
          ),
        ),
      );

      // Tap the button to navigate to detail screen
      await tester.tap(find.text('Go to detail'));
      await tester.pumpAndSettle();

      // Verify we're on the detail screen
      expect(find.text('Test Movie'), findsOneWidget);

      // Find and tap back button (it's an IconButton with Icons.arrow_back)
      await tester.tap(find.byIcon(Icons.arrow_back));
      await tester.pumpAndSettle();

      // Verify we've navigated back
      expect(find.text('Go to detail'), findsOneWidget);
      expect(find.text('Test Movie'), findsNothing);
    });
  });
}