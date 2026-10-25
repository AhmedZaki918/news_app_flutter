
class SourceState {
  final String selectedSource;
  final String selectedCategory;
  final List<String> source;

  SourceState({
    this.selectedSource = '',
    this.selectedCategory = '',
    this.source = const [],
  });

  SourceState copyWith({
    String? selectedSource,
    String? selectedCategory,
    List<String>? source,
  }) {
    return SourceState(
      selectedSource : selectedSource ?? this.selectedSource,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      source: source ?? this.source,
    );
  }
}
