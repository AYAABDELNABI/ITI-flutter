import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/bloc/movies_cubit.dart';
import 'package:movie_app/screens/home_screen.dart';
import 'package:movie_app/services/movie_api_service.dart';
import 'package:movie_app/models/movie.dart';

// Mock classes
class MockMovieApiService extends MovieApiService {
  @override
  Future<List<Movie>> getNowPlayingMovies() async {
    return [
      Movie(
        id: 1,
        title: 'Test Movie 1',
        posterPath: '/test_poster_path.jpg',
        backdropPath: '/test_backdrop_path.jpg',
        overview: 'Test overview',
        voteAverage: 8.5,
        releaseDate: '2025-01-01',
      ),
      Movie(
        id: 2,
        title: 'Test Movie 2',
        posterPath: '/test_poster_path2.jpg',
        backdropPath: '/test_backdrop_path2.jpg',
        overview: 'Test overview 2',
        voteAverage: 7.5,
        releaseDate: '2025-02-01',
      ),
    ];
  }

  @override
  Future<List<Movie>> getPopularMovies() async {
    return [
      Movie(
        id: 3,
        title: 'Popular Test Movie 1',
        posterPath: '/popular_poster_path.jpg',
        backdropPath: '/popular_backdrop_path.jpg',
        overview: 'Popular test overview',
        voteAverage: 9.0,
        releaseDate: '2025-01-15',
      ),
      Movie(
        id: 4,
        title: 'Popular Test Movie 2',
        posterPath: '/popular_poster_path2.jpg',
        backdropPath: '/popular_backdrop_path2.jpg',
        overview: 'Popular test overview 2',
        voteAverage: 8.0,
        releaseDate: '2025-02-15',
      ),
    ];
  }
}

void main() {
  group('HomeScreen Widget Tests', () {
    late MoviesCubit moviesCubit;

    setUp(() {
      moviesCubit = MoviesCubit(apiService: MockMovieApiService());
    });

    testWidgets('HomeScreen displays loading state initially', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<MoviesCubit>.value(
            value: moviesCubit,
            child: const HomeScreen(),
          ),
        ),
      );

      // Initially, the cubit is in MoviesInitial state, so it should show loading when fetched
      moviesCubit.fetchMovies();
      await tester.pump();

      // Check for loading indicator
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('HomeScreen displays movies when loaded', (WidgetTester tester) async {
      // Prepare the cubit with loaded state
      await moviesCubit.fetchMovies();

      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<MoviesCubit>.value(
            value: moviesCubit,
            child: const HomeScreen(),
          ),
        ),
      );

      // Wait for the widget to build
      await tester.pumpAndSettle();

      // Verify that movie titles are displayed
      expect(find.text('Test Movie 1'), findsOneWidget);
      expect(find.text('Popular Test Movie 1'), findsOneWidget);
    });

    testWidgets('Search bar is displayed', (WidgetTester tester) async {
      // Prepare the cubit with loaded state
      await moviesCubit.fetchMovies();

      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<MoviesCubit>.value(
            value: moviesCubit,
            child: const HomeScreen(),
          ),
        ),
      );

      // Wait for the widget to build
      await tester.pumpAndSettle();

      // Check for search bar
      expect(find.byType(TextField), findsOneWidget);
      expect(find.text('Search for movies'), findsOneWidget);
    });

    testWidgets('Bottom navigation bar has three items', (WidgetTester tester) async {
      // Prepare the cubit with loaded state
      await moviesCubit.fetchMovies();

      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<MoviesCubit>.value(
            value: moviesCubit,
            child: const HomeScreen(),
          ),
        ),
      );

      // Wait for the widget to build
      await tester.pumpAndSettle();

      // Check bottom navigation bar
      expect(find.byType(BottomNavigationBar), findsOneWidget);
      expect(find.text('Home'), findsOneWidget);
      expect(find.text('Explore'), findsOneWidget);
      expect(find.text('Watchlist'), findsOneWidget);
    });
  });
}