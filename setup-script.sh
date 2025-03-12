#!/bin/bash

# This script sets up the Flutter Movie App project structure

# Create the directory structure
mkdir -p lib/models lib/services lib/bloc lib/screens assets/images

# Move existing files to the correct locations
if [ -f "flutter-movie-app.dart" ]; then
  # Extract movie model
  echo "Moving movie model to lib/models/movie.dart"
  # You'll need to manually extract the Movie class from flutter-movie-app.dart
  # and place it in lib/models/movie.dart
  
  # Extract API service
  echo "Moving API service to lib/services/movie_api_service.dart"
  # You'll need to manually extract the MovieApiService class from flutter-movie-app.dart
  # and place it in lib/services/movie_api_service.dart
  
  # Extract Cubit
  echo "Moving BLoC/Cubit to lib/bloc/movies_cubit.dart"
  # You'll need to manually extract the MoviesCubit class from flutter-movie-app.dart
  # and place it in lib/bloc/movies_cubit.dart
fi

if [ -f "flutter-movie-app-home-screen.dart" ]; then
  echo "Moving home screen to lib/screens/home_screen.dart"
  # You'll need to manually extract the HomeScreen class from flutter-movie-app-home-screen.dart
  # and place it in lib/screens/home_screen.dart
fi

if [ -f "flutter-movie-app-detail-screen.dart" ]; then
  echo "Moving detail screen to lib/screens/movie_detail_screen.dart"
  # You'll need to manually extract the MovieDetailScreen class from flutter-movie-app-detail-screen.dart
  # and place it in lib/screens/movie_detail_screen.dart
fi

# Create Flutter project structure (keep existing lib directory)
echo "Creating Flutter project structure"
flutter create --org com.example --project-name movie_app .

echo "Project setup complete!"
echo "Now run: flutter pub get"