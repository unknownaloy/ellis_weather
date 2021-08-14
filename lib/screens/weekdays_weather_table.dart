import 'package:ellis_weather/functions/custom_functions.dart';
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
        ...dailyWeatherData!.map((data) {
          String dayOfWeek = CustomFunctions.testingOne(data.dateTime);
          return TableRow(
            children: [
              Text(
                "$dayOfWeek${CustomFunctions.addOrdinalSymbol(dayOfWeek)}",
                style: kContentTextStyle,
              ),
              Text(
                "${data.dailyTemp!.max!.toInt()}°C",
                style: kContentTextStyle,
                textAlign: TextAlign.center,
              ),
              Text(
                "${data.dailyTemp!.min!.toInt()}°C",
                style: kContentTextStyle,
                textAlign: TextAlign.center,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  data.dailyWeather![0].icon != null
                      ? Image.network(
                          "${CustomFunctions.generateIconUrl(data.dailyWeather![0].icon)}",
                          width: 32,
                          height: 32,
                        )
                      : SizedBox.shrink(),
                  Text(
                    "${data.humidity}%",
                    style: kContentTextStyle,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ],
          );
        }),
      ],
    );
  }
}
