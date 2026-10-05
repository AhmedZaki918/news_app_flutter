
class SettingsState {
  final String selectedCategory;
  final bool isSoundEnabled;
  final String selectedSource;

  SettingsState({this.selectedCategory = '',this.isSoundEnabled = false,this.selectedSource = ''});

  SettingsState copyWith({
    String? selectedCategory,
    bool? isSoundEnabled,
    String? selectedSource,
  }) {
    return SettingsState(
      selectedCategory: selectedCategory ?? this.selectedCategory,
      isSoundEnabled: isSoundEnabled ?? this.isSoundEnabled,
      selectedSource: selectedSource ?? this.selectedSource,
    );
  }
}



