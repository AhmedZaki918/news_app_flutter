
class CategoryState {
  final String selectedCategory;

  CategoryState({this.selectedCategory = ''});

  CategoryState copyWith({String? selectedCategory}) {
    return CategoryState(
      selectedCategory: selectedCategory ?? this.selectedCategory,
    );
  }
}