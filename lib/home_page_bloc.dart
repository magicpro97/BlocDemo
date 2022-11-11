import 'package:bloc_demo/bloc.dart';
import 'package:bloc_demo/people.dart';
import 'package:bloc_demo/people_repository.dart';

abstract class HomePageEvent extends BlocEvent {}

class GetPeople extends HomePageEvent {}

class HomePageState extends BlocState {
  final List<People> people;
  final bool isLoading;

  HomePageState({
    this.people = const [],
    this.isLoading = false,
  });

  HomePageState copyWith({
    List<People>? people,
    bool? isLoading,
  }) =>
      HomePageState(
        people: people ?? this.people,
        isLoading: isLoading ?? this.isLoading,
      );
}

class HomePageBloc extends Bloc<HomePageEvent, HomePageState> {
  HomePageBloc(this._peopleRepository) : super(HomePageState());

  final PeopleRepository _peopleRepository;

  @override
  void onEventChange(HomePageEvent event) async {
    if (event is GetPeople) {
      emit(state.copyWith(isLoading: true));
      final people = await _peopleRepository.getAll();

      emit(state.copyWith(
        people: people,
        isLoading: false,
      ));
    }
  }
}
