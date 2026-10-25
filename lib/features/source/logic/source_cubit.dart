import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/features/source/data/source_repo.dart';
import 'package:news_app/features/source/logic/source_state.dart';
import 'package:news_app/util/app_constants.dart';

import '../../../util/source.dart';

class SourceCubit extends Cubit<SourceState> {
  final SourceRepo _sourceRepo;

  SourceCubit(this._sourceRepo) : super(SourceState());

  Future<void> displayNewsSource() async {
    var category = await _sourceRepo.loadCategory();
    var source = await _sourceRepo.loadSource();

    emit(state.copyWith(selectedCategory: category, selectedSource: source));
    _loadSources();
  }

  void saveSelectedSource(String value) {
    emit(state.copyWith(selectedSource: value));
    _sourceRepo.saveUserPreference(value);
  }

  void _loadSources() {
    switch (state.selectedCategory) {
      case AppConstants.general:
        emit(state.copyWith(source: generalDomains()));
      case AppConstants.sports:
        emit(state.copyWith(source: sportsDomains()));
      case AppConstants.business:
        emit(state.copyWith(source: businessDomains()));
      default:
        emit(state.copyWith(source: techDomains()));
    }
  }
}
