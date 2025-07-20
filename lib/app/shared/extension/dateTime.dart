import 'package:intl/intl.dart';

extension formatTime on DateTime {
  String toFormattedTime() {
    return this
            .add(Duration(hours: 2))
            .toString()
            .split(' ')[1]
            .substring(0, 5) +
        (this.hour >= 12 ? ' PM' : ' AM');
  }

  String toFormattedDateTime() {
    return DateFormat("yyyy/MM/dd HH:mm").format(this);
  }

  String formatAttendanceDate() {
    return DateFormat("yyyy-MM-dd").format(this);
  }

  String formatSubscriptionTime() {
    return DateFormat("HH:mm").format(this);
  }

  String get greeting {
    final hour = this.hour;

    if (hour < 12) {
      return 'Good Morning';
    } else if (hour < 17) {
      return 'Good Afternoon';
    } else {
      return 'Good Evening';
    }
  }
}
