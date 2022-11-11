import 'package:bloc_demo/people.dart';

abstract class PeopleRepository {
  Future<List<People>> getAll();

  Future<People?> getByName(String name);
}

class PeopleRepositoryImpl extends PeopleRepository {
  static final _peoples = [
    People(name: 'A', phone: '123321'),
    People(name: 'B', email: 'B@bmail.com'),
    People(name: 'C', email: 'C@bmail.com'),
    People(name: 'D', phone: '1111111'),
    People(name: 'E', phone: '13123123'),
    People(name: 'F', phone: '21312', email: 'F@bmail.com'),
    People(name: 'G', email: 'G@bmail.com'),
    People(name: 'H', phone: '21312', email: 'F@bmail.com'),
    People(name: 'I', phone: '21312', email: 'F@bmail.com'),
  ];

  @override
  Future<List<People>> getAll() async {
    await Future.delayed(const Duration(seconds: 3));

    return _peoples;
  }

  @override
  Future<People?> getByName(String name) async {
    await Future.delayed(const Duration(seconds: 3));

    try {
      return _peoples.firstWhere((element) => element.name == name);
    } catch (e) {
      return null;
    }
  }
}