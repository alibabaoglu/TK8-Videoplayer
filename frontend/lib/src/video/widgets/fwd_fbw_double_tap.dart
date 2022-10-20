import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../video.dart';

class DoubleTap extends StatelessWidget {
  const DoubleTap({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<VideoCubit>(context);
    return Positioned.fill(
      child: Row(
        children: [
          Container(
            child: InkWell(
              onTap: () => cubit.toggleControls(),
              onDoubleTap: () {
                cubit.rewind();
              },
              child: Container(
                height: cubit.state.controller.value.size.height,
                width: MediaQuery.of(context).size.width * (1 / 3),
              ),
            ),
          ),
          Container(
            child: InkWell(
              onTap: () => cubit.toggleControls(),
              child: Container(
                height: cubit.state.controller.value.size.height,
                width: MediaQuery.of(context).size.width * (1 / 3),
              ),
            ),
          ),
          Container(
            child: InkWell(
              onTap: () => cubit.toggleControls(),
              onDoubleTap: () {
                cubit.fastForward();
              },
              child: Align(
                alignment: Alignment.centerRight,
                child: Container(
                  height: cubit.state.controller.value.size.height,
                  width: MediaQuery.of(context).size.width * (1 / 3),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
