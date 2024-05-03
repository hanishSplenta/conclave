import 'package:flutter/material.dart';

class CustomTabView extends StatefulWidget {
  final List<Widget> tabs; // List of "tab" buttons
  final List<Widget> views; // List of content views
  final Function(int) onTabSelected; // Callback for selection change

  const CustomTabView({
    super.key,
    required this.tabs,
    required this.views,
    required this.onTabSelected,
  });

  @override
  State<CustomTabView> createState() => _CustomTabViewState();
}

class _CustomTabViewState extends State<CustomTabView> {
  int _selectedIndex = 0; // Currently selected index

  @override
  Widget build(BuildContext context) {
    return Row(
      // Adjust to Column for vertical layout
      children: [
        for (int i = 0; i < widget.tabs.length; i++)
          Expanded(
            child: InkWell(
              onTap: () {
                setState(() {
                  _selectedIndex = i;
                  widget.onTabSelected(i); // Call callback
                });
              },
              child: Container(
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: _selectedIndex == i
                      ? Colors.blue[100]
                      : null, // Highlight selected tab
                  border: Border(
                    bottom: BorderSide(
                      color: _selectedIndex == i ? Colors.blue : Colors.grey,
                    ),
                  ),
                ),
                child: widget.tabs[i], // "Tab" button content
              ),
            ),
          ),
      ],
    );
  }
}
