import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:ny_times/model/most_popular_model.dart';
import 'package:ny_times/view/home/widgets/single_item.dart';
import 'package:ny_times/view_model/home_view_model.dart';
import 'package:ny_times/view_model/state.dart';

import '../../utils/common.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(homeViewModelProvider.notifier).fetchMostPopularArticles();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.menu),
        title: const Text('NY TIMES MOST POPULAR'),
        actions: [
          const Icon(Icons.search),
          width(15),
          const Align(
            alignment: Alignment.center,
            child: Text(
              '⋮',
              style: TextStyle(fontSize: 25),
            ),
          ),
          width(15),
        ],
      ),
      body: Consumer(builder: (context, ref, child) {
        var state = ref.watch(homeViewModelProvider);
        switch (state.runtimeType) {
          case InitialState:
            return GestureDetector(
              onTap: () {
                // print('hi');
                // ref.watch(homeViewModelProvider.notifier).state =
                //     InitialLoadingState();
              },
              child: const Center(
                child: Text('Data will populate soon'),
              ),
            );
          case InitialLoadingState:
            return const Center(
              child: CircularProgressIndicator(),
            );
          case LoadedState:
            MostPopularModel mostPopularModel =
                (state as LoadedState).mostPopularModel;
            return Column(
              children: [
                height(20),
                Expanded(
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: mostPopularModel.results.length,
                      itemBuilder: (_, index) {
                        log(mostPopularModel.results[index].media.toString());
                        return SingleItem(
                          homeViewModel:
                              ref.watch(homeViewModelProvider.notifier),
                          mostPopularModel: mostPopularModel,
                          index: index,
                        );
                      }),
                ),
              ],
            );
          case ErrorState:
            var message = (state as ErrorState).message;
            return Center(
              child: Text(message),
            );
          default:
            return const SizedBox();
        }
      }),
    );
  }
}
