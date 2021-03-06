import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:movies/src/models/movie_model.dart';

class MovieHorizontal extends StatelessWidget {

  final List<Movie> movies;
  final Function nextPage;

  MovieHorizontal({ @required this.movies, @required this.nextPage });

  final _pageController =  new PageController(
      initialPage: 1,
      viewportFraction: 0.3
  );

  @override
  Widget build(BuildContext context) {

    final _screenSize = MediaQuery.of(context).size;

    _pageController.addListener(() {

      if(_pageController.position.pixels >= _pageController.position.maxScrollExtent - 200) {
        nextPage();
      }

    });

    return Container(
      height: _screenSize.height * 0.2,
      child: PageView(
        pageSnapping: false,
        children: _tarjets(context),
        controller: _pageController,
      ),
    );

  }

  List<Widget> _tarjets(BuildContext context) {
    return movies.map( (movie) {

      return Container(
        margin: EdgeInsets.only(bottom: 1.0),
        child: Column(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: FadeInImage(
                image: NetworkImage( movie.getPosterImg() ),
                placeholder: AssetImage('assets/img/no-image.jpg'),
                fit: BoxFit.cover,
                height: 110.0,
              ),
            ),
            Text(
              movie.title,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.caption,
            )
          ],
        ),
      );
    }).toList();
 }
}
