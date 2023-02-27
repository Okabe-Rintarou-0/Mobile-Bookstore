import 'package:flutter/material.dart';

class NumberInput extends StatelessWidget {
  const NumberInput(
      {super.key,
      required this.number,
      required this.min,
      required this.max,
      this.onAdd,
      this.onRemove});

  final int number;

  final int min;

  final int max;

  final void Function()? onAdd;

  final void Function()? onRemove;

  Widget _icon(IconData icon,
          {void Function()? onTap,
          Border? border,
          BorderRadius? borderRadius,
          Color color = Colors.black}) =>
      Material(
          type: MaterialType.transparency,
          child: Ink(
            decoration: BoxDecoration(
                border: border,
                color: Colors.white,
                borderRadius: borderRadius),
            child: InkWell(
              onTap: onTap,
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Icon(
                  icon,
                  size: 15.0,
                  color: color,
                ),
              ),
            ),
          ));

  @override
  Widget build(BuildContext context) {
    const BorderSide side = BorderSide(width: 0.6, color: Color(0xFFC8C8C8));

    return Container(
        height: 30,
        decoration: BoxDecoration(
            border: Border.all(width: 0.6, color: const Color(0xFFC8C8C8)),
            borderRadius: BorderRadius.circular(5),
            color: Colors.white),
        child: Row(
          children: [
            _icon(Icons.remove,
                onTap: number > min ? onRemove : null,
                border: const Border(right: side),
                color: number == min ? Colors.grey : Colors.black),
            SizedBox(
              width: 40,
              child: Center(
                child: Text(
                  number.toString(),
                  style: const TextStyle(color: Colors.black),
                ),
              ),
            ),
            _icon(Icons.add,
                onTap: number < max ? onAdd : null,
                border: const Border(left: side),
                color: number == max ? Colors.grey : Colors.black)
          ],
        ));
  }
}

class EditableNumber extends StatefulWidget {
  const EditableNumber(
      {super.key,
      required this.number,
      required this.min,
      required this.max,
      this.onAdd,
      this.onRemove});

  final int number;

  final int min;

  final int max;

  final void Function()? onAdd;

  final void Function()? onRemove;

  @override
  State<StatefulWidget> createState() => _EditableNumber();
}

class _EditableNumber extends State<EditableNumber> {
  bool isEditing = false;

  @override
  Widget build(BuildContext context) {
    Widget browser = Container(
      height: 30,
      decoration: BoxDecoration(
          border: Border.all(width: 0.6, color: const Color(0xFFC8C8C8)),
          borderRadius: BorderRadius.circular(5),
          color: Colors.white),
      padding: const EdgeInsets.only(left: 5, right: 5),
      child: Center(
          child: Text(
        "×${widget.number}",
        style: const TextStyle(fontSize: 15),
      )),
    );

    return isEditing
        ? NumberInput(
            number: widget.number,
            min: widget.min,
            max: widget.max,
            onAdd: widget.onAdd,
            onRemove: widget.onRemove)
        : GestureDetector(
            onTap: () => setState(() {
              isEditing = true;
            }),
            child: browser,
          );
  }
}
