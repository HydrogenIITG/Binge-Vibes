import 'package:flutter/material.dart';
import 'package:bingevibes/DetailScreen/checker.dart';
import 'package:bingevibes/components/repttext.dart';
import 'package:bingevibes/components/apikey.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:convert';
import 'package:motion_tab_bar/MotionTabBarController.dart';

class searchbarfun extends StatefulWidget {
  final String title;
  final MotionTabBarController controller;
  const searchbarfun(
      {super.key, required this.title, required this.controller});

  @override
  State<searchbarfun> createState() => _searchbarfunState();
}

class _searchbarfunState extends State<searchbarfun> {
  List<Map<String, dynamic>> searchresult = [];

  Future<void> searchlistfunction(val) async {
    var searchurl =
        'https://api.themoviedb.org/3/search/multi?api_key=$apikey&query=$val';
    var searchresponse = await http.get(Uri.parse(searchurl));
    if (searchresponse.statusCode == 200) {
      var tempdata = jsonDecode(searchresponse.body);
      var searchjson = tempdata['results'];
      for (var i = 0; i < searchjson.length; i++) {
        //only add value if all are present
        if (searchjson[i]['id'] != null &&
            searchjson[i]['poster_path'] != null &&
            searchjson[i]['vote_average'] != null &&
            searchjson[i]['media_type'] != null) {
          searchresult.add({
            'id': searchjson[i]['id'],
            'poster_path': searchjson[i]['poster_path'],
            'vote_average': searchjson[i]['vote_average'],
            'media_type': searchjson[i]['media_type'],
            'popularity': searchjson[i]['popularity'],
            'overview': searchjson[i]['overview'],
          });

          // searchresult = searchresult.toSet().toList();

          if (searchresult.length > 20) {
            searchresult.removeRange(20, searchresult.length);
          }
        } else {
          print('null value found');
        }
      }
    }
  }

  final TextEditingController searchtext = TextEditingController();
  bool showlist = false;
  var val1;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
        showlist = !showlist;
      },
      child: Padding(
        padding:
            const EdgeInsets.only(left: 10.0, top: 30, bottom: 20, right: 10),
        child: Column(
          children: [
            Container(
              height: 50,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: Colors.red.shade100,
                  borderRadius: const BorderRadius.all(Radius.circular(10))),
              child: TextField(
                autofocus: false,
                controller: searchtext,
                onSubmitted: (value) {
                  searchresult.clear();
                  setState(() {
                    val1 = value;
                    FocusManager.instance.primaryFocus?.unfocus();
                  });
                },
                onChanged: (value) {
                  searchresult.clear();

                  setState(() {
                    val1 = value;
                  });
                },
                decoration: InputDecoration(
                    suffixIcon: IconButton(
                      onPressed: () {
                        Fluttertoast.showToast(
                            webBgColor: "#000000",
                            webPosition: "center",
                            webShowClose: true,
                            msg: "Search Cleared",
                            toastLength: Toast.LENGTH_LONG,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 2,
                            backgroundColor: Colors.red.shade50,
                            textColor: Colors.white,
                            fontSize: 16.0);

                        setState(() {
                          searchtext.clear();
                          FocusManager.instance.primaryFocus?.unfocus();
                        });
                      },
                      icon: Icon(
                        FontAwesomeIcons.rotateLeft,
                        color: Colors.red.withOpacity(0.6),
                      ),
                    ),
                    prefixIcon: const Icon(
                      FontAwesomeIcons.searchengin,
                      color: Colors.red,
                    ),
                    hintText: 'Search',
                    hintStyle: TextStyle(color: Colors.red.withOpacity(0.5)),
                    border: InputBorder.none),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            searchtext.text.isNotEmpty
                ? FutureBuilder(
                    future: searchlistfunction(val1),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        return Expanded(
                          child: SizedBox(
                            child: ListView.builder(
                              itemCount: searchresult.length,
                              scrollDirection: Axis.vertical,
                              physics: const BouncingScrollPhysics(),
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            descriptioncheckui(
                                          searchresult[index]['id'],
                                          searchresult[index]['media_type'],
                                        ),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.only(
                                        top: 4, bottom: 4),
                                    height: 180,
                                    width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(
                                        color: Colors.grey.shade700,
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(10))),
                                    child: Row(children: [
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.4,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(10)),
                                            image: DecorationImage(
                                                image: NetworkImage(
                                                    'https://image.tmdb.org/t/p/w500${searchresult[index]['poster_path']}'),
                                                fit: BoxFit.fill)),
                                      ),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                child: Row(
                                                  children: [
                                                    //vote average box
                                                    Container(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              5),
                                                      height: 30,
                                                      // width:
                                                      //     100,
                                                      decoration: BoxDecoration(
                                                          color: Colors.amber
                                                              .withOpacity(0.2),
                                                          borderRadius:
                                                              const BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          6))),
                                                      child: Center(
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            const Icon(
                                                              Icons.star,
                                                              color:
                                                                  Colors.amber,
                                                              size: 20,
                                                            ),
                                                            const SizedBox(
                                                              width: 5,
                                                            ),
                                                            ratingtext(
                                                                '${searchresult[index]['vote_average']}')
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      width: 10,
                                                    ),

                                                    //popularity
                                                    Container(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              5),
                                                      height: 30,
                                                      decoration: BoxDecoration(
                                                          color: Colors.amber
                                                              .withOpacity(0.2),
                                                          borderRadius:
                                                              const BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          8))),
                                                      child: Center(
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            const Icon(
                                                              Icons
                                                                  .people_outline_sharp,
                                                              color:
                                                                  Colors.amber,
                                                              size: 20,
                                                            ),
                                                            const SizedBox(
                                                              width: 5,
                                                            ),
                                                            ratingtext(
                                                                '${searchresult[index]['popularity']}')
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.4,
                                                height: 85,
                                                child: Text(
                                                  textAlign: TextAlign.left,
                                                  ' ${searchresult[index]['overview']}',
                                                  style: const TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ]),
                                  ),
                                );
                              },
                            ),
                          ),
                        );
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(
                            color: Colors.red,
                          ),
                        );
                      }
                    },
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
