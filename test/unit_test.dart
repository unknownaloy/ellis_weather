import 'package:ellis_weather/utilities/utils.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';

main() {
  group("Test for timestamp formatters", () {
    group("hourMinutesFormatter test", () {
      test("Testing a valid timestamp", () {
        String result = Utils.hourMinutesFormatter(1629002776);

        expect(result, "5:46 AM");
      });

      test("Testing a null value", () {
        final hourMinutesFormat = DateFormat("jm");
        final timeStamp = DateTime.now().millisecondsSinceEpoch;
        final dateTime = DateTime.fromMillisecondsSinceEpoch(timeStamp * 1000);
        final expectedResult = hourMinutesFormat.format(dateTime);
        String result = Utils.hourMinutesFormatter(null);

        expect(result, expectedResult);
      });
    });

    group("weekdayMonthDayFormatter test", () {
      test("Testing a valid timestamp", () {
        final result = Utils.weekdayMonthDayFormatter(1629234529);

        expect(result, "Tuesday, Aug 17");
      });

      test("Testing a null value", () {
        final weekdayMonthDayFormat = DateFormat("EEEE, LLL d");
        final timeStamp = DateTime.now().millisecondsSinceEpoch;
        final dateTime = DateTime.fromMillisecondsSinceEpoch(timeStamp * 1000);
        final expectedResult = weekdayMonthDayFormat.format(dateTime);

        final result = Utils.weekdayMonthDayFormatter(null);

        expect(result, expectedResult);
      });
    });

    group("abbrWeekdayMonthFormatter", () {
      test("Testing a valid timestamp", () {
        final result = Utils.abbrWeekdayMonthFormatter(1629230400);

        expect(result, "Tue, Aug 17");
      });

      test("Testing a null value", () {
        final abrWeekDayMonthDayFormat = DateFormat("E, LLL d");
        final timeStamp = DateTime.now().millisecondsSinceEpoch;
        final dateTime = DateTime.fromMillisecondsSinceEpoch(timeStamp * 1000);
        final expectedResult = abrWeekDayMonthDayFormat.format(dateTime);

        final result = Utils.abbrWeekdayMonthFormatter(null);

        expect(result, expectedResult);
      });
    });
  });
}
