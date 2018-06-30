import 'package:abc/model/data_classes/letter_data.dart';
import 'package:flutter/material.dart';

class DraggableLetter extends StatefulWidget {
  final Offset initPosition;
  final Size letterContainerSize;
  final LetterData letter;

  DraggableLetter(this.initPosition, this.letterContainerSize, this.letter);

  @override
  State<StatefulWidget> createState() => _DraggableLetterState();
}

class _DraggableLetterState extends State<DraggableLetter> {
  Offset position = Offset(0.0, 0.0);

  @override
  void initState() {
    super.initState();
    position = widget.initPosition;
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: position.dx,
      top: position.dy,
      child: Draggable(
        data: widget.letter,
        child: getLetterWidget(),
        onDraggableCanceled: (velocity, offset) {
          setState(() {
            position = widget.initPosition;
          });
        },
        feedback: Material(
          shape: RoundedRectangleBorder(
            borderRadius: new BorderRadius.only(
              topLeft: Radius.circular(widget.letterContainerSize.width / 2),
              bottomRight:
                  Radius.circular(widget.letterContainerSize.width / 2),
            ),
          ),
          color: widget.letter.color.withOpacity(0.1),
          child: getLetterWidget(),
        ),
      ),
    );
  }

  getLetterWidget() {
    return Container(
      width: widget.letterContainerSize.width,
      height: widget.letterContainerSize.height,
      child: Center(
        child: Text(
          widget.letter.letter.toUpperCase(),
          style: TextStyle(
            color: widget.letter.color,
            fontSize: widget.letterContainerSize.height * 0.6,
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
