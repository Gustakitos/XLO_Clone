import 'package:flutter/material.dart';
import 'package:xlo_mobx/components/customDrawer/custom_drawer_header.dart';
import 'package:xlo_mobx/components/pageSection/page_section.dart';

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.horizontal(
        right: Radius.circular(50),
      ),
      child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.3,
          child: Drawer(
            child: ListView(
              children: [
                CustomDrawerHeader(),
                PageSection(),
              ],
            ),
          )),
    );
  }
}
