import 'package:flutter/material.dart';

import 'package:movies/src/providers/movies_provider.dart';
import 'package:movies/src/widgets/card_swiper_widget.dart';
import 'package:movies/src/widgets/movie_horizontal.dart';

class HomePage extends StatelessWidget {

  final _movieProvider = new MoviesProvider();

  @override
  Widget build(BuildContext context) {

    _movieProvider.getPopulars();

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text('Peliculas en cines'),
        backgroundColor: Colors.indigoAccent,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: (){},
          )
        ],
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            _swiperTarjets(),
            _footer(context)
          ],
        ),
      ),
    );
  }

  Widget _swiperTarjets() {

    return StreamBuilder(
        stream: _movieProvider.popularsStream,
        builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
          if(snapshot.hasData){
            return CardSwiper( movies: snapshot.data );
          }else{
            return Container(
              height: 400.0,
                child: Center(
                    child: CircularProgressIndicator()
                )
            );
          }
        }
    );
  }

 Widget _footer(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 20.0),
              child: Text('Populares', style: Theme.of(context).textTheme.bodyText1)
          ),
          SizedBox(height: 5.0),
          FutureBuilder(
              future: _movieProvider.getPopulars(),
              builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
                if(snapshot.hasData){
                  return MovieHorizontal( movies: snapshot.data, nextPage: _movieProvider.getPopulars );
                }else{
                  return Center(child: CircularProgressIndicator());
                }
           }),
        ],
      ),
    );
 }
}
