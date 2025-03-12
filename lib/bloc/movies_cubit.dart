import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/movie.dart';
import '../services/movie_api_service.dart';

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

// BLoC Cubit
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
  
  // Method to search for movies (mock implementation)
  Future<void> searchMovies(String query) async {
    if (query.isEmpty) {
      fetchMovies();
      return;
    }
    
    emit(MoviesLoading());
    
    try {
      // In a real app, you would call a search API endpoint
      // For now, we'll filter our mock data
      final allMovies = await apiService.getNowPlayingMovies() + await apiService.getPopularMovies();
      
      // Remove duplicates by id
      final Map<int, Movie> uniqueMovies = {};
      for (var movie in allMovies) {
        uniqueMovies[movie.id] = movie;
      }
      
      // Filter by query (case insensitive)
      final filteredMovies = uniqueMovies.values.where((movie) => 
        movie.title.toLowerCase().contains(query.toLowerCase())
      ).toList();
      
      emit(MoviesLoaded(
        nowPlayingMovies: filteredMovies,
        popularMovies: [],
      ));
    } catch (e) {
      emit(MoviesError(message: e.toString()));
    }
  }
}