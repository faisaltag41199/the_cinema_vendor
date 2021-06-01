class MovieData {
  String _id;
  String _title;
  String _description;
  String _numberOfSeats;
  String _image;
  String _movieTime;

  static final MovieData movieDataInstance = new MovieData();

  String get id => _id;

  set id(String value) {
    _id = value;
  }

  String get title => _title;

  set title(String value) {
    _title = value;
  }

  String get description => _description;

  set description(String value) {
    _description = value;
  }

  String get movieTime => _movieTime;

  set movieTime(String value) {
    _movieTime = value;
  }

  String get image => _image;

  set image(String value) {
    _image = value;
  }

  String get numberOfSeats => _numberOfSeats;

  set numberOfSeats(String value) {
    _numberOfSeats = value;
  }

}
