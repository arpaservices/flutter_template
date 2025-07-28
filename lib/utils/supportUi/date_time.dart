import 'package:intl/intl.dart';

class DateAndTime {
  static String getWhichPartOfDay() {
    // Get the current local time
    DateTime now = DateTime.now();
    int hour = now.hour;

    // Determine the greeting based on the hour of the day
    if (hour >= 5 && hour < 12) {
      return 'Morning';
    } else if (hour >= 12 && hour < 17) {
      return 'Afternoon';
    } else {
      return 'Evening';
    }
  }

  static String formatDateTime(DateTime dateTime) {
    // Convert the given DateTime to the local timezone
    DateTime localDateTime = dateTime.toLocal();

    DateTime now = DateTime.now();
    DateTime today = DateTime(now.year, now.month, now.day);
    DateTime yesterday = today.subtract(const Duration(days: 1));

    // Calculate the start and end of the current week (Monday to Sunday)
    DateTime startOfWeek =
        today.subtract(Duration(days: today.weekday - 1)); // Monday
    DateTime endOfWeek = startOfWeek.add(const Duration(days: 6)); // Sunday

    // Check if the date is today
    if (localDateTime.year == today.year &&
        localDateTime.month == today.month &&
        localDateTime.day == today.day) {
      return '${DateFormat('h:mm a').format(localDateTime)} today';
    }
    // Check if the date is yesterday
    else if (localDateTime.year == yesterday.year &&
        localDateTime.month == yesterday.month &&
        localDateTime.day == yesterday.day) {
      return '${DateFormat('h:mm a').format(localDateTime)} yesterday';
    }
    // Check if the date is within this week
    else if (localDateTime
            .isAfter(startOfWeek.subtract(const Duration(seconds: 1))) &&
        localDateTime.isBefore(endOfWeek.add(const Duration(seconds: 1)))) {
      return DateFormat('h:mm a, EEE')
          .format(localDateTime); // Day of the week (e.g., Mon, Tue)
    }
    // Otherwise, return the full date and time
    else {
      return DateFormat('h:mm a, d MMM').format(localDateTime);
    }
  }

  static String timeAgo(DateTime pastTime) {
    DateTime now = DateTime.now();
    Duration difference = now.difference(pastTime);

    if (difference.inMinutes < 1) {
      return "Just now";
    } else if (difference.inMinutes < 60) {
      return "${difference.inMinutes} mins ago";
    } else if (difference.inHours < 24) {
      return "${difference.inHours} hours ago";
    } else if (difference.inDays < 30) {
      return "${difference.inDays} days ago";
    } else if (difference.inDays < 365) {
      int months = (difference.inDays / 30).floor();
      return "$months months ago";
    } else {
      int years = (difference.inDays / 365).floor();
      return "$years years ago";
    }
  }
}
