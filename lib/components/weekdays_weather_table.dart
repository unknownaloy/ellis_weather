import 'package:cached_network_image/cached_network_image.dart';
import 'package:ellis_weather/functions/date_formatter.dart';
import 'package:ellis_weather/utilities/utils.dart';
import 'package:ellis_weather/utilities/const.dart';
import 'package:ellis_weather/view_models/weather_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WeekdaysWeatherTable extends StatelessWidget {
  const WeekdaysWeatherTable({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dailyWeatherData =
        Provider.of<WeatherViewModel>(context).weatherData.daily;

    List<TableRow> listOfTableRow = [];

    for (int i = 1; i < dailyWeatherData!.length; i++) {
      final dateFormatter = DateTimeFormatter();

      final tableWeatherData = dailyWeatherData[i];

      final weatherDataDateTime = tableWeatherData.dateTime;

      String dayOfWeek = dateFormatter.abbrWeekdayMonthFormatter(weatherDataDateTime);

      final widgetToReturn = TableRow(
        children: [
          Text(
            "$dayOfWeek${Utils.addOrdinalSymbol(dayOfWeek)}",
            style: kContentTextStyle,
          ),
          Text(
            "${tableWeatherData.dailyTemp!.max!.toInt()}°C",
            style: kContentTextStyle,
            textAlign: TextAlign.center,
          ),
          Text(
            "${tableWeatherData.dailyTemp!.min!.toInt()}°C",
            style: kContentTextStyle,
            textAlign: TextAlign.center,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              tableWeatherData.dailyWeather![0].icon != null
                  ? CachedNetworkImage(
                imageUrl:
                "${Utils.generateIconUrl(tableWeatherData.dailyWeather![0].icon)}",
                width: 32.0,
                height: 32.0,
              )
                  : SizedBox.shrink(),
              Text(
                "${tableWeatherData.humidity}%",
                style: kContentTextStyle,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ],
      );

      listOfTableRow.add(widgetToReturn);
    }

    return Table(
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      border: TableBorder(
        top: BorderSide(
          color: Colors.black,
          width: 1,
        ),
        bottom: BorderSide(
          color: Colors.black,
          width: 1,
        ),
      ),
      columnWidths: {
        0: FractionColumnWidth(.4),
      },
      children: [
        TableRow(
          decoration: BoxDecoration(
            color: Colors.black87,
            border: Border(
              bottom: BorderSide(color: Colors.black, width: 1),
            ),
          ),
          children: [
            Text(
              "DAY OF WEEK",
              style: kContentTextStyle.copyWith(fontWeight: FontWeight.w700),
            ),
            Text(
              "MAX",
              style: kContentTextStyle.copyWith(fontWeight: FontWeight.w700),
              textAlign: TextAlign.center,
            ),
            Text(
              "MIN",
              style: kContentTextStyle.copyWith(fontWeight: FontWeight.w700),
              textAlign: TextAlign.center,
            ),
            Text(
              "Humidity %",
              style: kContentTextStyle.copyWith(fontWeight: FontWeight.w700),
              textAlign: TextAlign.center,
            ),
          ],
        ),
        ...listOfTableRow,
      ],
    );
  }
}
