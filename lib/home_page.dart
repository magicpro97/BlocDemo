import 'dart:async';

import 'package:bloc_demo/home_page_bloc.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
    required this.homePageBloc,
  }) : super(key: key);

  final HomePageBloc homePageBloc;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final _homePageBloc = widget.homePageBloc;

  void _onPeopleTapped(String name) {
    Navigator.pushNamed(context, '/detail', arguments: name);
  }

  @override
  void dispose() {
    super.dispose();
    _homePageBloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<HomePageState>(
      stream: widget.homePageBloc.state$,
      builder: _homePageBlocBuilder,
    );
  }

  Widget _homePageBlocBuilder(
    BuildContext context,
    AsyncSnapshot<HomePageState> snapshot,
  ) {
    final state = snapshot.data!;
    final peopleItem = state.people
        .map((e) => ListTile(
              onTap: () => _onPeopleTapped(e.name),
              title: Text(e.name),
              subtitle: Text('Phone: ${e.phone} Email: ${e.email}'),
            ))
        .toList(growable: false);

    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            title: const Text('Home'),
          ),
          body: ListView.builder(
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
            itemBuilder: (_, index) => peopleItem[index],
            itemCount: peopleItem.length,
          ),
        ),
        Visibility(
          visible: state.isLoading,
          child: SafeArea(
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              color: Colors.white.withOpacity(.7),
              child: const CircularProgressIndicator.adaptive(),
            ),
          ),
        )
      ],
    );
  }
}
