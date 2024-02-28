enum LottieAnimation {
  notFound(name: 'not_found'),
  empty(name: 'empty'),
  loading(name: 'loading'),
  error(name: 'error'),
  smallError(name: 'small_error');

  final String name;
  const LottieAnimation({required this.name});
}
