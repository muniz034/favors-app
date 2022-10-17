import "package:flutter/material.dart";
import "package:favors_app/utils/favor.dart";
import "package:intl/intl.dart";

class FavorsPage extends StatelessWidget {
  final List<Favor> pendingAnswerFavors;
  final List<Favor> completedFavors;
  final List<Favor> refusedFavors;
  final List<Favor> acceptedFavors;

  FavorsPage({
    required Key key, 
    required this.pendingAnswerFavors, 
    required this.completedFavors, 
    required this.refusedFavors, 
    required this.acceptedFavors
  }) : super(key: key);

  Row _itemHeader(Favor favor){
    return Row(
      children: <Widget> [
        CircleAvatar(
          backgroundImage: NetworkImage(
            favor.friend.photoURL
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: Text("${favor.friend.name} asked you to... ")
          ),
        )
      ],
    );
  }

  Widget _itemFooter(Favor favor){
    if(favor.isCompleted){
      final format = DateFormat();
      return Container(
        margin: EdgeInsets.only(top: 8.0),
        alignment: Alignment.center,
        child: Chip(
          label: Text("Completed at: ${format.format(favor.completed!)}"),
        )
      );
    } else if(favor.isRequested){
      return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget> [
          TextButton(
            child: Text("Refuse"),
            onPressed: () {},
          ),
          TextButton(
            child: Text("Accept"),
            onPressed: () {},
          )
        ]
      );
    } else if(favor.isDoing){
      return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget> [
          TextButton(
            child: Text("Complete"),
            onPressed: () {},
          ),
          TextButton(
            child: Text("Give Up!"),
            onPressed: () {},
          )
        ]
      );
    } else {
      return Container();
    }
  }

  Widget _buildCategoryTab(String title) => Tab(child: Text(title));

  Widget _favorsList(String title, List<Favor> favors){
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: <Widget> [
        Padding(
          child: Text(title),
          padding: EdgeInsets.only(top: 16.0)
        ),
        Expanded(
          child: ListView.builder(
            physics: BouncingScrollPhysics(),
            itemCount: favors.length,
            itemBuilder: (BuildContext context, int index) {
              final favor = favors[index];
              return Card(
                key: ValueKey(favor.uuid),
                margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    children: <Widget> [
                      _itemHeader(favor),
                      Text(favor.description),
                      _itemFooter(favor)
                    ],
                  ),
                ),
              );
            }
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Your favors"),
          bottom: TabBar(
            isScrollable: true,
            tabs: [
              _buildCategoryTab("Requests"),
              _buildCategoryTab("Doing"),
              _buildCategoryTab("Completed"),
              _buildCategoryTab("Refused"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _favorsList("Pending Requests", pendingAnswerFavors),
            _favorsList("Accepted Requests", acceptedFavors),
            _favorsList("Completed Requests", completedFavors),
            _favorsList("Refused Requests", refusedFavors),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => {},
          tooltip: "Ask a Favor",
          child: Icon(Icons.add)
        ),
      ),
    );
  }
}