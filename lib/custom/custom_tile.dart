import 'package:conclave/custom/spacers.dart';
import 'package:flutter/material.dart';

class CustomListTile extends StatefulWidget {
  final String title;
  final String subtitle;
  String? leadingImage;
  final Function() onTap;

  CustomListTile({
    required this.title,
    required this.subtitle,
    this.leadingImage,
    required this.onTap,
  });

  @override
  State<CustomListTile> createState() => _CustomListTileState();
}

class _CustomListTileState extends State<CustomListTile> {
  bool menu = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          menu = !menu;
        });
      },
      child: Container(
        height: 70,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(5)),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  HorizontalSpacer(width: 20),
                  Text(
                    widget.title,
                    style: const TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            // const MenuItemButton(child: Icon(Icons.more_vert_sharp))
            Row(
              children: [
                AnimatedOpacity(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  opacity: !menu ? 1 : 0,
                  child: IconButton(
                      onPressed: () {
                        setState(() {
                          menu = !menu;
                        });
                      },
                      icon: const Icon(
                        Icons.more_vert_sharp,
                        color: Colors.grey,
                      )),
                ),
                InkWell(
                    onTap: () {
                      print("dvsf");
                      widget.onTap();
                    },
                    child: AnimatedMenuButton(menu: menu)),
                InkWell(
                  onTap: () {
                    print("dvsadvslkvf");
                    setState(() {
                      menu = !menu;
                    });
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    width: menu ? 40 : 0,
                    height: 70,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(5),
                          bottomRight: Radius.circular(5)),
                      color: Colors.blue,
                    ),
                    child: menu
                        ? const Icon(
                            Icons.edit,
                            color: Colors.white,
                          )
                        : null,
                    //
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class AnimatedMenuButton extends StatelessWidget {
  const AnimatedMenuButton({
    super.key,
    required this.menu,
  });

  final bool menu;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
        width: menu ? 40 : 0,
        height: 70,
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 14, 129, 223),
        ),
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        child: menu
            ? const Icon(
                Icons.delete_outline,
                color: Colors.white,
              )
            : null
        //
        );
  }
}
