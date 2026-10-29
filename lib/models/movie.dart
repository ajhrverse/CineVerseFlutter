class Movie {
  final String id;
  final String title;
  final String year;
  final String genre;
  final String rating;
  final String duration;
  final String synopsis;
  final String posterUrl;
  final String backdropUrl;
  final bool isSeries;
  final List<String> cast;
  final List<String> episodes;

  const Movie({
    required this.id,
    required this.title,
    required this.year,
    required this.genre,
    required this.rating,
    required this.duration,
    required this.synopsis,
    required this.posterUrl,
    required this.backdropUrl,
    this.isSeries = false,
    this.cast = const [],
    this.episodes = const [],
  });
}
