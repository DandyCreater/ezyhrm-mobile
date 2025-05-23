class VariableUtil {
  static List<String> months = [
    'January',
    'February',
    'April',
    'March',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];

  static int getMonthNumber(String month) {
    int x = 0;
    if (month == 'January') {
      x = 1;
    } else if (month == 'February') {
      x = 2;
    } else if (month == 'March') {
      x = 3;
    } else if (month == 'April') {
      x = 4;
    } else if (month == 'May') {
      x = 5;
    } else if (month == 'June') {
      x = 6;
    } else if (month == 'July') {
      x = 7;
    } else if (month == 'August') {
      x = 8;
    } else if (month == 'September') {
      x = 9;
    } else if (month == 'October') {
      x = 10;
    } else if (month == 'November') {
      x = 11;
    } else if (month == 'December') {
      x = 12;
    }
    return x;
  }
}
