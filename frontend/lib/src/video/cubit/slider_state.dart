part of 'slider_cubit.dart';

@immutable
class SliderState {
  SliderState({
    required this.sliderValue,
  });

  final double sliderValue;

  SliderState copyWith({
    double? sliderValue,
  }) {
    return SliderState(
      sliderValue: sliderValue ?? this.sliderValue,
    );
  }
}
