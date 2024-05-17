enum Routes {
  main("/"),
  movieList("/movie/list"),
  movieDetail("/movie/detail");

  const Routes(this.path);

  final String path;
}
