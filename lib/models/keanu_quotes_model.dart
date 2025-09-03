// objeto que armazena uma quote e as informações importantes, como fotos, vídeos e metadados.
class Quote {
  final String movie;
  final int year;
  final String releaseDate;
  final String director;
  final String character;
  final String movieDuration;
  final String timestamp;
  final String fullLine;
  final int currentWhoaInMovie;
  final int totalWhoasInMovie;
  final Video video;
  final String poster;

  Quote({required this.character, required this.currentWhoaInMovie, required this.director, required this.fullLine, required this.movie, required this.movieDuration, required this.poster, required this.releaseDate, required this.timestamp, required this.totalWhoasInMovie, required this.video, required this.year});

  factory Quote.fromJson(Map<String, dynamic> json) {
    return Quote(
      movie: json["movie"],
      year: json["year"],
      releaseDate: json["release_date"],
      director: json["director"],
      character: json["character"],
      movieDuration: json["movie_duration"],
      timestamp: json["timestamp"],
      fullLine: json["full_line"],
      currentWhoaInMovie: json["current_whoa_in_movie"],
      totalWhoasInMovie: json["total_whoas_in_movie"],
      video: Video.fromJson(json["video"]),
      poster: json["poster"]
    );
  }

  @override
  String toString() {
    return '''Quote(
      movie: $movie,
      year: $year,
      release_date: $releaseDate,
      director: $director,
      character: $character,
      movie_duration: $movieDuration, 
      timestamp: $timestamp, 
      full_line: $fullLine, 
      current_whoa_in_movie: $currentWhoaInMovie,
      total_whoas_in_movie: $totalWhoasInMovie,
      poster: $poster
      video: $video
    )''';
  }
}

// objeto que armazena os links em outras qualidades do video da quote
class Video {
  final String fullhd;
  final String hd;
  final String mediumLow;
  final String low;

  Video({required this.fullhd, required this.hd, required this.mediumLow, required this.low});

  factory Video.fromJson(Map<String, dynamic>json) {
    return Video(
      fullhd: json["1080p"],
      hd: json["720p"],
      mediumLow: json["480p"],
      low: json["360p"]
    );
  }

  @override
  String toString() {
    return '''Video(
        1080p: $fullhd, 
        720p: $hd, 
        480p: $mediumLow,
        360p: $low
      )''';
  }
}

// objeto que armazena uma lista de objetos Quote -- necessario para armazenar mais de uma quote vinda da API
class QuotesList {
  final List<Quote> quotes;

  QuotesList({required this.quotes});

  factory QuotesList.fromJson(List<dynamic> parsedJson) {
    List<Quote> quotes = parsedJson.map((quote) => Quote.fromJson(quote)).toList();

    return QuotesList(quotes: quotes);
  }
}