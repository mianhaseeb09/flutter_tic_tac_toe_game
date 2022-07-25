import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> displayTickCross = ['', '', '', '', '', '', '', '', ''];
  bool ohTurn = true; //THe first player is 0;

  var myTextStyle = const TextStyle(color: Colors.white, fontSize: 30);

  int exScore = 0;
  int ohScore = 0;
  int filledBoxes = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[800],
        body: Column(children: <Widget>[
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  flex: 0,
                  child: Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                            flex: 0,
                            child: Text(
                              'Player O',
                              style: myTextStyle,
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Expanded(
                            flex: 2,
                            child: Text(
                              ohScore.toString(),
                              style: myTextStyle,
                            ),
                          ),
                        ]),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                          flex: 0,
                          child: Text(
                            'Player X',
                            style: myTextStyle,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Expanded(
                          flex: 2,
                          child: Text(
                            exScore.toString(),
                            style: myTextStyle,
                          ),
                        ),
                      ]),
                ),
              ],
            ),
          ),
          const SizedBox(height: 5),
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                  itemCount: 9,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        _tapped(index);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                          color: Colors.grey,
                        )),
                        child: Center(
                          child: Text(
                            displayTickCross[index],
                            style: const TextStyle(
                                color: Colors.white, fontSize: 40),
                          ),
                        ),
                      ),
                    );
                  }),
            ),
          ),
          Expanded(
            child: Container(),
          ),
        ]));
  }

  void _tapped(int index) {
    setState(() {
      if (ohTurn && displayTickCross[index] == '') {
        displayTickCross[index] = 'o';
        filledBoxes += 1;
      } else if (!ohTurn && displayTickCross[index] == '') {
        displayTickCross[index] = 'x';
        filledBoxes += 1;
      }
      ohTurn = !ohTurn;
      _checkWinner();
    });
  }

  void _checkWinner() {
    // 1st row
    if (displayTickCross[0] == displayTickCross[1] &&
        displayTickCross[0] == displayTickCross[2] &&
        displayTickCross[0] != "") {
      _showDialogBox(displayTickCross[0]);
    }

    // 2nd row

    if (displayTickCross[3] == displayTickCross[4] &&
        displayTickCross[3] == displayTickCross[5] &&
        displayTickCross[3] != "") {
      _showDialogBox(displayTickCross[3]);
    }

    // 3rd row

    if (displayTickCross[6] == displayTickCross[7] &&
        displayTickCross[6] == displayTickCross[8] &&
        displayTickCross[6] != "") {
      _showDialogBox(displayTickCross[6]);
    }
    // 1st column

    if (displayTickCross[0] == displayTickCross[3] &&
        displayTickCross[0] == displayTickCross[6] &&
        displayTickCross[0] != "") {
      _showDialogBox(displayTickCross[0]);
    }
    // 2nd column

    if (displayTickCross[1] == displayTickCross[4] &&
        displayTickCross[1] == displayTickCross[7] &&
        displayTickCross[1] != "") {
      _showDialogBox(displayTickCross[1]);
    }
    // 3rd column

    if (displayTickCross[2] == displayTickCross[5] &&
        displayTickCross[2] == displayTickCross[8] &&
        displayTickCross[2] != "") {
      _showDialogBox(displayTickCross[2]);
    }
    // check diagonal
    if (displayTickCross[6] == displayTickCross[4] &&
        displayTickCross[6] == displayTickCross[2] &&
        displayTickCross[6] != "") {
      _showDialogBox(displayTickCross[6]);
    }

    // check diagonal
    if (displayTickCross[0] == displayTickCross[4] &&
        displayTickCross[0] == displayTickCross[8] &&
        displayTickCross[0] != "") {
      _showDialogBox(displayTickCross[0]);
    } else if (filledBoxes == 9) {
      _showDrawDialog();
    }
  }

  void _showDrawDialog() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text(
              'DRAW',
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('Play Again'),
                onPressed: () {
                  _clearBoard();
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  void _showDialogBox(String winner) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              'WINNER IS: ' + winner,
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('Play Again'),
                onPressed: () {
                  _clearBoard();
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
    if (winner == 'o') {
      ohScore += 1;
    } else if (winner == 'x') {
      exScore += 1;
    }
  }

  void _clearBoard() {
    setState(() {
      for (int i = 0; i < 9; i++) {
        displayTickCross[i] = '';
      }
    });
    filledBoxes = 0;
  }
}
