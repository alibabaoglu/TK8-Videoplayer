import 'package:flutter/material.dart';

class LongPressSlider extends StatelessWidget {
  final double currentSliderValue;

  final bool isPortrait;

  const LongPressSlider(
      {Key? key, required this.currentSliderValue, required this.isPortrait})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          key: Key("LongPressProgressbar"),
          width: 100, //isPortrait??
          //Slider for LongPressDraggable
          child: Slider(
            thumbColor: Colors.white,
            activeColor: Colors.white,
            inactiveColor: Colors.white,
            value: currentSliderValue,
            min: 0,
            max: 100,
            divisions: 100,
            label: currentSliderValue.round().toString(),
            onChanged: (double value) {},
          ),
        ),
        Text("Zum Verschieben nach links oder rechts ziehen",
            style: TextStyle(
                color: Colors.white,
                fontSize: isPortrait ? 12 : 14)), //isPortrait ?
      ],
    );
  }
}
