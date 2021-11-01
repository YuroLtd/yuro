class DateTimeFormats {
  static const String DEFAULT = 'yyyy-MM-dd HH:mm:ss';
  static const String DATE = 'yyyy-MM-dd';
  static const String TIME = 'HH:mm:ss';

  ///根据format格式化DateTime,默认format为yyyy-MM-dd HH:mm:ss
  String format(DateTime datetime, [String format = DEFAULT]) {
    int year = 0, month = 0, day = 0, hour = 0, minute = 0, second = 0;
    format.split('').forEach((chr) {
      switch (chr) {
        case 'y':
          year++;
          break;
        case 'M':
          month++;
          break;
        case 'd':
          day++;
          break;
        case 'H':
          hour++;
          break;
        case 'm':
          minute++;
          break;
        case 's':
          second++;
          break;
      }
    });

    String formatStr = format;
    if (year > 0) {
      var yearStr = datetime.year.toString().substring(year == 4 ? 0 : 2);
      formatStr = formatStr.replaceFirst('y' * year, yearStr);
    }
    if (month > 0) {
      var monthStr = month == 1 ? '${datetime.month}' : '${datetime.month}'.padLeft(2, '0');
      formatStr = formatStr.replaceFirst('M' * month, monthStr);
    }
    if (day > 0) {
      var dayStr = day == 1 ? '${datetime.day}' : '${datetime.day}'.padLeft(2, '0');
      formatStr = formatStr.replaceFirst('d' * day, dayStr);
    }
    if (hour > 0) {
      var hourStr = hour == 1 ? '${datetime.hour}' : '${datetime.hour}'.padLeft(2, '0');
      formatStr = formatStr.replaceFirst('H' * hour, hourStr);
    }
    if (minute > 0) {
      var minuteStr = minute == 1 ? '${datetime.minute}' : '${datetime.minute}'.padLeft(2, '0');
      formatStr = formatStr.replaceFirst('m' * minute, minuteStr);
    }
    if (second > 0) {
      var secondStr = second == 1 ? '${datetime.second}' : '${datetime.second}'.padLeft(2, '0');
      formatStr = formatStr.replaceFirst('s' * second, secondStr);
    }
    return formatStr;
  }
}
