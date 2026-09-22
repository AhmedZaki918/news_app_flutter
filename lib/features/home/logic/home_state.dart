

sealed class HomeState<T> {
  const HomeState();
}

class Initial<T> extends HomeState<T> {
  const Initial();
}

class Loading<T> extends HomeState<T> {
  const Loading();
}

class Success<T> extends HomeState<T> {
  final T data;

  const Success(this.data);
}

class Error<T> extends HomeState<T> {
  final String error;

  const Error(this.error);
}