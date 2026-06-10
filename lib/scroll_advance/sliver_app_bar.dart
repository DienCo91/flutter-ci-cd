// ignore_for_file: unused_local_variable

import 'package:batterylevel/pages/setting.dart';
import 'package:flutter/material.dart';

List<String> _tabs = ["Pending", "Approved", "Cancelled"];

class SliverAppBarExample extends StatefulWidget {
  const SliverAppBarExample({Key? key}) : super(key: key);

  @override
  _SliverAppBarExampleState createState() => _SliverAppBarExampleState();
}

class _SliverAppBarExampleState extends State<SliverAppBarExample> with SingleTickerProviderStateMixin {
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      behavior: HitTestBehavior.opaque,
      child: DefaultTabController(
        length: _tabs.length,
        child: Scaffold(
          body: SafeArea(
            child: NestedScrollView(
              physics: const BouncingScrollPhysics(),
              headerSliverBuilder: (context, innerBoxIsScrolled) {
                return [
                  SliverAppBar(
                    centerTitle: true,
                    expandedHeight: screenHeight * 0.4,
                    backgroundColor: Colors.purple[300],
                    flexibleSpace: FlexibleSpaceBar(
                      collapseMode: CollapseMode.pin,
                      stretchModes: const [StretchMode.zoomBackground, StretchMode.fadeTitle],
                      centerTitle: true,
                      title: const Text(
                        'Giới thiệu thông tin',
                        style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      background: ColorFiltered(
                        colorFilter: ColorFilter.mode(Colors.black.withValues(alpha: 0.4), BlendMode.darken),
                        child: Image.network(
                          'https://images.pexels.com/photos/7081100/pexels-photo-7081100.jpeg',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  SliverPersistentHeader(
                    pinned: true,
                    delegate: _SliverTabBarDelegate(
                      TabBar(
                        tabs: _tabs.map((e) => Tab(text: e)).toList(),
                        labelColor: Colors.purple,
                        unselectedLabelColor: Colors.grey,
                        indicatorColor: Colors.purple,
                        indicatorWeight: 3.0,
                      ),
                      Expanded(
                        child: Container(
                          color: Colors.white,
                          child: TextField(
                            autofocus: false,
                            focusNode: _focusNode,
                            style: const TextStyle(fontSize: 16, color: Colors.black),
                            decoration: InputDecoration(
                              hintText: 'Tìm kiếm',

                              prefixIcon: const Icon(Icons.search),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ];
              },
              body: TabBarView(
                children: <Widget>[
                  Column(
                    children: [
                      Image.network(
                        cacheHeight: 200,

                        height: 200,
                        width: double.infinity,
                        'https://images.pexels.com/photos/1519753/pexels-photo-1519753.jpeg',
                        fit: BoxFit.cover,
                        frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
                          if (wasSynchronouslyLoaded) {
                            return child;
                          }
                          return SizedBox(
                            height: 200,
                            child: Center(
                              child: AnimatedSwitcher(
                                duration: const Duration(milliseconds: 500),
                                child: frame != null ? child : const CircularProgressIndicator(),
                              ),
                            ),
                          );
                        },
                      ),
                      Expanded(
                        child: ListView.builder(
                          key: const PageStorageKey('pending_tab_key'),
                          itemCount: 100,
                          itemBuilder: (context, index) {
                            return Container(
                              padding: const EdgeInsets.all(16),
                              child: ListTile(
                                onTap: () {
                                  _focusNode.unfocus();
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => const SliverAppBarExample()),
                                  );
                                },
                                title: Text('Nội dung thông tin số ${index + 1}', style: const TextStyle(fontSize: 16)),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  ListView.builder(
                    key: const PageStorageKey('approved_tab_key'),
                    itemCount: 100,
                    itemBuilder: (context, index) {
                      return Container(
                        padding: const EdgeInsets.all(16),
                        child: ListTile(
                          title: Text('Nội dung thông tin số ${index + 1}', style: const TextStyle(fontSize: 16)),
                        ),
                      );
                    },
                  ),
                  Center(
                    child: InkWell(
                      onTap: () => _focusNode.unfocus(),
                      child: Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Ink(child: const Text('Nội dung thông tin số 1', style: TextStyle(fontSize: 16))),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _SliverTabBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverTabBarDelegate(this._tabBar, this._widget);

  final TabBar _tabBar;
  final Widget _widget;

  @override
  double get minExtent => _tabBar.preferredSize.height + 54.0;

  @override
  double get maxExtent => _tabBar.preferredSize.height + 54.0;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Colors.white,
      child: Column(children: [_tabBar, _widget]),
    );
  }

  @override
  bool shouldRebuild(_SliverTabBarDelegate oldDelegate) {
    return false;
  }
}
