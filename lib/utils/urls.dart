import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppURL {
  static String baseURl = '${dotenv.env['BASE_URL']}';

  static String mostPopularUrl = '${baseURl}mostviewed/all-sections/7.json';

  static const String defaultURL =
      'https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.pngitem.com%2Fmiddle%2FhmhRioo_breaking-news-circle-hd-png-download%2F&psig=AOvVaw3f3KVyKLdrQcYZFAfp2T0d&ust=1683880148344000&source=images&cd=vfe&ved=0CBEQjRxqFwoTCNjc_sLs7P4CFQAAAAAdAAAAABAE';
}
