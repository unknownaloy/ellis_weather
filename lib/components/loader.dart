import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loader extends StatelessWidget {
  const Loader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.grey,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/default_image.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.75), BlendMode.srcATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: Center(
          child: SpinKitSpinningCircle(
            color: Color.fromRGBO(253, 184, 19, 1),
            size: 100.0,
          ),
        ),
      ),
    );
  }
}
