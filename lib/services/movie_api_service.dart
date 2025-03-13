import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/movie.dart';

class MovieApiService {
  final String apiKey = '1397938d91895ce060848db67a68bfaa';
  final String baseUrl = 'https://api.themoviedb.org/3';
  final http.Client client = http.Client();

  Future<List<Movie>> getNowPlayingMovies() async {
    try {
      final response = await client.get(
        Uri.parse('$baseUrl/movie/now_playing?api_key=$apiKey'),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        return (data['results'] as List)
            .map((movie) => Movie.fromJson(movie))
            .toList();
      } else {
        throw Exception('Failed to load now playing movies');
      }
    } catch (e) {
      // If API is unavailable, return mock data
      return _getMockNowPlayingMovies();
    }
  }

  Future<List<Movie>> getPopularMovies() async {
    try {
      final response = await client.get(
        Uri.parse('$baseUrl/movie/popular?api_key=$apiKey'),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        return (data['results'] as List)
            .map((movie) => Movie.fromJson(movie))
            .toList();
      } else {
        throw Exception('Failed to load popular movies');
      }
    } catch (e) {
      // If API is unavailable, return mock data
      return _getMockPopularMovies();
    }
  }

  // Mock data for Now Playing movies
  List<Movie> _getMockNowPlayingMovies() {
    return [
      Movie(
        id: 693134,
        title: 'Dune: Part Two',
        posterPath: '/8b8R8l88Qje9dn9OE8PY05Nxl1X.jpg',
        backdropPath: '/zIYROrkHJPYB3VTiW1L9QVgaQO.jpg',
        overview:
            'Follow the mythic journey of Paul Atreides as he unites with Chani and the Fremen while on a path of revenge against the conspirators who destroyed his family. Facing a choice between the love of his life and the fate of the known universe, Paul endeavors to prevent a terrible future only he can foresee.',
        voteAverage: 8.2,
        releaseDate: '2024-02-28',
      ),
      Movie(
        id: 1011985,
        title: 'Kung Fu Panda 4',
        posterPath: '/kDp1vUBnMpe8ak4rjgl3cLELqjU.jpg',
        backdropPath: '/cP8YNG3XUeBrs1OC3XpozQT8CPl.jpg',
        overview:
            'Po is gearing up to become the spiritual leader of his Valley of Peace, but also needs someone to take his place as Dragon Warrior. As such, he will train a new kung fu practitioner for the title and will encounter a villain called the Chameleon who conjures villains from the past.',
        voteAverage: 7.1,
        releaseDate: '2024-03-02',
      ),
      Movie(
        id: 763215,
        title: 'Godzilla x Kong: The New Empire',
        posterPath: '/bQ2ywkddNU4NRB7uLYKBwmKnKmQ.jpg',
        backdropPath: '/uUiIGztTrfDhPdAFJpr6m4UBMAd.jpg',
        overview:
            'Following their explosive showdown, Godzilla and Kong must reunite against a colossal undiscovered threat hidden within our world, challenging their very existence – and our own.',
        voteAverage: 7.0,
        releaseDate: '2024-03-27',
      ),
      Movie(
        id: 1034587,
        title: 'The Fall Guy',
        posterPath: '/bMQN2JU0tWOXKHhhpDOntGkZ5p.jpg',
        backdropPath: '/5YZbUmjbMa3ClvSW1Wj3D6XGolb.jpg',
        overview:
            'Colt Seavers, a battle-scarred stuntman who, having left the business a year earlier to focus on both his physical and mental health, is drafted back into service when the star of a mega-budget studio movie—being directed by his ex, Jody Moreno—goes missing.',
        voteAverage: 7.0,
        releaseDate: '2024-04-30',
      ),
      Movie(
        id: 457332,
        title: 'Furiosa: A Mad Max Saga',
        posterPath: '/p0WQyQRnjI4MUIKJOm2cVJ5hlY.jpg',
        backdropPath: '/xIC45XHPFqyD3Jgj8jL1KmZPrGj.jpg',
        overview:
            'As the world fell, young Furiosa is snatched from the Green Place of Many Mothers and falls into the hands of a great Biker Horde led by the Warlord Dementus. Sweeping through the Wasteland, they come across the Citadel presided over by The Immortan Joe. While the two Tyrants war for dominance, Furiosa must survive many trials as she puts together the means to find her way home.',
        voteAverage: 6.8,
        releaseDate: '2024-05-22',
      ),
    ];
  }

  // Mock data for Popular movies
  List<Movie> _getMockPopularMovies() {
    return [
      Movie(
        id: 693134,
        title: 'Dune: Part Two',
        posterPath: '/8b8R8l88Qje9dn9OE8PY05Nxl1X.jpg',
        backdropPath: '/zIYROrkHJPYB3VTiW1L9QVgaQO.jpg',
        overview:
            'Follow the mythic journey of Paul Atreides as he unites with Chani and the Fremen while on a path of revenge against the conspirators who destroyed his family. Facing a choice between the love of his life and the fate of the known universe, Paul endeavors to prevent a terrible future only he can foresee.',
        voteAverage: 8.2,
        releaseDate: '2024-02-28',
      ),
      Movie(
        id: 1011985,
        title: 'Kung Fu Panda 4',
        posterPath: '/kDp1vUBnMpe8ak4rjgl3cLELqjU.jpg',
        backdropPath: '/cP8YNG3XUeBrs1OC3XpozQT8CPl.jpg',
        overview:
            'Po is gearing up to become the spiritual leader of his Valley of Peace, but also needs someone to take his place as Dragon Warrior. As such, he will train a new kung fu practitioner for the title and will encounter a villain called the Chameleon who conjures villains from the past.',
        voteAverage: 7.1,
        releaseDate: '2024-03-02',
      ),
      Movie(
        id: 763215,
        title: 'Godzilla x Kong: The New Empire',
        posterPath: '/bQ2ywkddNU4NRB7uLYKBwmKnKmQ.jpg',
        backdropPath: '/uUiIGztTrfDhPdAFJpr6m4UBMAd.jpg',
        overview:
            'Following their explosive showdown, Godzilla and Kong must reunite against a colossal undiscovered threat hidden within our world, challenging their very existence – and our own.',
        voteAverage: 7.0,
        releaseDate: '2024-03-27',
      ),
      Movie(
        id: 1237095,
        title: 'The Ministry of Ungentlemanly Warfare',
        posterPath: '/pLHgvF1G1wbGuXq7cLNf8Vvyhd4.jpg',
        backdropPath: '/oBIQDKcqNxKckjugtmzpIIOgoc4.jpg',
        overview:
            'In 1939, the British government creates the Special Operations Executive (SOE), a top-secret spy organization tasked with defeating the Nazis by any means necessary. With conventional military tactics failing, Winston Churchill gives the SOE orders to recruit, train and deploy a band of military rejects and rogues to execute a dangerous and audacious mission - to sink German ships hiding in the neutral harbor of Fernando Po off the west coast of Africa.',
        voteAverage: 6.8,
        releaseDate: '2024-04-04',
      ),
      Movie(
        id: 770822,
        title: 'Hypnotic',
        posterPath: '/3IhGkkalwXguTlceGSl8XUJZOVI.jpg',
        backdropPath: '/h8HZbaXJTcRiLFjOi7jnlRVgPLx.jpg',
        overview:
            'A detective investigating a mystery involving his missing daughter and a secret government program becomes entangled in a series of reality-bending events that blur the line between dreams and the real world. As he navigates through hallucinations and twisted perceptions, he must confront his past and find his daughter before time runs out.',
        voteAverage: 6.2,
        releaseDate: '2023-05-11',
      ),
    ];
  }
}
