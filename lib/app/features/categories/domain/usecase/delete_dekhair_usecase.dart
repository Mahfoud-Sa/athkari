import 'package:athkari/app/core/usecase/usecase.dart';
import 'package:athkari/app/features/categories/data/repository/category_repository_imp.dart';
import 'package:athkari/app/features/categories/domain/entities/category_entity.dart';
import 'package:athkari/app/features/daily_wered/data/repository/dhkar_repository_impl.dart';
import 'package:flutter/material.dart';

class DeleteDekharUseCase extends UseCase<void, int> {
  final DhkarRepositoryImpl _dhkarRepositoryImpl;

  DeleteDekharUseCase(this._dhkarRepositoryImpl);

  @override
  Future call({int? params}) {
    // TODO: implement call
    var temp=_dhkarRepositoryImpl.deleteDhkar(params!);
    debugPrint(temp.toString());
    return temp;
  }
}
