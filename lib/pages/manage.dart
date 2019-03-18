import 'package:flutter/material.dart';

import 'list.dart';
import 'edit.dart';

class ManagePage extends StatelessWidget {

  Widget _buildSideDrawer(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            automaticallyImplyLeading: false,
            title: Text('Choose'),
          ),
          ListTile(
            leading: Icon(Icons.shop),
            title: Text('All Products'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/home');
            },
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Manage'),
          bottom: TabBar(
            tabs: <Widget>[
              Tab(text: 'Create Product', icon: Icon(Icons.create)),
              Tab(text: 'My Products', icon: Icon(Icons.list))
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            EditPage(),
            ListPage()
          ],
        ),
        drawer: _buildSideDrawer(context),
      ),
    );
  }
}
