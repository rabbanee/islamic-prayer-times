import 'package:islamic_prayer_times/model/IslamicPrayerTimesModel.dart';
import 'package:http/http.dart' as http;
// import 'package:geolocator/geolocator.dart';

class IslamicPrayerTimesViewModel {
  Future<IslamicPrayerTimesModel> getIslamicPrayerTimesByCityAndDate(
      String city, String date) async {
    try {
      http.Response result = await http.get(
        Uri.encodeFull(
            'https://api.pray.zone/v2/times/day.json?city=$city&date=$date'),
        headers: {'Accept': 'Application/JSON'},
      );
      if (result.statusCode == 200) {
        print('Success to Get Data');
        final data = islamicPrayerTimesModelFromJson(result.body);
        return data;
      } else {
        print('Error status ${result.statusCode.toString()}');
        return null;
      }
    } catch (e) {
      print('Error Catch $e');
      return null;
    }
  }
}
