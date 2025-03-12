import 'package:flutter/material.dart';
import '../models/movie.dart';

class MovieDetailScreen extends StatelessWidget {
  final Movie movie;

  const MovieDetailScreen({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildBackdropAndTitle(context),
            _buildMovieInfo(context),
            _buildSynopsis(),
            const SizedBox(height: 32),
            _buildSimilarMoviesSection(),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildBackdropAndTitle(BuildContext context) {
    return Stack(
      children: [
        // Backdrop Image
        SizedBox(
          height: 300,
          width: double.infinity,
          child: ShaderMask(
            shaderCallback: (rect) {
              return const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.black, Colors.transparent],
              ).createShader(Rect.fromLTRB(0, 200, rect.width, rect.height));
            },
            blendMode: BlendMode.dstIn,
            child: Image.network(
              'https://image.tmdb.org/t/p/w500${movie.backdropPath}',
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: Colors.grey[800],
                  child: const Center(
                    child: Icon(
                      Icons.broken_image,
                      color: Colors.white,
                      size: 40,
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        
        // Back Button
        Positioned(
          top: 40,
          left: 16,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.5),
              borderRadius: BorderRadius.circular(20),
            ),
            child: IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMovieInfo(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Movie Poster
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.network(
              'https://image.tmdb.org/t/p/w500${movie.posterPath}',
              width: 120,
              height: 180,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: 120,
                  height: 180,
                  color: Colors.grey[800],
                  child: const Center(
                    child: Icon(
                      Icons.movie,
                      color: Colors.white,
                      size: 40,
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(width: 16),
          
          // Movie Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  movie.title,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(
                      Icons.star,
                      color: Colors.amber,
                      size: 20,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      movie.voteAverage.toStringAsFixed(1),
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Release: ${movie.releaseDate}',
                      style: TextStyle(
                        color: Colors.grey[400],
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Watch Now feature coming soon!'),
                              duration: Duration(seconds: 2),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: const Text('Watch Now'),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                      child: IconButton(
                        icon: const Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Added to watchlist!'),
                              duration: Duration(seconds: 2),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSynopsis() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Synopsis',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            movie.overview,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[300],
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSimilarMoviesSection() {
    // Mock data for similar movies based on current movie
    final List<Map<String, dynamic>> similarMovies = _getMockSimilarMovies();
    
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Similar Movies',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 220,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: similarMovies.length,
              itemBuilder: (context, index) {
                final similarMovie = similarMovies[index];
                return Container(
                  width: 140,
                  margin: const EdgeInsets.only(right: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.network(
                          'https://image.tmdb.org/t/p/w500${similarMovie['posterPath']}',
                          height: 180,
                          width: 140,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              height: 180,
                              width: 140,
                              color: Colors.grey[800],
                              child: const Center(
                                child: Icon(
                                  Icons.movie,
                                  color: Colors.white,
                                  size: 40,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        similarMovie['title'],
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
  
  // Mock data for similar movies
  List<Map<String, dynamic>> _getMockSimilarMovies() {
    // For Dune: Part Two
    if (movie.id == 693134) {
      return [
        {
          'id': 438631,
          'title': 'Dune',
          'posterPath': '/d5NXSklXo0qyIYkgV94XAgMIckC.jpg',
        },
        {
          'id': 335984,
          'title': 'Blade Runner 2049',
          'posterPath': '/gajva2L0rPYkEWjzgFlBXCAVBE5.jpg',
        },
        {
          'id': 9428,
          'title': 'Mad Max: Fury Road',
          'posterPath': '/8tZYtuWezp8JbcsvHYO0O46tFbo.jpg',
        },
        {
          'id': 457332,
          'title': 'Furiosa: A Mad Max Saga',
          'posterPath': '/p0WQyQRnjI4MUIKJOm2cVJ5hlY.jpg',
        },
      ];
    }
    // For Kung Fu Panda 4
    else if (movie.id == 1011985) {
      return [
        {
          'id': 9502,
          'title': 'Kung Fu Panda',
          'posterPath': '/wWt4JYXTg5Wr3xBW2phBrMKgp3x.jpg',
        },
        {
          'id': 38055,
          'title': 'Kung Fu Panda 2',
          'posterPath': '/mtqqD5jIpcc4WrVU3rfZGbQA80i.jpg',
        },
        {
          'id': 140300,
          'title': 'Kung Fu Panda 3',
          'posterPath': '/MZFPacfKzgisnUoEIQdHfAZhSb.jpg',
        },
        {
          'id': 1040148,
          'title': 'Moana 2',
          'posterPath': '/qzMYKnT4MN6kVO9tGnFH6kQP7vf.jpg',
        },
      ];
    }
    // Default similar movies for other movies
    else {
      return [
        {
          'id': 27205,
          'title': 'Inception',
          'posterPath': '/edv5CZvWj09upOsy2Y6IwDhK8bt.jpg',
        },
        {
          'id': 299536,
          'title': 'Avengers: Infinity War',
          'posterPath': '/7WsyChQLEftFiDOVTGkv3hFpyyt.jpg',
        },
        {
          'id': 299534,
          'title': 'Avengers: Endgame',
          'posterPath': '/or06FN3Dka5tukK1e9sl16pB3iy.jpg',
        },
        {
          'id': 447365,
          'title': 'Guardians of the Galaxy Vol. 3',
          'posterPath': '/r2J02Z2OpNTctfOSN1Ydgii51I3.jpg',
        },
      ];
    }
  }
}