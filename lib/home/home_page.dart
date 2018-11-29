import 'package:flutter/material.dart';
import '../constants.dart';

enum ActionItems {
  GROUP_CHAT, ADD_FRIEND, QR_SCAN, PAYMENT, HELP
}

class HomePage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return HomePageState();
  }
}

/// Define the NavigationIconView class
class NavigationIconView{
  BottomNavigationBarItem item;
  NavigationIconView({Key key, String title, IconData icon, IconData activeIcon}):
      item = BottomNavigationBarItem(
        icon: Icon(icon),
        activeIcon: Icon(activeIcon),
        title: Text(title),
        backgroundColor: Colors.white
      );
}

class HomePageState extends State<HomePage> {

  int _currentIndex = 0;
  List<NavigationIconView> _navigationViews;

  PageController _pageController;
  List<Widget> _pages;

  void initState(){
    super.initState();
    _navigationViews = [
      NavigationIconView(
        title: '微信',
        icon: IconData(
          0xe608,
          fontFamily: Constants.AppFontFamily
        ),
        activeIcon: IconData(
            0xe603,
            fontFamily: Constants.AppFontFamily
        )
      ),

      NavigationIconView(
        title: '通讯',
        icon: IconData(
            0xe601,
            fontFamily: Constants.AppFontFamily
        ),
        activeIcon: IconData(
            0xe656,
            fontFamily: Constants.AppFontFamily
        )
      ),

      NavigationIconView(
          title: '发现',
          icon: IconData(
              0xe600,
              fontFamily: Constants.AppFontFamily
          ),
          activeIcon: IconData(
              0xe671,
              fontFamily: Constants.AppFontFamily
          )
      ),

      NavigationIconView(
          title: '我',
          icon: IconData(
              0xe6c0,
              fontFamily: Constants.AppFontFamily
          ),
          activeIcon: IconData(
              0xe626,
              fontFamily: Constants.AppFontFamily
          )
      )
    ];

    // init the PageController
    _pageController = PageController(
        initialPage: _currentIndex
    );

    // init the pages
    _pages = [
      Container(color: Colors.white),
      Container(color: Colors.brown),
      Container(color: Colors.lightBlue),
      Container(color: Colors.blueGrey)
    ];
  }


  @override
  Widget build(BuildContext context) {

    final BottomNavigationBar bottomNavigationBar = BottomNavigationBar(
      fixedColor: const Color(AppColors.TabIconActive),
      items: _navigationViews.map<BottomNavigationBarItem>((NavigationIconView navigationViews)=>navigationViews.item)
            .toList(),
      currentIndex: _currentIndex,
      type: BottomNavigationBarType.fixed,
      onTap: (int index){
        setState(() {
          _currentIndex = index;

          // 点击 botto navigation bar 时跳转到页面
          _pageController.animateToPage(_currentIndex, duration: Duration(milliseconds: 300), curve: Curves.easeInOut);

        });
      },
    );

    _buildPopupMenuItem(int iconName, String title){
      return Row(
        children: <Widget>[
          Icon(IconData(
              iconName,
              fontFamily: Constants.AppFontFamily),
            size: 22.0,
            color: const Color(AppColors.AppBarPopupMenuColor),
          ),

          Container(width: 12.0),

          Text(title, style: TextStyle(color: const Color(AppColors.AppBarPopupMenuColor)))
        ],
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('微信', style: TextStyle(fontSize: 18.0)),
        elevation: 0.0, // 去掉 app bar 的影映
        actions: <Widget>[
          IconButton(
            icon: Icon(IconData(
              0xe65e,
              fontFamily: Constants.AppFontFamily
            ),
              size: 22.0
            ),
            onPressed: () {
              print("你点击了搜索按钮");
            },
          ),

          Container(width: 16.0),

          PopupMenuButton(
            offset: Offset(0, 60.0),
            itemBuilder: (BuildContext context){
              return <PopupMenuItem<ActionItems>>[
                PopupMenuItem(
                    child: _buildPopupMenuItem(0xe69e, "发起群聊"),
                    value: ActionItems.GROUP_CHAT
                ),

                PopupMenuItem(
                  child: _buildPopupMenuItem(0xe638, "添加朋友"),
                  value: ActionItems.ADD_FRIEND,
                ),

                PopupMenuItem(
                  child: _buildPopupMenuItem(0xe61b, "扫一扫"),
                  value: ActionItems.QR_SCAN,
                ),

                PopupMenuItem(
                  child: _buildPopupMenuItem(0xe62a, "收付款"),
                  value: ActionItems.PAYMENT,
                ),

                PopupMenuItem(
                  child: _buildPopupMenuItem(0xe63d, "帮助与反馈"),
                  value: ActionItems.HELP,
                ),
              ];
            },
            icon: Icon(IconData(
                0xe658,
                fontFamily: Constants.AppFontFamily),
                size: 22.0),
            onSelected: (ActionItems item) {
              print("你点击了$item");
            },

          ),

          Container(width: 10.0),
        ],
      ),

      body: PageView.builder(
          itemBuilder: (BuildContext context, int index){
            return _pages[index];
          },
          controller: _pageController,
          itemCount: _pages.length,
          onPageChanged: (int index){
            setState(() {
              // 滑动到哪个页面，则bottom navigation bar 就应该是哪个button选中
              // 页面与bottom navigation bar 联动
              _currentIndex = index;
            });

          }
      ),

      bottomNavigationBar: bottomNavigationBar,
    );
  }

}