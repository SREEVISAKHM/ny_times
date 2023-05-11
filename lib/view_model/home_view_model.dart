import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import 'package:ny_times/data/network/network_services.dart';
import 'package:ny_times/model/most_popular_model.dart';
import 'package:ny_times/utils/urls.dart';
import 'package:ny_times/view_model/state.dart';

class HomeViewModel extends StateNotifier<HomeState> {
  final NetworkServices networkServices;
  HomeViewModel({required this.networkServices}) : super(InitialState());

  Future<void> fetchMostPopularArticles() async {
    try {
      state = InitialLoadingState();
      var response =
          await networkServices.getMostPopularArticle(AppURL.mostPopularUrl);
      MostPopularModel mostPopularModel = MostPopularModel.fromJson(response);
      state = LoadedState(mostPopularModel: mostPopularModel);
    } catch (e) {
      state = ErrorState(message: e.toString());
    }
  }

  String formatDate(DateTime date) {
    var formatter = DateFormat("yyyy-MM-dd");
    return formatter.format(date);
  }
}

final homeViewModelProvider =
    StateNotifierProvider<HomeViewModel, HomeState>((ref) {
  final network = ref.read(netWorkProvider);
  return HomeViewModel(networkServices: network);
});
