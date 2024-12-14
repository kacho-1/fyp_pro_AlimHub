import 'package:adhan/adhan.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';

class PrayerUtils {
  static Future<String> getUpcomingPrayer(Location location) async {
    LocationData? currentPosition = await location.getLocation();
    double? latitude = currentPosition.latitude;
    double? longitude = currentPosition.longitude;

    if (latitude != null && longitude != null) {
      final myCoordinates = Coordinates(latitude, longitude);
      final params = CalculationMethod.karachi.getParameters();
      params.madhab = Madhab.hanafi;

      // Get today's prayer times
      final prayerTimesToday = PrayerTimes.today(myCoordinates, params);

      // Calculate tomorrow's date components
      final DateTime tomorrowDate = DateTime.now().add(const Duration(days: 1));
      final DateComponents tomorrowComponents = DateComponents(
        tomorrowDate.year,
        tomorrowDate.month,
        tomorrowDate.day,
      );

      // Get tomorrow's prayer times using DateComponents
      final prayerTimesTomorrow = PrayerTimes(
        myCoordinates,
        tomorrowComponents,
        params,
      );

      final now = DateTime.now();

      // Compare current time with today's prayer times
      if (now.isBefore(prayerTimesToday.fajr)) {
        return 'Fajr at ${DateFormat.jm().format(prayerTimesToday.fajr)}';
      } else if (now.isBefore(prayerTimesToday.sunrise)) {
        return 'Sunrise at ${DateFormat.jm().format(prayerTimesToday.sunrise)}';
      } else if (now.isBefore(prayerTimesToday.dhuhr)) {
        return 'Dhuhr at ${DateFormat.jm().format(prayerTimesToday.dhuhr)}';
      } else if (now.isBefore(prayerTimesToday.asr)) {
        return 'Asr at ${DateFormat.jm().format(prayerTimesToday.asr)}';
      } else if (now.isBefore(prayerTimesToday.maghrib)) {
        return 'Maghrib at ${DateFormat.jm().format(prayerTimesToday.maghrib)}';
      } else if (now.isBefore(prayerTimesToday.isha)) {
        return 'Isha at ${DateFormat.jm().format(prayerTimesToday.isha)}';
      } else {
        // After Isha, return tomorrow's Fajr
        return 'Fajr at ${DateFormat.jm().format(prayerTimesTomorrow.fajr)}';
      }
    }

    return 'Location not available.';
  }
}




/*class PrayerUtils {
  static Future<String> getUpcomingPrayer(Location location) async {
    LocationData? _currentPosition = await location.getLocation();
    double? latitude = _currentPosition.latitude;
    double? longitude = _currentPosition.longitude;

    if (latitude != null && longitude != null) {
      final myCoordinates = Coordinates(latitude, longitude);
      final params = CalculationMethod.karachi.getParameters();
      params.madhab = Madhab.hanafi;

      final prayerTimes = PrayerTimes.today(myCoordinates, params);
      final now = DateTime.now();


      if (now.isBefore(prayerTimes.fajr)) {
        return ' Fajr at ${DateFormat.jm().format(prayerTimes.fajr)}';
      } else if (now.isBefore(prayerTimes.sunrise)) {
        return ' Sunrise at ${DateFormat.jm().format(prayerTimes.sunrise)}';
      } else if (now.isBefore(prayerTimes.dhuhr)) {
        return ' Dhuhr at ${DateFormat.jm().format(prayerTimes.dhuhr)}';
      } else if (now.isBefore(prayerTimes.asr)) {
        return ' Asr at ${DateFormat.jm().format(prayerTimes.asr)}';
      } else if (now.isBefore(prayerTimes.maghrib)) {
        return ' Maghrib at ${DateFormat.jm().format(prayerTimes.maghrib)}';
      } else if (now.isBefore(prayerTimes.isha)) {
        return ' Isha at ${DateFormat.jm().format(prayerTimes.isha)}';
      } else {
        return 'No more prayers today.';
      }
    }
    return 'Location not available.';
  }
}*/
