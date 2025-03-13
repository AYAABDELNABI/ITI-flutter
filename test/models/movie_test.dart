import 'package:flutter_test/flutter_test.dart';
import 'package:movie_app/models/movie.dart';

void main() {
  group('Movie Model', () {
    test('Movie.fromJson() correctly parses JSON data', () {
      // Arrange
      final json = {
        'id': 123,
        'title': 'Test Movie',
        'poster_path': '/poster.jpg',
        'backdrop_path': '/backdrop.jpg',
        'overview': 'This is a test movie',
        'vote_average': 8.5,
        'release_date': '2025-01-01',
      };

      // Act
      final movie = Movie.fromJson(json);

      // Assert
      expect(movie.id, 123);
      expect(movie.title, 'Test Movie');
      expect(movie.posterPath, '/poster.jpg');
      expect(movie.backdropPath, '/backdrop.jpg');
      expect(movie.overview, 'This is a test movie');
      expect(movie.voteAverage, 8.5);
      expect(movie.releaseDate, '2025-01-01');
    });

    test('Movie.fromJson() handles missing poster_path and backdrop_path', () {
      // Arrange
      final json = {
        'id': 123,
        'title': 'Test Movie',
        'overview': 'This is a test movie',
        'vote_average': 8.5,
        'release_date': '2025-01-01',
      };

      // Act
      final movie = Movie.fromJson(json);

      // Assert
      expect(movie.id, 123);
      expect(movie.title, 'Test Movie');
      expect(movie.posterPath, '');
      expect(movie.backdropPath, '');
      expect(movie.overview, 'This is a test movie');
      expect(movie.voteAverage, 8.5);
      expect(movie.releaseDate, '2025-01-01');
    });

    test('Movie.fromJson() handles integer vote_average', () {
      // Arrange
      final json = {
        'id': 123,
        'title': 'Test Movie',
        'poster_path': '/poster.jpg',
        'backdrop_path': '/backdrop.jpg',
        'overview': 'This is a test movie',
        'vote_average': 8,
        'release_date': '2025-01-01',
      };

      // Act
      final movie = Movie.fromJson(json);

      // Assert
      expect(movie.voteAverage, 8.0);
      expect(movie.voteAverage, isA<double>());
    });
  });
}
