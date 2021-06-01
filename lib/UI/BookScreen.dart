import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:the_vendor/DataCloud/MovieData.dart';
import 'package:intl/intl.dart';
import 'package:the_vendor/UI/Seat.dart';
import 'package:the_vendor/UI/SeatsWidgets.dart';
import 'package:the_vendor/DataCloud/SeatData.dart';
import 'package:the_vendor/DataCloud/TicketData.dart';
import 'package:firebase_database/firebase_database.dart';

//ignore: must_be_immutable
class BookScreen extends StatefulWidget {
  BookScreen(this.movieData);

  MovieData movieData;

  @override
  BookScreenState createState() => BookScreenState(movieData);
}

class BookScreenState extends State<BookScreen> {
  BookScreenState(this.movieData);

  MovieData movieData;
  List<DateTime> dateList;
  var movieshowtime, clickedTime = " ";
  int clickedtimeindex = 0, eraseAllListsDataflag;

  List<Widget> BoxesWidgetSwitcher;
  List<MaterialColor> boxColors;
  List<String> seatDateList;
  List<SeatData> seatDataList = SeatData.bookSeats;
  List<String> holdseatList = SeatData.holdSeats;
  String price = "0";
  TicketData dataOfTicket = new TicketData();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  var holdSeatsRef = FirebaseDatabase.instance.reference().child("Holdseats");

  @override
  void initState() {
    setDateList();
    setSeatDate();
    intiateBoxesWidgetSwitcher();
    boxColors = [Colors.blue, Colors.red, Colors.red, Colors.red, Colors.red];
  }

// the ui screen code ********
  @override
  Widget build(BuildContext context) {
    return Scaffold(
            key: _scaffoldKey,
            body: Container(
              child: ListView(
                shrinkWrap: true,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 30),
                    height: 120,
                    width: double.maxFinite,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        padding: EdgeInsets.all(10.0),
                        itemCount: dateList.length,
                        itemBuilder: (context, position) {
                          return Column(
                            children: [
                              Card(
                                elevation: 5,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                          color: boxColors[position],
                                        ),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10))),
                                    child: InkWell(
                                      child: Column(
                                        children: [
                                          Text(
                                            DateFormat('EEEE')
                                                .format(dateList[position]),
                                            style: TextStyle(
                                              color: boxColors[position],
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18,
                                            ),
                                          ),
                                          Text(
                                              dateList[position]
                                                      .day
                                                      .toString() +
                                                  "-" +
                                                  dateList[position]
                                                      .month
                                                      .toString() +
                                                  "-" +
                                                  dateList[position]
                                                      .year
                                                      .toString(),
                                              style: TextStyle(
                                                color: boxColors[position],
                                              )),
                                          Text(movieshowtime,
                                              style: TextStyle(
                                                color: boxColors[position],
                                              ))
                                        ],
                                      ),
                                      onTap: () {
                                        this.setState(() {
                                          clickedtimeindex = position;
                                          print(clickedtimeindex);
                                          setTabDateColor(position);
                                        });
                                      },
                                    )),
                              )
                            ],
                          );
                        }),
                  ),
                  // the screen
                  Padding(padding: EdgeInsets.only(top: 30.0)),
                  Center(
                      child: Column(
                    children: [
                      Text(
                        "Vip Screen",
                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      Container(
                        width: 200,
                        height: 120,
                        child: Card(
                            elevation: 7,
                            child: FittedBox(
                              child: Image.network(movieData.image),
                              fit: BoxFit.fill,
                            )),
                      ),
                    ],
                  )),
                  // the seats
                  BoxesWidgetSwitcher[clickedtimeindex],
                ],
              ),
            ));
  }

  setDateList() {
    var DateTimeSplit = movieData.movieTime.split(" ");

    var DateSplit = DateTimeSplit[0].split("-");

    var TimeSplit = DateTimeSplit[1].split(":");

    var day = DateSplit[0];
    var month = getMonthAsNum(DateSplit[1].toString());
    print(month);
    var year = DateSplit[2];

    final items = List<DateTime>.generate(
        5,
        (i) => DateTime.utc(
              int.parse(year),
              month,
              int.parse(day),
            ).add(Duration(days: i)));

    this.setState(() {
      dateList = items;
      movieshowtime = DateTimeSplit[1];
    });
  }

  int getMonthAsNum(monthName) {
    Map map = {
      'January': 1,
      'February': 2,
      'March': 3,
      'April': 4,
      'May': 5,
      'June': 6,
      'July': 7,
      'August': 8,
      'September': 9,
      'October': 10,
      'November': 11,
      'December': 12
    };

    return map[monthName];
  }

  _SaveMovieTime(dateTime) {
    print(dateTime);
    return;
  }

  setSeatDate() {
    seatDateList = List<String>.generate(
        5,
        (i) =>
            dateList[i].day.toString() +
            "-" +
            dateList[i].month.toString() +
            "-" +
            dateList[i].year.toString() +
            " " +
            movieshowtime);
  }

  setTabDateColor(int position) {
    for (int i = 0; i < boxColors.length; i++) {
      if (i == position) {
        this.setState(() {
          boxColors[i] = Colors.blue;
        });
        continue;
      }

      this.setState(() {
        boxColors[i] = Colors.red;
      });
    }
  }

  intiateBoxesWidgetSwitcher() {
    BoxesWidgetSwitcher = [
      new seatWidgetDateA(
          movieTitle: movieData.title,
          seatDate: seatDateList[0],
          movieID: movieData.id),
      new seatWidgetDateB(
          movieTitle: movieData.title,
          seatDate: seatDateList[1],
          movieID: movieData.id),
      new seatWidgetDateC(
          movieTitle: movieData.title,
          seatDate: seatDateList[2],
          movieID: movieData.id),
      new seatWidgetDateD(
          movieTitle: movieData.title,
          seatDate: seatDateList[3],
          movieID: movieData.id),
      new seatWidgetDateE(
          movieTitle: movieData.title,
          seatDate: seatDateList[4],
          movieID: movieData.id),
    ];
  }
}
