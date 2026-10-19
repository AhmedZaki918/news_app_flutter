import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/features/category/data/category_repo.dart';
import 'package:news_app/features/category/logic/category_state.dart';

import '../../../util/app_constants.dart';

class CategoryCubit extends Cubit<CategoryState> {
  final CategoryRepo _categoryRepo;

  CategoryCubit(this._categoryRepo) : super(CategoryState());

  Future<void> displayCategory() async {
    var category = await _categoryRepo.loadCategory();
    emit(state.copyWith(selectedCategory: category));
  }

  void savePreference(String category, String domain) {
    emit(state.copyWith(selectedCategory: category));
    _categoryRepo.saveUserPreference(AppConstants.categorySearch, category);
    _categoryRepo.saveUserPreference(AppConstants.sourceSearch, domain);
  }
}
