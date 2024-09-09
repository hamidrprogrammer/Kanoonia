import 'ValidationState.dart';

abstract class Validator{
  ValidationState validate(String data);
}