import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_example/src/utils/helper.dart';
import 'dart:io';
import '../video.dart';

class SpeedSlider extends StatelessWidget {
  final bool isPortrait;

  const SpeedSlider({Key? key, required this.isPortrait}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<VideoCubit>(context);
    return GestureDetector(
        onTap: () {
          showSpeedSlider(context, cubit);
        },
        child: Container(
          margin: EdgeInsets.only(right: 10),
          child: Icon(
            Icons.speed,
            size: 30,
            color: Colors.white,
          ),
        ));
  }

  showSpeedSlider(context, cubit) {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: isPortrait
              ? Platform.isAndroid
                  ? MediaQuery.of(context).size.height * 0.125
                  : MediaQuery.of(context).size.height * 0.1
              : MediaQuery.of(context).size.height * 0.2,
          decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15), topRight: Radius.circular(15))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: StatefulBuilder(
                    builder: (context, setState) {
                      return Column(
                        children: [
                          Slider(
                            inactiveColor: Colors.grey,
                            activeColor: Colors.white,
                            thumbColor: Colors.white,
                            onChanged: (double value) {
                              setState(() {
                                cubit.state.controller.setPlaybackSpeed(value);
                              });
                            },
                            value: cubit.state.controller.value.playbackSpeed,
                            divisions: 6,
                            min: 0.25,
                            max: 1.75,
                            label: Helper.showVideoSpeed(
                                cubit.state.controller.value.playbackSpeed),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              for (var i = 0.25; i <= 1.75; i += 0.25)
                                Flexible(
                                  child: Text(
                                    Helper.showVideoSpeed(i),
                                    style: TextStyle(
                                        color: Colors.grey[350], fontSize: 12),
                                  ),
                                )
                            ],
                          ),
                        ],
                      );
                    },
                  )),
              Container(
//decoration: BoxDecoration(color: Colors.red),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Colors.black),
                    margin: EdgeInsets.only(bottom: 40, right: 8, top: 8),
                    child: InkWell(
                        onTap: () {
                          cubit.speedSliderClose();
                          Navigator.pop(context);
                        },
                        child: Icon(
                          Icons.close,
                          color: Colors.white,
                          size: 30,
                        )),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
