import 'package:flutter/material.dart';

class PriorityDropdown extends StatefulWidget {
  const PriorityDropdown({super.key});

  @override
  State<PriorityDropdown> createState() => _PriorityDropdownState();
}

class _PriorityDropdownState extends State<PriorityDropdown> {
  final Map<String, bool> _values = {
    'Prioritas tinggi': true,
    'Prioritas sedang': false,
    'Prioritas rendah': false,
  };

  bool _isOpen = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () => setState(() => _isOpen = !_isOpen),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: const Color(0xFF7BC9BE),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Text(
              'Pilih Prioritas',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        if (_isOpen) const SizedBox(height: 8),
        if (_isOpen) _dropdownBody(),
      ],
    );
  }

  Widget _dropdownBody() {
    return ClipPath(
      clipper: _CutCornerClipper(),
      child: Container(
        width: 220,
        padding: const EdgeInsets.all(12),
        color: const Color(0xFF7BC9BE),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: _values.keys.map((key) {
            return CheckboxListTile(
              value: _values[key],
              onChanged: (val) {
                setState(() => _values[key] = val ?? false);
              },
              dense: true,
              contentPadding: EdgeInsets.zero,
              controlAffinity: ListTileControlAffinity.trailing,
              activeColor: Colors.white,
              checkColor: const Color(0xFF7BC9BE),
              title: Text(
                key,
                style: const TextStyle(color: Colors.white),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}