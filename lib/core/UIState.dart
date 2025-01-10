abstract class UIState {
  const UIState();


}

class Loading extends UIState {
  final bool isLoading;
  const Loading({this.isLoading = true});
}

class Success<T> extends UIState {
  final T data;
  const Success(this.data);
}

class Error extends UIState {
  final String errorMessage;
  const Error(this.errorMessage);
}
