import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:bingevibes/components/db_helper.dart';

// Widget addtofavorite(id, type, Details, context) {}

// ignore: must_be_immutable
class addtofavorite extends StatefulWidget {
  var id, type, Details;
  addtofavorite({
    super.key,
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
        favoritecolor = Colors.white;
      } else {
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
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
              },
            ),
          ),
        ],
      ),
    );
  }
}
