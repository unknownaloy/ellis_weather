import 'package:ellis_weather/functions/date_formatter.dart';
import 'package:flutter_test/flutter_test.dart';

main() {
  group("DateTimeFormatter", () {
    group("hourMinutesFormatter test", () {
      test("Testing a valid timestamp", () {
        final result = DateTimeFormatter().hourMinutesFormatter(1629002776);

        expect(result, "5:46 AM");
      });

      test("Testing a null value", () {
        final result =
            DateTimeFormatter(() => 1629292524637).hourMinutesFormatter(null);

        expect(result, "9:50 AM");
      });
    });

    group("weekdayMonthDayFormatter test", () {
      test("Testing a valid timestamp", () {
        final result = DateTimeFormatter().weekdayMonthDayFormatter(1629234529);

        expect(result, "Tuesday, Aug 17");
      });

      test("Testing a null value", () {
        final result = DateTimeFormatter(() => 1629292524637)
            .weekdayMonthDayFormatter(null);

        expect(result, "Thursday, Mar 23");
      });
    });

    group("abbrWeekdayMonthFormatter", () {
      test("Testing a valid timestamp", () {
        final result =
            DateTimeFormatter().abbrWeekdayMonthFormatter(1629230400);

        expect(result, "Tue, Aug 17");
      });

      test("Testing a null value", () {
        final result =
            DateTimeFormatter(() => 1629230400).abbrWeekdayMonthFormatter(null);

        expect(result, "Tue, Aug 17");
      });
    });
  });
}
