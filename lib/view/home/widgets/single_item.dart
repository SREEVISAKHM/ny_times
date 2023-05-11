import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../model/most_popular_model.dart';
import '../../../utils/colors.dart';
import '../../../utils/common.dart';
import '../../../utils/urls.dart';
import '../../../view_model/home_view_model.dart';
import '../../detail/detail_view.dart';

class SingleItem extends StatelessWidget {
  final HomeViewModel homeViewModel;
  final MostPopularModel mostPopularModel;
  final int index;
  const SingleItem({
    Key? key,
    required this.homeViewModel,
    required this.mostPopularModel,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => DetailView(
                    title: mostPopularModel.results[index].title,
                    url: mostPopularModel.results[index].media.toString() ==
                                '[]' ||
                            mostPopularModel.results[index].media == null
                        ? AppURL.defaultURL
                        : mostPopularModel
                            .results[index].media![0].mediaMetadata[2].url,
                    description:
                        mostPopularModel.results[index].resultAbstract)));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15) +
            const EdgeInsets.only(bottom: 0),
        child: Container(
          padding: const EdgeInsets.only(bottom: 8),
          color: colorItemBackground,
          child: Row(
            children: [
              width(20),
              CircleAvatar(
                backgroundColor: colorCircleBg,
                radius: 25,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  clipBehavior: Clip.antiAlias,
                  child: CachedNetworkImage(
                    imageUrl:
                        mostPopularModel.results[index].media.toString() ==
                                    '[]' ||
                                mostPopularModel.results[index].media == null
                            ? AppURL.defaultURL
                            : mostPopularModel
                                .results[index].media![0].mediaMetadata[0].url,
                    fit: BoxFit.fill,
                    placeholder: (context, url) =>
                        const CircularProgressIndicator(),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                ),
              ),
              width(12),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      child: Text(
                        mostPopularModel.results[index].title,
                        textAlign: TextAlign.justify,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.roboto(
                          textStyle: const TextStyle(
                              color: Colors.black, fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                    height(5),
                    SizedBox(
                      width: 230,
                      child: Wrap(
                        children: [
                          Text(
                            mostPopularModel.results[index].byline,
                            textAlign: TextAlign.justify,
                            style: GoogleFonts.roboto(color: colorSubtitle),
                          ),
                          Align(
                              alignment: Alignment.bottomRight,
                              child: SizedBox(
                                width: 95,
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.calendar_today,
                                      size: 15,
                                      color: colorSubtitle,
                                    ),
                                    width(5),
                                    Text(
                                      homeViewModel.formatDate(mostPopularModel
                                          .results[index].publishedDate),
                                      style: GoogleFonts.roboto(
                                          color: colorSubtitle),
                                    ),
                                  ],
                                ),
                              ))
                        ],
                      ),
                    )
                  ],
                ),
              ),
              width(20),
              const Icon(
                Icons.arrow_forward_ios,
                color: colorCircleBg,
              ),
              width(20),
            ],
          ),
        ),
      ),
    );
  }
}
