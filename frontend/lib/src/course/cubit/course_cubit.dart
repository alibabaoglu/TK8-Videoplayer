import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:video_example/src/course/model/course.dart';
import 'package:video_example/src/course/resources/course_repository.dart';

part 'course_state.dart';

class CourseCubit extends Cubit<CourseState> {
  final CourseRepository _repo;

  CourseCubit(this._repo) : super(CourseInitial());

  Future<void> getCourse(String title) async {
    try {
      emit(CourseLoading());
      final course = await _repo.fetchCourseVideos(title);
      emit(CourseLoaded(course));
    } catch (e) {
      print("CourseError: $e");
      emit(CourseError("aua $e"));
    }
  }
}
