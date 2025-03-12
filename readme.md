# Flutter Movie App

A Flutter application that displays information about movies using TheMovieDB API.

## Features

- Browse now playing and popular movies
- View detailed information about each movie
- Search functionality for finding specific movies
- Similar movies recommendations
- Clean, modern UI with dark theme optimized for movie browsing

## Screenshots

(Add screenshots of your app here)

## Project Structure

```
lib/
  ├── main.dart
  ├── models/
  │   └── movie.dart
  ├── services/
  │   └── movie_api_service.dart
  ├── bloc/
  │   └── movies_cubit.dart
  └── screens/
      ├── home_screen.dart
      └── movie_detail_screen.dart
```

## Getting Started

1. Clone this repository
2. Run `flutter pub get` to install dependencies
3. Connect a device or emulator
4. Run with `flutter run`

## Dependencies

- **flutter_bloc**: State management using the BLoC pattern
- **http**: API communication with TheMovieDB
- **cached_network_image**: Efficient image loading and caching

## API Key

This app uses TheMovieDB API. The demo version includes a sample API key, but for production use, you should register for your own API key at [themoviedb.org](https://www.themoviedb.org/documentation/api).

## Future Improvements

- User authentication and personalized recommendations
- Watchlist functionality
- Filtering by genre
- Trailer playback
- Reviews and ratings

## License

This project is licensed under the MIT License - see the LICENSE file for details.