import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';

class CustomDuration {
  int hours = 0;
  int min = 0;

  copy(CustomDuration other) {
    hours = other.hours;
    min = other.min;
  }

  String _pad(int value, int qtd) {
    return value.toString().padLeft(qtd, '0');
  }

  toFormat() {
    return '${_pad(hours, 2)} h ${_pad(min, 2)} min';
  }
}

class DurationPicker extends StatefulWidget {
  final CustomDuration initialValue;

  const DurationPicker({Key? key, required this.initialValue}) : super(key: key);

  @override
  State<DurationPicker> createState() => _DurationPickerState();
}

class _DurationPickerState extends State<DurationPicker> {
  late CustomDuration _duration;

  @override
  void initState() {
    super.initState();
    _duration = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        'Tempo de duração (média)',
        style: TextStyle(fontSize: 20),
      ),
      titlePadding: const EdgeInsets.all(15),
      content: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          NumberPicker(
            value: _duration.hours,
            minValue: 0,
            maxValue: 23,
            onChanged: (int value) {
              setState(() {
                _duration.hours = value;
              });
            },
            textMapper: (value) => '$value h',
            infiniteLoop: true,
            zeroPad: true,
          ),
          NumberPicker(
            value: _duration.min,
            minValue: 0,
            maxValue: 55,
            step: 5,
            onChanged: (int value) {
              setState(() {
                _duration.min = value;
              });
            },
            textMapper: (value) => '$value min',
            infiniteLoop: true,
            zeroPad: true,
          ),
        ],
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 15),
      actions: [
        TextButton(
          child: const Text('CANCELAR'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: const Text('OK'),
          onPressed: () {
            Navigator.of(context).pop(_duration);
          },
        ),
      ],
      actionsPadding: const EdgeInsets.all(15),
    );
  }
}
