import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/models/movie_model.dart';
import 'package:movie_app/pages/search/widgets/movie_search.dart';
import 'package:movie_app/services/api_services.dart'; 

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<Movie> filteredMovies = [];
  bool isLoading = false;
  String errorMessage = '';

  void searchMovies(String query) async {
    setState(() {
      isLoading = true;
      errorMessage = '';
    });

    try {
      if (query.isEmpty) {
        setState(() {
          filteredMovies = [];
          isLoading = false;
        });
      } else {
        final result = await getSearchedMovie(query);
        setState(() {
          filteredMovies = result.movies;
          isLoading = false;
        });
      }
    } catch (error) {
      setState(() {
        errorMessage = 'Error to find a movie';
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: CupertinoSearchTextField(
                padding: const EdgeInsets.all(10.0),
                prefixIcon: const Icon(
                  CupertinoIcons.search,
                  color: Colors.grey,
                ),
                suffixIcon: const Icon(
                  Icons.cancel,
                  color: Colors.grey,
                ),
                style: const TextStyle(color: Colors.white),
                backgroundColor: Colors.grey.withOpacity(0.3),
                onChanged: (value) {
                  searchMovies(value); // Chama o método de busca na API
                },
              ),
            ),
            const SizedBox(height: 10),
            if (isLoading)
              const Center(child: CircularProgressIndicator())
            else if (errorMessage.isNotEmpty)
              Center(child: Text(errorMessage))
            else if (filteredMovies.isEmpty)
              const Center(child: Text('Search a movie'))
            else
              Expanded(
                child: ListView.builder(
                  itemCount: filteredMovies.length,
                  itemBuilder: (context, index) {
                    return MovieSearch(movie: filteredMovies[index]);
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
