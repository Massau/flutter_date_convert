int hoursInDay = 24;
int milissegundosEmUmSegundo = 1000;
int secondsInHour = 3600;

Map<int, dynamic> mounthsNonLeapYear = {
  1: {
    'name': 'January',
    'days': 31,
  },
  2: {
    'name': 'February',
    'days': 28,
  },
  3: {
    'name': 'March',
    'days': 31,
  },
  4: {
    'name': 'April',
    'days': 30,
  },
  5: {
    'name': 'May',
    'days': 31,
  },
  6: {
    'name': 'June',
    'days': 30,
  },
  7: {
    'name': 'July',
    'days': 31,
  },
  8: {
    'name': 'August',
    'days': 31,
  },
  9: {
    'name': 'September',
    'days': 30,
  },
  10: {
    'name': 'October',
    'days': 31,
  },
  11: {
    'name': 'November',
    'days': 30,
  },
  12: {
    'name': 'December',
    'days': 31,
  },
};

List<String> validFormats = [
  'd',
  'E',
  'EEEE',
  'LLL',
  'LLLL',
  'M',
  'Md',
  'MEd',
  'MMM',
  'MMMd',
  'MMMEd',
  'MMMM',
  'MMMMd',
  'MMMMEEEEd',
  'QQQ',
  'QQQQ',
  'y',
  'yM',
  'yMd',
  'yMEd',
  'yMMM',
  'yMMMd',
  'yMMMEd',
  'yMMMM',
  'yMMMMd',
  'yMMMMEEEEd',
  'yQQQ',
  'yQQQQ',
  'H',
  'Hm',
  'Hms',
  'j',
  'jm',
  'jms',
  'm',
  'ms',
  's',
  'yyyy-MM-dd hh:mm',
  'yyyy-MM-dd hh:mm:ss',
  'yyyy-mm-dd hh:mm',
  'yyyy-mm-dd hh:mm:ss',
  'jmv',
  'jmz',
  'jz'
];
