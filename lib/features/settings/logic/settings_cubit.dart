import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/features/settings/data/settings_repo.dart';
import 'package:news_app/features/settings/logic/settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  final SettingsRepo _settingsRepo;

  SettingsCubit(this._settingsRepo) : super(SettingsState());

  Future<void> displayPreferences() async {
    var soundState = await _settingsRepo.getSoundStatus();
    var category = await _settingsRepo.loadCategory();
    var source = await _settingsRepo.loadSource();
    emit(
      state.copyWith(
        isSoundEnabled: soundState,
        selectedSource: source,
        selectedCategory: category,
      ),
    );
  }

  void saveSoundState(bool value) {
    _settingsRepo.saveSound(value);
    emit(state.copyWith(isSoundEnabled: value));
  }
}
