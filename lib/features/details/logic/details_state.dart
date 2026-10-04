class DetailsState {
  final bool isArticleSaved;

  DetailsState({this.isArticleSaved = false});

  DetailsState copyWith({bool? isArticleSaved}) {
    return DetailsState(
      isArticleSaved: isArticleSaved ?? this.isArticleSaved,
    );
  }
}
