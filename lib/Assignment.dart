import 'package:flutter/material.dart';
import 'classs2.dart';


class MatchListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Match List'),
      ),
      body: MatchList(),
    );
  }
}

class MatchList extends StatefulWidget {
  @override
  _MatchListState createState() => _MatchListState();
}

class _MatchListState extends State<MatchList> {
  // TODO: Fetch match data from Firebase (use Firebase Database)
  final List<String> matchList = ["Argentina vs Africa", "Italy vs Spain"];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: matchList.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(matchList[index]),
          trailing: Icon(Icons.arrow_forward),
          onTap: () {
            // TODO: Navigate to MatchDetailsScreen with matchName
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MatchDetails(matchName: matchList[index]),
              ),
            );
          },
        );
      },
    );
  }
}
