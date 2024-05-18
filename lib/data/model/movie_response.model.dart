class MovieResponse {
  final int id;
  final String title;
  final String overview;
  final String posterUrl;
  final String releaseDate;
  // final List<GenreResponse> genres;
  final List<int> videos;

  MovieResponse(
      {required this.id,
      required this.title,
      required this.overview,
      required this.posterUrl,
      required this.releaseDate,
      // required this.genres,
      required this.videos});
}
