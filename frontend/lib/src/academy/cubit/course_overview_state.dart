part of 'course_overview_cubit.dart';

@immutable
abstract class CourseOverviewState {
  const CourseOverviewState();
}

class CourseOverviewInitial extends CourseOverviewState {
  const CourseOverviewInitial();
}

class CourseOverviewLoading extends CourseOverviewState {
  const CourseOverviewLoading();
}

class CourseOverviewLoaded extends CourseOverviewState {
  final CourseOverview course;
  const CourseOverviewLoaded(this.course);
}

class CourseOverviewError extends CourseOverviewState {
  final String message;
  const CourseOverviewError(this.message);
}
