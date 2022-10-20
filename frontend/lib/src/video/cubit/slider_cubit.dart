import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'slider_state.dart';

class SliderCubit extends Cubit<SliderState> {
  SliderCubit() : super(SliderState(sliderValue: 0.0));

  Future<void> toggleSlider(bool isLongDrag) async {
    while (isLongDrag) {
      for (double i = 1; i < 100; i++) {
        emit(state.copyWith(sliderValue: i));
        await Future.delayed(Duration(milliseconds: 4));
      }
      for (double i = 100; i > 0; i--) {
        emit(state.copyWith(sliderValue: i));
        await Future.delayed(Duration(milliseconds: 4));
      }
    }
  }

  void resetSliderValue() {
    emit(SliderState(sliderValue: 0.0));
  }
}
