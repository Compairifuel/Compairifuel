import 'package:compairifuel/FuelOption.dart';
import 'package:compairifuel/UIComponent.dart';
import 'package:flutter/material.dart';

class FuelTypeField extends StatefulWidget implements UIComponent {
  final List<FuelOption> optionList = FuelOption.values;

  @override
  State<FuelTypeField> createState() {
    return _FuelTypeFieldState();
  }

  const FuelTypeField({super.key});
}

class _FuelTypeFieldState extends State<FuelTypeField> {
  late FuelOption currentOption;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(25),
      child: DropdownButton<FuelOption>(
        value: currentOption,
        onChanged: (FuelOption? newValue) {
          setState(() {
            currentOption = newValue!;
          });
        },
          items: widget.optionList
              .map<DropdownMenuItem<FuelOption>>((FuelOption value) {
          return DropdownMenuItem<FuelOption>(
            value: value,
            child: Text(value.getName),
          );
          }).toList(),
      ),
    );
    //TODO
  }
}