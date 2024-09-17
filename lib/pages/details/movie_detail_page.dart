import 'package:flutter/material.dart';
import 'package:movie_app/models/movie_model.dart';

class MovieDetailPage extends StatelessWidget {
  final Movie movie;

  const MovieDetailPage({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(movie.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              movie.title,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 400 ,child: Image.network(
                    'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                    fit: BoxFit.fitWidth,
                  ),),
            const SizedBox(height: 10),
            Text('Release Date: ${movie.releaseDate?.toLocal().toString().split(' ')[0] ?? 'N/A'}'),
            const SizedBox(height: 10),
            Text('Overview: ${movie.overview}'),

          ],
        ),
      ),
    );
  }
}
