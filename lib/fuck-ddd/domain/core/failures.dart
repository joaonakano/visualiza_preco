abstract class Failure {
  final String message;
  const Failure(this.message);
}

class ValueFailure extends Failure {
  const ValueFailure(String message) : super(message);
}

class ProductFailure extends Failure {
  const ProductFailure(String message) : super(message);
}