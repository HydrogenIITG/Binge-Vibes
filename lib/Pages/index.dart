import 'dart:convert';
import 'package:bingevibes/DetailScreen/checker.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:bingevibes/components/movies.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import 'package:bingevibes/components/apikey.dart';
import 'package:motion_tab_bar/MotionTabBarController.dart';

class MyHomePage extends StatefulWidget {
  final String title;
  final MotionTabBarController controller;
  const MyHomePage({super.key, required this.title, required this.controller});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  List<Map<String, dynamic>> trendingweek = [];
  int uval = 1;

  Future<void> trendinglist(int checkerno) async {
    if (checkerno == 1) {
      var trendingweekurl =
          'https://api.themoviedb.org/3/trending/all/week?api_key=$apikey';
      var trendingweekresponse = await http.get(Uri.parse(trendingweekurl));
      if (trendingweekresponse.statusCode == 200) {
        var tempdata = jsonDecode(trendingweekresponse.body);
        var trendingweekjson = tempdata['results'];
        for (var i = 0; i < trendingweekjson.length; i++) {
          trendingweek.add({
            'id': trendingweekjson[i]['id'],
            'poster_path': trendingweekjson[i]['poster_path'],
            'vote_average': trendingweekjson[i]['vote_average'],
            'media_type': trendingweekjson[i]['media_type'],
            'indexno': i,
          });
        }
      }
    } else if (checkerno == 2) {
      var trendingweekurl =
          'https://api.themoviedb.org/3/trending/all/day?api_key=$apikey';
      var trendingweekresponse = await http.get(Uri.parse(trendingweekurl));
      if (trendingweekresponse.statusCode == 200) {
        var tempdata = jsonDecode(trendingweekresponse.body);
        var trendingweekjson = tempdata['results'];
        for (var i = 0; i < trendingweekjson.length; i++) {
          trendingweek.add({
            'id': trendingweekjson[i]['id'],
            'poster_path': trendingweekjson[i]['poster_path'],
            'vote_average': trendingweekjson[i]['vote_average'],
            'media_type': trendingweekjson[i]['media_type'],
            'indexno': i,
          });
        }
      }
    }
    // print(trendingweek);
  }

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
              backgroundColor: const Color.fromRGBO(18, 18, 18, 0.9),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Trending',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontFamily: 'Solitreo'),
                  ),
                  const SizedBox(width: 10),
                  Container(
                    height: 45,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(6)),
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: DropdownButton(
                        autofocus: true,
                        underline:
                            Container(height: 0, color: Colors.transparent),
                        dropdownColor: Colors.black.withOpacity(0.6),
                        icon: const Icon(
                          Icons.arrow_drop_down_sharp,
                          color: Colors.red,
                          size: 30,
                        ),
                        value: uval,
                        items: const [
                          DropdownMenuItem(
                            value: 1,
                            child: Text(
                              'Weekly',
                              style: TextStyle(
                                decoration: TextDecoration.none,
                                color: Colors.white,
                                fontFamily: 'Solitreo',
                                fontSize: 16,
                              ),
                            ),
                          ),
                          DropdownMenuItem(
                            value: 2,
                            child: Text(
                              'Daily',
                              style: TextStyle(
                                  decoration: TextDecoration.none,
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontFamily: 'Solitreo'),
                            ),
                          ),
                        ],
                        onChanged: (value) {
                          setState(
                            () {
                              trendingweek.clear();
                              uval = int.parse(value.toString());
                            },
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
              centerTitle: true,
              toolbarHeight: 60,
              pinned: true,
              expandedHeight: MediaQuery.of(context).size.height * 0.5,
              actions: [
                IconButton(icon: const Icon(Icons.favorite), onPressed: () {}),
              ],
              flexibleSpace: FlexibleSpaceBar(
                collapseMode: CollapseMode.parallax,
                background: FutureBuilder(
                  future: trendinglist(uval),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return CarouselSlider(
                        options: CarouselOptions(
                            viewportFraction: 1,
                            autoPlay: true,
                            autoPlayInterval: const Duration(seconds: 2),
                            height: MediaQuery.of(context).size.height),
                        items: trendingweek.map((i) {
                          return Builder(builder: (BuildContext context) {
                            return GestureDetector(
                              onTap: () {},
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => descriptioncheckui(
                                          i['id'], i['media_type']),
                                    ),
                                  );
                                },
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                        colorFilter: ColorFilter.mode(
                                            Colors.black.withOpacity(0.3),
                                            BlendMode.darken),
                                        image: NetworkImage(
                                            'https://image.tmdb.org/t/p/w500${i['poster_path']}'),
                                        fit: BoxFit.fill),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            margin: const EdgeInsets.only(
                                                left: 10, bottom: 6),
                                            child: Text(
                                              ' # '
                                              '${i['indexno'] + 1}',
                                              style: TextStyle(
                                                  color: Colors.amber
                                                      .withOpacity(0.7),
                                                  fontSize: 18),
                                            ),
                                          ),
                                          Container(
                                            margin: const EdgeInsets.only(
                                                right: 8, bottom: 5),
                                            width: 90,
                                            padding: const EdgeInsets.all(5),
                                            decoration: BoxDecoration(
                                              color:
                                                  Colors.red.withOpacity(0.2),
                                              borderRadius:
                                                  const BorderRadius.all(
                                                Radius.circular(8),
                                              ),
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                //rating icon
                                                const Icon(Icons.star,
                                                    color: Colors.amber,
                                                    size: 20),
                                                const SizedBox(width: 10),
                                                Text(
                                                  '${i['vote_average']}',
                                                  style: const TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          });
                        }).toList(),
                      );
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: Colors.red,
                        ),
                      );
                    }
                  },
                ),
              )),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                SizedBox(
                  height: 1100,
                  width: MediaQuery.of(context).size.width,
                  child: const Movie(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
