import 'package:flutter_test/flutter_test.dart';
import 'package:movie_app/bloc/movies_cubit.dart';
import 'package:movie_app/services/movie_api_service.dart';
import 'package:movie_app/models/movie.dart';

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

// Mock API service that returns an error
class ErrorMovieApiService extends MovieApiService {
  @override
  Future<List<Movie>> getNowPlayingMovies() async {
    throw Exception('Failed to fetch movies');
  }

  @override
  Future<List<Movie>> getPopularMovies() async {
    throw Exception('Failed to fetch movies');
  }
}

void main() {
  group('MoviesCubit', () {
    late MoviesCubit moviesCubit;
    late MockMovieApiService mockApiService;

    setUp(() {
      mockApiService = MockMovieApiService();
      moviesCubit = MoviesCubit(apiService: mockApiService);
    });

    test('Initial state is MoviesInitial', () {
      expect(moviesCubit.state, isA<MoviesInitial>());
    });

    test('Emits loading state then loaded state when fetchMovies is called', () async {
      // Execute fetchMovies
      final future = moviesCubit.fetchMovies();
      
      // Verify state transitions
      expect(moviesCubit.state, isA<MoviesLoading>());
      
      // Wait for fetchMovies to complete
      await future;
      
      // Verify final state
      expect(moviesCubit.state, isA<MoviesLoaded>());
      
      final loadedState = moviesCubit.state as MoviesLoaded;
      expect(loadedState.nowPlayingMovies.length, 2);
      expect(loadedState.popularMovies.length, 2);
      
      // Verify specific movies
      expect(loadedState.nowPlayingMovies[0].title, 'Test Movie 1');
      expect(loadedState.popularMovies[0].title, 'Popular Test Movie 1');
    });

    test('Emits error state when API calls fail', () async {
      // Create cubit with error service
      final errorCubit = MoviesCubit(apiService: ErrorMovieApiService());
      
      // Execute fetchMovies
      await errorCubit.fetchMovies();
      
      // Verify error state
      expect(errorCubit.state, isA<MoviesError>());
      final errorState = errorCubit.state as MoviesError;
      expect(errorState.message, contains('Failed to fetch movies'));
    });

    test('searchMovies filters movies correctly', () async {
      // First load movies
      await moviesCubit.fetchMovies();
      
      // Search for a specific movie
      await moviesCubit.searchMovies('Test Movie 1');
      
      // Verify state
      expect(moviesCubit.state, isA<MoviesLoaded>());
      final loadedState = moviesCubit.state as MoviesLoaded;
      
      // Should only find one movie
      expect(loadedState.nowPlayingMovies.length, 1);
      expect(loadedState.nowPlayingMovies[0].title, 'Test Movie 1');
      
      // Popular movies should be empty as none match
      expect(loadedState.popularMovies.length, 0);
    });

    test('searchMovies with empty query reloads all movies', () async {
      // First load movies
      await moviesCubit.fetchMovies();
      
      // Perform a search to filter
      await moviesCubit.searchMovies('Test Movie 1');
      
      // Then search with empty query
      await moviesCubit.searchMovies('');
      
      // Verify state has all movies again
      expect(moviesCubit.state, isA<MoviesLoaded>());
      final loadedState = moviesCubit.state as MoviesLoaded;
      expect(loadedState.nowPlayingMovies.length, 2);
      expect(loadedState.popularMovies.length, 2);
    });
  });
}