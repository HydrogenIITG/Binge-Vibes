import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:bingevibes/components/db_helper.dart';
import 'package:bingevibes/components/repttext.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// Widget addtofavorite(id, type, Details, context) {}

// ignore: must_be_immutable
class addtofavorite extends StatefulWidget {
  var id, type, Details;
  addtofavorite({super.key, 
    this.id,
    this.type,
    this.Details,
  });

  @override
  State<addtofavorite> createState() => addtofavoriteState();
}

class addtofavoriteState extends State<addtofavorite> {
  Future checkfavorite() async {
    FavMovielist()
        .search(widget.id.toString(), widget.Details[0]['title'].toString(),
            widget.type)
        .then((value) {
      if (value == 0) {
        print('notanythingfound');
        favoritecolor = Colors.white;
      } else {


        print('surelyfound');
        favoritecolor = Colors.red;
      }
    });
    await Future.delayed(const Duration(milliseconds: 100));
  }

  Color? favoritecolor;

  addatatbase(
    id,
    name,
    type,
    rating,
    customcolor,
  ) async {
    if (customcolor == Colors.white) {
      FavMovielist().insert({
        'tmdbid': id,
        'tmdbtype': type,
        'tmdbname': name,
        'tmdbrating': rating,
      });
      favoritecolor = Colors.red;
      Fluttertoast.showToast(
          msg: "Added to Watchlist",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
    } else if (customcolor == Colors.red) {
      FavMovielist().deletespecific(id, type);
      favoritecolor = Colors.white;
      Fluttertoast.showToast(
          msg: "Removed from Favorite",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  @override
  void initState() {
    super.initState();
    checkfavorite();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 80,
        width: MediaQuery.of(context).size.width,
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Container(
            alignment: Alignment.centerLeft,
            width: MediaQuery.of(context).size.width / 2,
            child: FutureBuilder(
                future: checkfavorite(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return Container(
                      height: 55,
                      margin: const EdgeInsets.only(top: 20),
                      padding: const EdgeInsets.all(8),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        height: 50,
                        width: 50,
                        child: IconButton(
                          icon: const Icon(Icons.favorite,
                              color: Colors.grey, size: 30),
                          onPressed: () {
                            print('pressed');
                            setState(() {
                              addatatbase(
                                widget.id.toString(),
                                widget.Details[0]['title'].toString(),
                                widget.type,
                                widget.Details[0]['vote_average'].toString(),
                                favoritecolor,
                              );
                            });
                          },
                        ),
                      ),
                    );
                  } else {
                    return SizedBox(
                      height: 55,
                      width: MediaQuery.of(context).size.width,
                    );
                  }
                }),
          ),
          GestureDetector(
            onTap: () {
              //show dialog box with share option and copy link option and share to social media option and copy link option and share to social media option
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      backgroundColor: const Color.fromRGBO(18, 18, 18, 1),
                      title:const  Text(
                        "Binge Vibes",
                        style: TextStyle(fontFamily: 'GreatVibes',color: Colors.white),
                      ),
                      content: SizedBox(
                        height: 180,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            GestureDetector(
                              onTap: () {},
                              child: Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      color: Colors.amber.withOpacity(0.6),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: FittedBox(
                                    fit: BoxFit.scaleDown,
                                    child: Row(children: [
                                      const Icon(Icons.share,
                                          color: Colors.white, size: 20),
                                      const SizedBox(width: 10),
                                      normaltext("Share to Social Media")
                                    ]),
                                  )),
                            ),
                            const SizedBox(height: 20),
                            FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  GestureDetector(
                                    onTap: () async {
                                      var url =
                                          "https://www.facebook.com/sharer/sharer.php?u=https://www.themoviedb.org/$widget.type/$widget.id";
                                      await launch(url);
                                    },
                                    child: Container(
                                        padding: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                            color: Colors.blue,
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: const Row(children: [
                                          Icon(Icons.facebook_rounded,
                                              color: Colors.white, size: 30),
                                        ])),
                                  ),
                                  const SizedBox(width: 10),
                                  GestureDetector(
                                    onTap: () async {
                                      var url =
                                          //share to whatsapp
                                          "https://wa.me/?text=Check%20out%20this%20link:%20https://www.themoviedb.org/$widget.type/$widget.id";
                                      await launch(url);
                                    },
                                    child: Container(
                                        padding: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                            color: Colors.green,
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: const Row(children: [
                                          Icon(FontAwesomeIcons.whatsapp,
                                              color: Colors.white, size: 30),
                                        ])),
                                  ),
                                  const SizedBox(width: 10),
                                  GestureDetector(
                                    onTap: () async {
                                      var url =
                                          "https://www.linkedin.com/shareArticle?mini=true&url=https://www.themoviedb.org/$widget.type/$widget.id&title=Movie Hunt&summary=Check%20out%20this%20link:%20https://www.themoviedb.org/$widget.type/$widget.id&source=Movie%20Hunt";
                                      await launch(url);
                                    },
                                    child: Container(
                                        padding: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                            color: Colors.blue,
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: const Row(children: [
                                          Icon(FontAwesomeIcons.linkedin,
                                              color: Colors.white, size: 30),
                                        ])),
                                  ),
                                  const SizedBox(width: 10),
                                  GestureDetector(
                                    onTap: () async {
                                      var url =
                                          "https://twitter.com/intent/tweet?text=Check%20out%20this%20link:%20https://www.themoviedb.org/$widget.type/$widget.id";
                                      await launch(url);
                                    },
                                    child: Container(
                                        padding: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                            color: Colors.blueAccent,
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: const Row(children: [
                                          Icon(FontAwesomeIcons.twitter,
                                              color: Colors.white, size: 30),
                                        ])),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 20),
                            GestureDetector(
                              onTap: () async {
                                //copy link
                                await Clipboard.setData(ClipboardData(
                                    text:
                                        "https://www.themoviedb.org/$widget.type/$widget.id"));
                                Navigator.pop(context);
                                //slutter toast for the message copied to clipboard
                                Fluttertoast.showToast(
                                    msg: "Link Copied to Clipboard",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.white,
                                    textColor: Colors.black,
                                    fontSize: 16.0);
                              },
                              child: Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      color: Colors.amber.withOpacity(0.6),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Row(children: [
                                    const Icon(Icons.copy,
                                        color: Colors.white, size: 20),
                                    const SizedBox(width: 10),
                                    normaltext("Copy Link")
                                  ])),
                            ),
                          ],
                        ),
                      ),
                    );
                  });
            },
            child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Colors.amber.withOpacity(0.6),
                    borderRadius: BorderRadius.circular(10)),
                child: Row(children: [
                  const Icon(Icons.share, color: Colors.white, size: 20),
                  const SizedBox(width: 10),
                  normaltext("Share")
                ])),
          )
        ]));
  }
}