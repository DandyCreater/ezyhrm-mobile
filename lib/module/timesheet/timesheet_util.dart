class TimesheetUtil {
  static List<DateTime> getDaysInCurrentMonth(int year, int month) {
    DateTime firstDayOfMonth = DateTime(year, month, 1);
    DateTime lastDayOfMonth = DateTime(year, month + 1, 0);
    if (lastDayOfMonth.compareTo(DateTime.now()) > 0) {
      lastDayOfMonth = DateTime.now();
      lastDayOfMonth = lastDayOfMonth.subtract(Duration(days: 1));
    }

    List<DateTime> daysInMonth = [];
    for (DateTime date = firstDayOfMonth;
        date.isBefore(lastDayOfMonth.add(Duration(days: 1)));
        date = date.add(Duration(days: 1))) {
      daysInMonth.add(date);
    }

    return daysInMonth;
  }

  static List<DateTime> getHolidays() {
    List<String> dateStrings = [
      '1 January 2024',
      '10 February 2024',
      '11 February 2024',
      '12 February 2024',
      '29 March 2024',
      '10 April 2024',
      '1 May 2024',
      '22 May 2024',
      '17 June 2024',
      '9 August 2024',
      '31 October 2024',
      '25 December 2024',
      "1 January 2025",
      "29 January 2025",
      "30 January 2025",
      "31 March 2025",
      "18 April 2025",
      "1 May 2025",
      "12 May 2025",
      "7 June 2025",
      "9 August 2025",
      "20 October 2025",
      "25 December 2025"
    ];

    return dateStrings.map((dateString) {
      List<String> parts = dateString.split(' ');
      int day = int.parse(parts[0]);
      String monthString = parts[1];
      int year = int.parse(parts[2]);

      int month;
      switch (monthString) {
        case 'January':
          month = 1;
          break;
        case 'February':
          month = 2;
          break;
        case 'March':
          month = 3;
          break;
        case 'April':
          month = 4;
          break;
        case 'May':
          month = 5;
          break;
        case 'June':
          month = 6;
          break;
        case 'July':
          month = 7;
          break;
        case 'August':
          month = 8;
          break;
        case 'September':
          month = 9;
          break;
        case 'October':
          month = 10;
          break;
        case 'November':
          month = 11;
          break;
        case 'December':
          month = 12;
          break;
        default:
          throw Exception('Invalid month: $monthString');
      }

      return DateTime(year, month, day);
    }).toList();
  }
}
