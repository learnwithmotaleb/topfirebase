import 'package:flutter/material.dart';
class MatchDetails extends StatefulWidget {
  final String matchName;

  MatchDetails({required this.matchName});

  @override
  State<MatchDetails> createState() => _MatchDetailsState();
}

class _MatchDetailsState extends State<MatchDetails> {
  // TODO: Fetch match details from Firebase based on the selected match
  @override
  Widget build(BuildContext context) {
    // TODO: Display match details (e.g., scores, running time)
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.matchName),
      ),
      body: Card(
        child: Column(
          children: [
            SizedBox(height: 10,),
            Container(
              width: double.infinity,
              height: 150,
              color: Colors.grey,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text (widget.matchName,style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                    ),
                    Text("4:7",style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),),
                    Text("Time: 32:04",style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),),
                    Text("Total Time: 90:00",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),),
                  ],
                ),
              ),
            )
        
          ],
        ),
      ),
    );
  }
}
