import 'package:advicer/domain/failures/failures.dart';
import 'package:advicer/domain/entities/advice_enitity.dart';
import 'package:advicer/domain/reposetories/advicer_repository.dart';
import 'package:advicer/infrastructure/datasources/advicer_remote_datasource.dart';
import 'package:advicer/infrastructure/exceptions/exceptions.dart';
import 'package:dartz/dartz.dart';

class AdvicerRepositoryImpl implements AdvicerRepository {
  final AdvicerRemoteDatasource advicerRemoteDatasource;
  AdvicerRepositoryImpl({required this.advicerRemoteDatasource});


  @override
  Future<Either<Failure, AdviceEntity>> getAdviceFromApi() async {
    try {

      final remoteAdvice =
          await advicerRemoteDatasource.getRandomAdviceFromApi();

          
      return Right(remoteAdvice);
    } catch (e) {
      if (e is  SeverException) {
        return Left(ServerFailure());
      } else {
        return Left(GeneralFailure());
      }
    }
  }
}
