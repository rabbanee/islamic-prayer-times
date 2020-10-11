import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:islamic_prayer_times/viewModel/IslamicPrayerTimesViewModel.dart';
import 'package:intl/intl.dart';

import 'model/IslamicPrayerTimesModel.dart';

class IslamicPrayerTimes extends StatefulWidget {
  @override
  _IslamicPrayerTimesState createState() => _IslamicPrayerTimesState();
}

class _IslamicPrayerTimesState extends State<IslamicPrayerTimes> {
  IslamicPrayerTimesModel islamicPrayerTimes;
  Position _currentPosition;
  final String date = DateFormat('yyyy-MM-dd').format(DateTime.now());
  String _currentCity;
  final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;

  void getIslamicPrayerTimesByCityAndDate(currentCity) {
    IslamicPrayerTimesViewModel()
        .getIslamicPrayerTimesByCityAndDate(currentCity, date)
        .then((value) {
      if (value == null) {
        getIslamicPrayerTimesByCityAndDate('Jakarta');
      } else {
        setState(() {
          islamicPrayerTimes = value;
        });
      }
    });
  }

  _getCurrentLocation() {
    geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
      });
      _getAddressFromLatLng();
    }).catchError((e) {
      print('error location : $e');
      getIslamicPrayerTimesByCityAndDate('Jakarta');
    });
  }

  _getAddressFromLatLng() async {
    try {
      List<Placemark> p = await geolocator.placemarkFromCoordinates(
          _currentPosition.latitude, _currentPosition.longitude);

      Placemark place = p[0];
      setState(() {
        _currentCity = place.subAdministrativeArea;
      });
      getIslamicPrayerTimesByCityAndDate(_currentCity.split(' ').toList()[1]);
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Islamic Prayer Times'),
      ),
      body: islamicPrayerTimes == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              padding: EdgeInsets.only(top: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          date,
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    color: Colors.blue,
                    padding: EdgeInsets.all(14),
                    margin: EdgeInsets.fromLTRB(20, 0, 20, 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Fajr',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          islamicPrayerTimes.results.datetime[0].times.fajr,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    color: Colors.blue,
                    padding: EdgeInsets.all(14),
                    margin: EdgeInsets.fromLTRB(20, 0, 20, 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Dhuhr',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          islamicPrayerTimes.results.datetime[0].times.dhuhr,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    color: Colors.blue,
                    padding: EdgeInsets.all(14),
                    margin: EdgeInsets.fromLTRB(20, 0, 20, 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Asr',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          islamicPrayerTimes.results.datetime[0].times.asr,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    color: Colors.blue,
                    padding: EdgeInsets.all(14),
                    margin: EdgeInsets.fromLTRB(20, 0, 20, 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Maghrib',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          islamicPrayerTimes.results.datetime[0].times.maghrib,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    color: Colors.blue,
                    padding: EdgeInsets.all(14),
                    margin: EdgeInsets.fromLTRB(20, 0, 20, 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Isha',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          islamicPrayerTimes.results.datetime[0].times.isha,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      FlatButton.icon(
                        onPressed: () => _getCurrentLocation(),
                        icon: Icon(Icons.location_on),
                        label: Text(_currentCity ?? 'Search location..'),
                      )
                    ],
                  )
                ],
              ),
            ),
    );
  }
}
