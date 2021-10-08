import 'dart:convert';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late TabController _tabController;
  final _biggerFont =
      const TextStyle(fontSize: 18.0, fontFamily: 'NotoSansMono');
  Widget searchBar = const ListTile(
      focusColor: Colors.orange,
      hoverColor: Colors.orange,
      selectedTileColor: Colors.orange,
      trailing: Icon(Icons.search, color: Colors.black),
      title: TextField(
        cursorColor: Colors.orange,
        decoration: InputDecoration(
            hintText: 'Search RightTrack...',
            hintStyle: TextStyle(
              color: Colors.grey,
            ),
            fillColor: Colors.orange,
            focusColor: Colors.orange,
            hoverColor: Colors.orange),
        style: TextStyle(color: Colors.grey, fontFamily: 'NotoSansMono'),
      ));
  final String jsonString = '''
    {
    "posts": [
        {
            "user": "Cathal MacRuairi",
            "track": "USHIO",
            "description": "USHIO is the most recent track I'm working on, featuring a gritty bass underneath a soothing melody. Let me know what you think of the structure!"
        },
        {
            "user": "Ryan Jeffares",
            "track": "Tradition",
            "description": "Tradition is an introspective an personal track that tries to incorporate some of my new and old influences."
        },
        {
            "user": "Meijis",
            "track": "Abhartach",
            "description": "WAGWAN WAGWAN WAGWAN WAGWAN WAGWAN WAGWAN WAGWAN WAGWAN WAGWAN WAGWAN WAGWAN "
        },
        {
            "user": "rhys",
            "track": "wee rat",
            "description": "aye wee rat keep her head on am only rakin listen 2 me new tune wee lad"
        }
    ]
  }
  ''';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
            onPressed: _settingsPushed,
            icon: const Icon(Icons.settings),
            tooltip: 'Settings',
          ),
        ],
      ),
      bottomNavigationBar: TabBar(
        indicatorColor: Colors.orange,
        controller: _tabController,
        tabs: const [
          Tab(
            icon: Icon(Icons.feed),
            text: 'My Feed',
          ),
          Tab(
            icon: Icon(Icons.search),
            text: 'Discover',
          ),
          Tab(
            icon: Icon(Icons.account_box),
            text: 'Profile',
          ),
        ],
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          Center(
            child: _buildFeed(),
          ),
          Center(child: _buildDiscoverPage()),
          Center(child: _buildProfilePage())
        ],
      ),
    );
  }

  void _settingsPushed() {}

  Widget _buildFeed() {
    var data = json.decode(jsonString);
    List entryList = data['posts'];

    return ListView.builder(
      itemCount: entryList.length * 2,
      padding: const EdgeInsets.all(16.0),
      itemBuilder: (context, i) {
        if (i.isOdd) return const Divider(color: Colors.orange);

        final index = i ~/ 2;

        return _buildRow(entryList[index]);
      },
    );
  }

  Widget _buildRow(Map<String, dynamic> entry) {
    return ListTile(
      trailing: const Icon(
        Icons.arrow_forward_rounded,
        color: Colors.orange,
      ),
      title: Text(
        '${entry['user']} - ${entry['track']}',
        style: _biggerFont,
      ),
      subtitle: Text(
        entry['description'],
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
      onTap: () {},
    );
  }

  bool searchActive = false;

  Widget _buildDiscoverPage() {
    return Scaffold(
        appBar: AppBar(
      centerTitle: false,
      backgroundColor: Colors.white,
      title: searchBar,
    ));
  }

  Widget _buildProfilePage() {
    return Scaffold(
        floatingActionButton: IconButton(
          icon: const Icon(Icons.edit, size: 48),
          onPressed: () {},
        ),
        body: Column(
          children: [
            _getPadding(),
            Container(
              width: 200,
              height: 200,
              decoration: const BoxDecoration(
                  boxShadow: [
                    BoxShadow(spreadRadius: 10, color: Colors.orange)
                  ],
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image: NetworkImage(
                        'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg',
                      ),
                      fit: BoxFit.fill)),
            ),
            _getPadding(),
            const Text('Ryan Jeffares', style: TextStyle(fontSize: 28)),
            _getPadding(),
            Container(
                padding: const EdgeInsets.all(16),
                child: const Text(
                  'This is my bio. This is where I would write about myself and what kind of music i make, then i guess below this there will be a way to access your tracks?',
                  textAlign: TextAlign.center,
                )),
            _getPadding(),
            const Divider(color: Colors.orange),
            ListTile(
              title: const Text(
                'View your tracks',
                style: TextStyle(fontSize: 24),
              ),
              trailing: const Icon(
                Icons.arrow_forward_rounded,
                color: Colors.orange,
              ),
              onTap: () {},
            ),
            const Divider(color: Colors.orange),
            ListTile(
                title: const Text(
                  'Post new track',
                  style: TextStyle(fontSize: 24),
                ),
                trailing: const Icon(
                  Icons.arrow_forward_rounded,
                  color: Colors.orange,
                ),
                onTap: () {}),
            const Divider(color: Colors.orange),
          ],
        ));
  }

  Widget _getPadding() {
    return const Padding(
      padding: EdgeInsets.all(16.0),
    );
  }
}
