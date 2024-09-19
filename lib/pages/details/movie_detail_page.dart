import 'package:flutter/material.dart';
import 'package:movie_app/models/movie_model.dart';

class MovieDetailPage extends StatelessWidget {
  final Movie movie;

  const MovieDetailPage({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          movie.title,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {

          double screenWidth = constraints.maxWidth;
          double imageHeight = screenWidth > 1000 ? 600 : (screenWidth > 600 ? 500 : 400);
          double imageWidth = screenWidth > 1000 ? 400 : (screenWidth > 600 ? 300 : screenWidth);
          double fontSize = screenWidth > 1000 ? 24 : (screenWidth > 600 ? 20 : 16);
          
          if (screenWidth > 1000) {
            // Layout para monitores e telas grandes
            return Padding(
              padding: const EdgeInsets.all(32.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
              
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12.0),
                    child: Image.network(
                      'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                      fit: BoxFit.cover,
                      width: imageWidth,
                      height: imageHeight,
                    ),
                  ),
                  const SizedBox(width: 40),
                  // Detalhes do filme
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Release Date:',
                          style: TextStyle(
                            fontSize: fontSize,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[700],
                          ),
                        ),
                        Text(
                          movie.releaseDate?.toLocal().toString().split(' ')[0] ?? 'N/A',
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
                          movie.overview,
                          style: TextStyle(fontSize: fontSize - 2),
                          textAlign: TextAlign.justify,
                        ),
                        const SizedBox(height: 20),
                        Text(
                          'Popularity:',
                          style: TextStyle(
                            fontSize: fontSize,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[700],
                          ),
                        ),
                        Text(
                          movie.popularity.toString(),
                          style: TextStyle(fontSize: fontSize - 2),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          } else {
            // Layout para telas menores (celulares, tablets)
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12.0),
                      child: Image.network(
                        'https://image.tmdb.org/t/p/w500${movie.posterPath}',
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
                    movie.releaseDate?.toLocal().toString().split(' ')[0] ?? 'N/A',
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
                    movie.overview,
                    style: TextStyle(fontSize: fontSize - 2),
                    textAlign: TextAlign.justify,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Popularity:',
                    style: TextStyle(
                      fontSize: fontSize,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[700],
                    ),
                  ),
                  Text(
                    movie.popularity.toString(),
                    style: TextStyle(fontSize: fontSize - 2),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
