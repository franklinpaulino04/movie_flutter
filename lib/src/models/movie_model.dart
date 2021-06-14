
class Movies {

  List<Movie> items = new List();

  Movies();

  Movies.fromJsonList(List<dynamic> jsonList){
    if(jsonList.length > 0){
      for(var item in jsonList){
        final movie = new Movie.fromJsonMap(item);
        items.add(movie);
      }
    }
    else {
      return;
    }
  }
}

class Movie {
    int vote_count;
    int id;
    bool video;
    double vote_average;
    String title;
    double popularity;
    String poster_path;
    String original_language;
    String original_title;
    List<int> genre_ids;
    String backdrop_path;
    bool adult;
    String overview;
    String release_date;

    Movie({
      this.vote_count,
      this.id,
      this.video,
      this.vote_average,
      this.title,
      this.popularity,
      this.poster_path,
      this.original_language,
      this.original_title,
      this.genre_ids,
      this.backdrop_path,
      this.adult,
      this.overview,
      this.release_date
    });

    Movie.fromJsonMap(Map<String, dynamic> json ){

      vote_count        = json['vote_count'];
      id                = json['id'];
      video             = json['video'];
      vote_average      = json['vote_average'] / 1 ;
      title             = json['title'];
      popularity        = json['popularity'] / 1;
      poster_path       = json['poster_path'];
      original_language = json['original_language'];
      original_title    = json['original_title'];
      genre_ids         = json['genre_ids'].cast<int>();
      backdrop_path     = json['backdrop_path'];
      adult             = json['adult'];
      overview          = json['overview'];
      release_date      = json['release_date'];

    }

    getPosterImg(){
      return (poster_path == null) ? 'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcRjmA3g5EfntVjxw4igA07ZFWpuQhb-A3dHIXJkawJGDwdlsI56&usqp=CAU'
                                   : 'https://image.tmdb.org/t/p/w500/$poster_path';
    }
}