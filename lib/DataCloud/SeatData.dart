class SeatData {
  String _movieTitle;
  String _movieDate;
  String _movieID;
  String _seatNum;
  String _userID;

  static List<SeatData> bookSeats = new List();
  static List<String> holdSeats = new List();

  String get movieTitle => _movieTitle;

  set movieTitle(String value) {
    _movieTitle = value;
  }

  String get movieDate => _movieDate;

  set movieDate(String value) {
    _movieDate = value;
  }

  String get movieID => _movieID;

  set movieID(String value) {
    _movieID = value;
  }

  String get seatNum => _seatNum;

  set seatNum(String value) {
    _seatNum = value;
  }

  String get userID => _userID;

  set userID(String value) {
    _userID = value;
  }
}
