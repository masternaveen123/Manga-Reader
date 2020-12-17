import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:mangareader/models/searchQuery.dart';
import 'package:mangareader/services/api_manager.dart';

import 'mangaView.dart';

class SearchWid extends StatefulWidget {
  const SearchWid({
    Key key,
    this.source,
    // @required Future<SearchSource> this.searchData,
  }) : super(key: key);
  // final Future<SearchSource> searchData;
  final int source;
  @override
  _SearchWidState createState() => _SearchWidState();
}

class _SearchWidState extends State<SearchWid> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // backgroundColor: Theme.of(context).primaryColor,
        body: Center(
      child: Container(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: RaisedButton(
                  child: Text('Search'),
                  onPressed: () {
                    // print('${widget.data.title[1].toString()}');
                    showSearch(
                      context: context,
                      delegate: DataSearch(
                        source: widget.source,
                        // widget.searchData,
                      ),
                    );
                  },
                ),
              ),
            ),
            Icon(
              Icons.search,
              size: MediaQuery.of(context).size.width,
            )
          ],
        ),
      ),
    ));
  }
}

class DataSearch extends SearchDelegate<String> {
  DataSearch({
    this.source,
  }
      // this._list,
      );
  final int source;
  // final Future<SearchSource> _list;
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = "";
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Datum list;
    return FutureBuilder<SearchQuery>(
        future: _searchList,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return GridView.builder(
              itemCount: snapshot.data.data.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                // crossAxisSpacing: 0,
                // mainAxisSpacing: 5,
                // childAspectRatio: 0.7,
              ),
              itemBuilder: (context, index) {
                var query = snapshot.data.data[index];
                return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MangaView(
                            query: snapshot.data.data[index],
                            source: source,
                          ),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Stack(
                        alignment: AlignmentDirectional.bottomStart,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                              color: Colors.transparent,
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage('${query.imageUrl}'),
                              ),
                            ),
                          ),
                          Container(
                            height: 350.0,
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              color: Colors.white,
                              gradient: LinearGradient(
                                begin: FractionalOffset.topCenter,
                                end: FractionalOffset.bottomCenter,
                                colors: [
                                  Colors.transparent,
                                  Colors.black54,
                                ],
                                stops: [0.5, 1.0],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Text(
                              '${query.title}',
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                          )
                        ],
                      ),
                    ));
              },
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }

  Future<SearchQuery> _searchList;
  @override
  Widget buildSuggestions(BuildContext context) {
    _searchList = APISearchQuery(source: source, query: query).getData();
    return Container(
      color: Theme.of(context).primaryColor,
      // color: Colors.blue,
      child: Center(
        child: Text('Search ...'),
      ),
    );
    // return FutureBuilder<SearchSource>(
    //   future: _list,
    //   builder: (context, snapshot) {
    //     if (snapshot.hasData) {
    //       var list = snapshot.data.data;
    //       return Container(
    //         color: Colors.redAccent,
    //         child: ListView.builder(
    //           itemCount: 10,
    //           itemBuilder: (context, index) => Padding(
    //             padding: const EdgeInsets.all(8.0),
    //             child: ListTile(
    //               leading: Image.network(
    //                 '${list[index].imageUrl}',
    //                 fit: BoxFit.cover,
    //               ),
    //               trailing: Text('${list[index].title}'),
    //             ),
    //           ),
    //         ),
    //       );
    //     } else {
    //       return Center(
    //         child: CircularProgressIndicator(
    //           backgroundColor: Colors.black,
    //         ),
    //       );
    //     }
    //   },
    // );
  }
}
