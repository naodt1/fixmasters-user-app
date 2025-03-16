import 'package:flutter/material.dart';

class AvailabilityChip extends StatelessWidget {
  final bool isAvailable;

  AvailabilityChip({Key? key, required this.isAvailable}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16), // Adjust the radius as needed
        border: Border.all(color: isAvailable ? Colors.green : Colors.grey), // Border color based on availability
      ),
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4), // Adjust padding as needed
      child: Text(
        isAvailable ? 'Online' : 'Offline',
        style: TextStyle(fontSize: 14,color: isAvailable ? Colors.green : Colors.grey,),
      ),
    );
  }
}
