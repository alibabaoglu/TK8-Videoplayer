part of 'course_cubit.dart';

@immutable
abstract class CourseState {
  const CourseState();
}

class CourseInitial extends CourseState {
  const CourseInitial();
}

class CourseLoading extends CourseState {
  const CourseLoading();
}

class CourseLoaded extends CourseState {
  final Course course;
  const CourseLoaded(this.course);
}

class CourseError extends CourseState {
  final String message;
  const CourseError(this.message);
}
