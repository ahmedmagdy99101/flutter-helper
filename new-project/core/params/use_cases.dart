import 'package:dartz/dartz.dart';
import '../../../core/errors/failures.dart';
import '../errors/failures.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failures, Type>> call(Params params);
}
