import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:video_example/src/academy/models/course_overview.dart';
import 'package:video_example/src/academy/resources/academy_repository.dart';

part 'course_overview_state.dart';

class CourseOverviewCubit extends Cubit<CourseOverviewState> {
  final AcademyRepository _repo;

  CourseOverviewCubit(this._repo) : super(CourseOverviewInitial());

  Future<void> getCourseOverview() async {
    try {
      emit(CourseOverviewLoading());
      final course = await _repo.fetchAllCourseOverviews();

      emit(CourseOverviewLoaded(course));
    } catch (e) {
      print(e);
      emit(CourseOverviewError("aua $e"));
    }
  }
}
