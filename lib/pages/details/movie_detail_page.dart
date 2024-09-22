import 'package:flutter/material.dart';
import 'package:movie_app/models/movie_model.dart';
import 'package:movie_app/services/api_services.dart';
import 'package:cached_network_image/cached_network_image.dart';

class MovieDetailPage extends StatefulWidget {
  final Movie movie;

  const MovieDetailPage({
    Key? key,
    required this.movie,
  }) : super(key: key);

  @override
  _MovieDetailPageState createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  ApiServices apiServices = ApiServices();
  late Future<List<Movie>> similarMovies;

  @override
  void initState() {
    super.initState();
    similarMovies = apiServices.getSimilarMovies(widget.movie.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.movie.title,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          double screenWidth = constraints.maxWidth;
          double imageHeight = screenWidth > 1000
              ? 600
              : (screenWidth > 600 ? 500 : 400);
          double imageWidth = screenWidth > 1000
              ? 400
              : (screenWidth > 600 ? 300 : screenWidth);
          double fontSize = screenWidth > 1000
              ? 24
              : (screenWidth > 600 ? 20 : 16);

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12.0),
                    child: Image.network(
                      'https://image.tmdb.org/t/p/w500${widget.movie.posterPath}',
                      fit: BoxFit.cover,
                      width: imageWidth,
                      height: imageHeight,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'Release Date:',
                  style: TextStyle(
                    fontSize: fontSize,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[700],
                  ),
                ),
                Text(
                  widget.movie.releaseDate
                          ?.toLocal()
                          .toString()
                          .split(' ')[0] ??
                      'N/A',
                  style: TextStyle(fontSize: fontSize - 2),
                ),
                const SizedBox(height: 20),
                Text(
                  'Overview:',
                  style: TextStyle(
                    fontSize: fontSize,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[700],
                  ),
                ),
                Text(
                  widget.movie.overview,
                  style: TextStyle(fontSize: fontSize - 2),
                  textAlign: TextAlign.justify,
                ),
                const SizedBox(height: 20),
                Text(
                  'Film Review:',
                  style: TextStyle(
                    fontSize: fontSize,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[700],
                  ),
                ),
                Text(
                  widget.movie.voteAverage.toStringAsFixed(1),
                  style: TextStyle(fontSize: fontSize - 2),
                ),
                const SizedBox(height: 20),
                Text(
                  'Similar Movies:',
                  style: TextStyle(
                    fontSize: fontSize,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[700],
                  ),
                ),
                FutureBuilder<List<Movie>>(
                  future: similarMovies,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final movies = snapshot.data!;
                      return Container(
                        height: 200, // Altura do contêiner para a lista horizontal
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: movies.length,
                          itemBuilder: (context, index) {
                            final similarMovie = movies[index];
                            return GestureDetector(
                              onTap: () {
                                // Navegue para a página de detalhes do filme semelhante
                              },
                              child: Container(
                                width: 120, // Largura de cada item
                                margin: const EdgeInsets.only(right: 10),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8.0),
                                  child: CachedNetworkImage(
                                    imageUrl: 'https://image.tmdb.org/t/p/w500${similarMovie.posterPath}',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    } else if (snapshot.hasError) {
                      return Text('Erro: ${snapshot.error}');
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
