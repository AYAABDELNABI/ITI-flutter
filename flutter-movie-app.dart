import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

// Models
class Movie {
  final int id;
  final String title;
  final String posterPath;
  final String backdropPath;
  final String overview;
  final double voteAverage;
  final String releaseDate;

  Movie({
    required this.id,
    required this.title,
    required this.posterPath,
    required this.backdropPath,
    required this.overview,
    required this.voteAverage,
    required this.releaseDate,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'],
      title: json['title'],
      posterPath: json['poster_path'] ?? '',
      backdropPath: json['backdrop_path'] ?? '',
      overview: json['overview'],
      voteAverage: (json['vote_average'] as num).toDouble(),
      releaseDate: json['release_date'],
    );
  }
}

// API Service
class MovieApiService {
  final String apiKey = '1397938d91895ce060848db67a68bfaa';
  final String baseUrl = 'https://api.themoviedb.org/3';
  final http.Client client = http.Client();

  Future<List<Movie>> getNowPlayingMovies() async {
    final response = await client.get(
      Uri.parse('$baseUrl/movie/now_playing?api_key=$apiKey'),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = await json.decode(response.body);
      return (data['results'] as List)
          .map((movie) => Movie.fromJson(movie))
          .toList();
    } else {
      throw Exception('Failed to load now playing movies');
    }
  }

  Future<List<Movie>> getPopularMovies() async {
    final response = await client.get(
      Uri.parse('$baseUrl/movie/popular?api_key=$apiKey'),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = await json.decode(response.body);
      return (data['results'] as List)
          .map((movie) => Movie.fromJson(movie))
          .toList();
    } else {
      throw Exception('Failed to load popular movies');
    }
  }
}

// BLoC States
abstract class MoviesState {}

class MoviesInitial extends MoviesState {}

class MoviesLoading extends MoviesState {}

class MoviesLoaded extends MoviesState {
  final List<Movie> nowPlayingMovies;
  final List<Movie> popularMovies;

  MoviesLoaded({
    required this.nowPlayingMovies,
    required this.popularMovies,
  });
}

class MoviesError extends MoviesState {
  final String message;

  MoviesError({required this.message});
}

// BLoC Events
abstract class MoviesEvent {}

class FetchMovies extends MoviesEvent {}

// BLoC
class MoviesCubit extends Cubit<MoviesState> {
  final MovieApiService apiService;

  MoviesCubit({required this.apiService}) : super(MoviesInitial());

  Future<void> fetchMovies() async {
    emit(MoviesLoading());

    try {
      final nowPlayingMovies = await apiService.getNowPlayingMovies();
      final popularMovies = await apiService.getPopularMovies();

      emit(MoviesLoaded(
        nowPlayingMovies: nowPlayingMovies,
        popularMovies: popularMovies,
      ));
    } catch (e) {
      emit(MoviesError(message: e.toString()));
    }
  }
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movie App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.black,
        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: Colors.white),
          titleLarge: TextStyle(color: Colors.white),
          titleMedium: TextStyle(color: Colors.white),
          titleSmall: TextStyle(color: Colors.white),
        ),
      ),
      home: BlocProvider(
        create: (context) => MoviesCubit(
          apiService: MovieApiService(),
        )..fetchMovies(),
        child: const HomeScreen(),
      ),
    );
  }
}
