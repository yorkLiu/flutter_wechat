import 'package:flutter/material.dart';
import '../constants.dart';

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
        icon: Icon(icon, color: Color(AppColors.TabIconNormal)),
        activeIcon: Icon(activeIcon, color: Color(AppColors.TabIconActive)),
        title: Text(title),
        backgroundColor: Colors.white
      );
}

class HomePageState extends State<HomePage> {

  int _currentIndex = 0;
  List<NavigationIconView> _navigationViews;

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
  }


  @override
  Widget build(BuildContext context) {

    final BottomNavigationBar bottomNavigationBar = BottomNavigationBar(
      items: _navigationViews.map<BottomNavigationBarItem>((NavigationIconView navigationViews)=>navigationViews.item)
            .toList(),
      currentIndex: _currentIndex,
      type: BottomNavigationBarType.fixed,
      onTap: (int index){
        _currentIndex = index;
        print("你点击了第$index button");
      },
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('微信', style: TextStyle(fontSize: 18.0),),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              print("你点击了搜索按钮");
            },
          ),
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
                print("你点击了添加按钮");
            }
          )
        ],
      ),

      body: Container(
        color: Colors.white,
      ),

      bottomNavigationBar: bottomNavigationBar,
    );
  }

}