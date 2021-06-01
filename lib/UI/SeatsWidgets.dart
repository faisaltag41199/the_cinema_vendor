import 'package:flutter/material.dart';
import 'package:the_vendor/UI/Seat.dart';
import 'package:the_vendor/UI//BookScreen.dart';

//   Widget for date zero*********************************************************


//ignore: must_be_immutable
class seatWidgetDateA extends StatefulWidget {
  seatWidgetDateA(
      {@required this.movieTitle,
      @required this.seatDate,
      this.movieID});

  String movieTitle;
  String seatDate;
  String movieID;

  @override
  State<StatefulWidget> createState() {
    return new seatWidgetDateAState(
        movieTitle: movieTitle,
        seatDate: seatDate,
        movieID: movieID);
  }
}

class seatWidgetDateAState extends State<seatWidgetDateA> {
  seatWidgetDateAState(
      {@required this.movieTitle,
      @required this.seatDate,
      this.movieID});

  String movieID;

  String movieTitle;
  String seatDate;
  List<int> column = [4, 5];
  List<int> row = [0, 1, 2, 3];
  int i, j;

  @override
  Widget build(BuildContext context) {
    return new Container(
      width: double.maxFinite,
      height: 400.0,
      child: ListView(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        children: [
          Container(
            margin: EdgeInsets.only(top: 50.0, left: 15.0),
            child: Column(
              children: [
                Row(
                  children: [
                    for (int i = 0; i < 11; i++)
                      Column(
                        children: [
                          for (int j = 0; j < 5; j++)
                            column.contains(i) && row.contains(j)
                                ? Padding(
                                    padding: EdgeInsets.all(5.0),
                                    child: Container(
                                      width: 50,
                                      height: 50,
                                      child: Text(
                                        '    ',
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 5),
                                      ),
                                    ),
                                  )
                                : Seat(
                                    seatnum: '$i$j',
                                    movieTitle: movieTitle,
                                    seatDate: seatDate,
                                    movieID: movieID,
                                  ),
                        ],
                      )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

//   Widget for date one*********************************************************
class seatWidgetDateB extends StatefulWidget {
  seatWidgetDateB(
      {@required this.movieTitle,
      @required this.seatDate,
      this.movieID});

  String movieTitle;
  String seatDate;
  String movieID;

  @override
  State<StatefulWidget> createState() {
    return new seatWidgetDateBState(
        movieTitle: movieTitle,
        seatDate: seatDate,
        movieID: movieID);
  }
}

class seatWidgetDateBState extends State<seatWidgetDateB> {
  seatWidgetDateBState(
      {@required this.movieTitle,
      @required this.seatDate,
      this.movieID});
  String movieID;

  String movieTitle;
  String seatDate;
  List<int> column = [4, 5];
  List<int> row = [0, 1, 2, 3];
  int i, j;
  VoidCallback updatePriceCallback;

  @override
  Widget build(BuildContext context) {
    return new Container(
      width: double.maxFinite,
      height: 400.0,
      child: ListView(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        children: [
          Container(
            margin: EdgeInsets.only(top: 50.0, left: 15.0),
            child: Column(
              children: [
                Row(
                  children: [
                    for (int i = 0; i < 11; i++)
                      Column(
                        children: [
                          for (int j = 0; j < 5; j++)
                            column.contains(i) && row.contains(j)
                                ? Padding(
                                    padding: EdgeInsets.all(5.0),
                                    child: Container(
                                      width: 50,
                                      height: 50,
                                      child: Text(
                                        '    ',
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 5),
                                      ),
                                    ),
                                  )
                                : Seat(
                                    seatnum: '$i$j',
                                    movieTitle: movieTitle,
                                    seatDate: seatDate,
                                    movieID: movieID),
                        ],
                      )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

//   Widget for date two*********************************************************
class seatWidgetDateC extends StatefulWidget {
  seatWidgetDateC(
      {@required this.movieTitle,
      @required this.seatDate,
      this.movieID});

  String movieTitle;
  String seatDate;
  String movieID;

  @override
  State<StatefulWidget> createState() {
    return new seatWidgetDateCState(
        movieTitle: movieTitle,
        seatDate: seatDate,
        movieID: movieID);
  }
}

class seatWidgetDateCState extends State<seatWidgetDateC> {
  seatWidgetDateCState(
      {@required this.movieTitle,
      @required this.seatDate,
      this.movieID});
  String movieID;

  String movieTitle;
  String seatDate;
  List<int> column = [4, 5];
  List<int> row = [0, 1, 2, 3];
  int i, j;

  @override
  Widget build(BuildContext context) {
    return new Container(
      width: double.maxFinite,
      height: 400.0,
      child: ListView(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        children: [
          Container(
            margin: EdgeInsets.only(top: 50.0, left: 15.0),
            child: Column(
              children: [
                Row(
                  children: [
                    for (int i = 0; i < 11; i++)
                      Column(
                        children: [
                          for (int j = 0; j < 5; j++)
                            column.contains(i) && row.contains(j)
                                ? Padding(
                                    padding: EdgeInsets.all(5.0),
                                    child: Container(
                                      width: 50,
                                      height: 50,
                                      child: Text(
                                        '    ',
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 5),
                                      ),
                                    ),
                                  )
                                : Seat(
                                    seatnum: '$i$j',
                                    movieTitle: movieTitle,
                                    seatDate: seatDate,
                                    movieID: movieID),
                        ],
                      )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

//   Widget for date three*********************************************************
class seatWidgetDateD extends StatefulWidget {
  seatWidgetDateD(
      {@required this.movieTitle,
      @required this.seatDate,
      this.movieID});
  String movieID;

  String movieTitle;
  String seatDate;

  @override
  State<StatefulWidget> createState() {
    return new seatWidgetDateDState(
        movieTitle: movieTitle,
        seatDate: seatDate,
        movieID: movieID);
  }
}

class seatWidgetDateDState extends State<seatWidgetDateD> {
  seatWidgetDateDState(
      {@required this.movieTitle,
      @required this.seatDate,
      this.movieID});
  String movieID;

  String movieTitle;
  String seatDate;
  List<int> column = [4, 5];
  List<int> row = [0, 1, 2, 3];
  int i, j;

  @override
  Widget build(BuildContext context) {
    return new Container(
      width: double.maxFinite,
      height: 400.0,
      child: ListView(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        children: [
          Container(
            margin: EdgeInsets.only(top: 50.0, left: 15.0),
            child: Column(
              children: [
                Row(
                  children: [
                    for (int i = 0; i < 11; i++)
                      Column(
                        children: [
                          for (int j = 0; j < 5; j++)
                            column.contains(i) && row.contains(j)
                                ? Padding(
                                    padding: EdgeInsets.all(5.0),
                                    child: Container(
                                      width: 50,
                                      height: 50,
                                      child: Text(
                                        '    ',
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 5),
                                      ),
                                    ),
                                  )
                                : Seat(
                                    seatnum: '$i$j',
                                    movieTitle: movieTitle,
                                    seatDate: seatDate,
                                    movieID: movieID),
                        ],
                      )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

//   Widget for date four*********************************************************
class seatWidgetDateE extends StatefulWidget {
  seatWidgetDateE(
      {@required this.movieTitle,
      @required this.seatDate,
      this.movieID});

  String movieID;
  String movieTitle;
  String seatDate;

  @override
  State<StatefulWidget> createState() {
    return new seatWidgetDateEState(
        movieTitle: movieTitle,
        seatDate: seatDate,
        movieID: movieID);
  }
}

class seatWidgetDateEState extends State<seatWidgetDateE> {
  seatWidgetDateEState(
      {@required this.movieTitle,
      @required this.seatDate,
      this.movieID});

  String movieID;
  String movieTitle;
  String seatDate;
  List<int> column = [4, 5];
  List<int> row = [0, 1, 2, 3];
  int i, j;

  @override
  Widget build(BuildContext context) {
    return new Container(
      width: double.maxFinite,
      height: 400.0,
      child: ListView(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        children: [
          Container(
            margin: EdgeInsets.only(top: 50.0, left: 15.0),
            child: Column(
              children: [
                Row(
                  children: [
                    for (int i = 0; i < 11; i++)
                      Column(
                        children: [
                          for (int j = 0; j < 5; j++)
                            column.contains(i) && row.contains(j)
                                ? Padding(
                                    padding: EdgeInsets.all(5.0),
                                    child: Container(
                                      width: 50,
                                      height: 50,
                                      child: Text(
                                        '    ',
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 5),
                                      ),
                                    ),
                                  )
                                : Seat(
                                    seatnum: '$i$j',
                                    movieTitle: movieTitle,
                                    seatDate: seatDate,
                                    movieID: movieID),
                        ],
                      )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
