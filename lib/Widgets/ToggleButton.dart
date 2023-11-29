import 'package:flutter/material.dart';

class ToggleButtons1 extends StatefulWidget {
  final Function(bool) isLoadVideo;
  ToggleButtons1(this.isLoadVideo);

  @override
  _ToggleButtons1State createState() => _ToggleButtons1State();
}

class _ToggleButtons1State extends State<ToggleButtons1> {
  List<bool> isSelected = [true, false];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 23,
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.5),
        borderRadius: BorderRadius.circular(10),
      ),
      child: ToggleButtons(
        isSelected: isSelected,
        selectedColor: Colors.white,
        color: Colors.black,
        fillColor: Colors.transparent, // Set fill color to transparent
        renderBorder: false,
        children: <Widget>[
          GestureDetector(
            onTap: () {
              setState(() {
                isSelected[0] = true;
                isSelected[1] = false;
                widget.isLoadVideo(true);
              });
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                ),
                color: isSelected[0] ? Colors.green : Colors.transparent,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: InkWell(
                  splashColor: Colors.red, // Add splash color for the effect
                  customBorder: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                    ),
                  ),
                  child: Center(
                    child: Text('Photos', style: TextStyle(fontSize: 12)),
                  ),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                isSelected[0] = false;
                isSelected[1] = true;
                widget.isLoadVideo(false);
              });
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
                color: isSelected[1] ? Colors.green : Colors.transparent,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: InkWell(
                  splashColor: Colors.orange, // Add splash color for the effect
                  customBorder: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                  ),
                  child: Center(
                    child: Text('Videos', style: TextStyle(fontSize: 12)),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
