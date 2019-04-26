import 'package:flutter_app/database.dart';

abstract class BaseDao<T> {
  final DBProvider db;
  BaseDao(this.db);

  void insert(T t);

  void insertList(List<T> list);

  void update(T t);

  void delete(T t);

  void deleteList(List<T> list);
}