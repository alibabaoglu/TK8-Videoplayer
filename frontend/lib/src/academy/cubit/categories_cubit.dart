import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:video_example/src/academy/models/categories.dart';
import 'package:video_example/src/academy/resources/academy_repository.dart';

part 'categories_state.dart';

class CategoriesCubit extends Cubit<CategoriesState> {
  final AcademyRepository _repo;
  CategoriesCubit(this._repo) : super(CategoriesInitial());

  Future<void> getCategories() async {
    try {
      emit(CategoriesLoading());
      final categories = await _repo.fetchAllCategories();
      emit(CategoriesLoaded(categories));
    } catch (e) {
      print("Error CategoriesLoaded: $e");
      emit(CategoriesError("aua $e"));
    }
  }
}
