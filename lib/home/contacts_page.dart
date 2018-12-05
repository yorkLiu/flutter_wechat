import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../constants.dart' show AppColors, AppStyle, Constants;
import '../modal/contact.dart';

class ContactsPage extends StatefulWidget {

  Color _indexBarBG = Colors.transparent;

  @override
  _ContactsPageState createState() => _ContactsPageState();
}

class _ContactItem extends StatelessWidget {
  _ContactItem({
    this.contact,
    this.showGroupTitle: false
  }) : assert(contact != null);

  final Contact contact;
  final bool showGroupTitle;

  static const double MARGIN_VERTICAL=10.0;
  static const double GROUP_TITLE_HEIGHT=24.0;

  static double _height(bool hasGroupTitle){
    double _buttonHeight = MARGIN_VERTICAL*2 + Constants.ContactAvatarSize
                           + Constants.DividerWidth;
    if(hasGroupTitle){
      return _buttonHeight + GROUP_TITLE_HEIGHT;
    }
    return _buttonHeight;
  }

  @override
  Widget build(BuildContext context) {
    // 头像图标
    Widget avatar;
    if (contact.isAvatarFromNetWork()) {
      avatar = Image(
          image: new CachedNetworkImageProvider(
            contact.avatar
          ),
          width: Constants.ContactAvatarSize,
          height: Constants.ContactAvatarSize
      );
//      avatar = Image.network(contact.avatar,
//          width: Constants.ContactAvatarSize,
//          height: Constants.ContactAvatarSize);
    } else {
      avatar = Image.asset(contact.avatar,
          width: Constants.ContactAvatarSize,
          height: Constants.ContactAvatarSize);
    }

    // 通讯主体
    Widget item = Container(
      margin: EdgeInsets.symmetric(horizontal: 16.0),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: MARGIN_VERTICAL),
          decoration: BoxDecoration(
              color: Color(AppColors.ConversationItemBg),
              border: Border(
                  bottom: BorderSide(
                      width: Constants.DividerWidth,
                      color: Color(AppColors.DividerColor)))),
          child: Row(
            children: <Widget>[
              avatar,
              SizedBox(width: 20.0),
              Text(contact.name)
            ],
          ),
        ));

    // 分组信息
    Widget groupTitle;
    if (showGroupTitle && contact.nameIndex != null) {
      groupTitle = Column(
        children: <Widget>[
          Container(
              height: GROUP_TITLE_HEIGHT,
              padding: EdgeInsets.only(left: 16.0, right: 16.0),
              color: const Color(AppColors.ContactGroupTitleBg),
              alignment: Alignment.centerLeft,
              child: Text(contact.nameIndex,
                  style: AppStyle.GroupTitleItemTextStyle)
          ),
          item,
        ],
      );
    }

    if (groupTitle != null) {
      return groupTitle;
    } else {
      return item;
    }
  }
}

class _ContactsPageState extends State<ContactsPage> {

  ScrollController _scrollController;

  ContactPageData _data = ContactPageData.mock();
  List<Contact> _contacts = [];
  List<Contact> _mainFunctionData = [
    const Contact(
        avatar: 'assets/images/ic_new_friend.png',
        name: "添加新朋友"
    ),
    const Contact(
        avatar: 'assets/images/ic_group_chat.png',
        name: '群聊'
    ),
    const Contact(
        avatar: 'assets/images/ic_tag.png',
        name: '标签'
    ),
    const Contact(
        avatar: 'assets/images/ic_public_account.png',
        name: '公众号'
    )
  ];

  Map<String, double> _globalPosition = {};

  @override
  void initState() {
    super.initState();

    _scrollController = new ScrollController();

    _contacts..addAll(_mainFunctionData)..addAll(_data.data);
    _contacts..sort((Contact a, Contact b) {
      String n1 = a.nameIndex??"0";
      String n2 =b.nameIndex??"0";
      return n1.compareTo(n2);
    });

    //////////////// 初始化并计算 每个 item 的 position [START/////////////////////
    var _totalPos = _mainFunctionData.length * _ContactItem._height(false);
    for (var i = _mainFunctionData.length; i < _contacts.length; i++) {
      bool _hasGroupTitle = true;
      Contact _contact = _contacts[i];
      if(i > _mainFunctionData.length && _contact.nameIndex.compareTo(_contacts[i-1].nameIndex) ==0){
        _hasGroupTitle = false;
      }

      if(_hasGroupTitle){
        _globalPosition[_contact.nameIndex] = _totalPos;
      }

      _totalPos += _ContactItem._height(_hasGroupTitle);
    }
    //////////////// 初始化并计算 每个 item 的 position [END]//////////////////////

  }

  Widget _buildIndexBar(BuildContext context, BoxConstraints constraints){

    final List<Widget> indexIndicator= Constants.CONTACT_INDEX_CHARACTERS.map((String character){
      return Expanded(
          child: Text(character, style: TextStyle(
            fontSize: 12.0
          ))
      );
    }).toList();

    final double _indexHeight = constraints.biggest.height;
    final double _tileHeight = _indexHeight / indexIndicator.length;

    // 获取index bar中选中的 字母
    String _getIndexLetter(BuildContext context, Offset globalPos){
      RenderBox _box  = context.findRenderObject();
      Offset _pos = _box.globalToLocal(globalPos);
      int _idx = (_pos.dy ~/ _tileHeight).clamp(0, indexIndicator.length -1);
      return Constants.CONTACT_INDEX_CHARACTERS[_idx];
    }

    // 滑动到哪个 index position
    void _jumpToIndex(letter){
      var _pos = _globalPosition[letter];
      if(_pos != null){
        _scrollController.animateTo(_pos,
            duration: Duration(milliseconds: 200),
            curve: Curves.easeOut);
      }
    }

    @override
    void dispose(){
      _scrollController.dispose();
      super.dispose();
    }

    return Container(
      color: widget._indexBarBG,
      child: GestureDetector(
        onVerticalDragDown: (DragDownDetails details){
          setState(() {
            widget._indexBarBG = Colors.black12;
            var _letter = _getIndexLetter(context, details.globalPosition);
            _jumpToIndex(_letter);
          });
        },

        onVerticalDragUpdate: (DragUpdateDetails details){
          setState(() {
            var _letter = _getIndexLetter(context, details.globalPosition);
            _jumpToIndex(_letter);
          });
        },

        onVerticalDragEnd: (DragEndDetails details){
          setState(() {
            widget._indexBarBG = Colors.transparent;
          });
        },
        onVerticalDragCancel: (){
          setState(() {
            widget._indexBarBG = Colors.transparent;
          });
        },
        child: Column(
          children: indexIndicator,
        ),
      )

    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        ListView.builder(
            controller: _scrollController,
            itemBuilder: (BuildContext context, int index) {
              bool showGroupTitle = true;
              Contact contact;

              if (index >= _mainFunctionData.length) {
                // 实现分组，给每个item 都添加 groupTitle,
                // 然后在这里用 showGroupTitle 来控制是否显示它
                int contactIndex = index - _mainFunctionData.length;
                contact = _contacts[index];
                if (contactIndex >= 1 &&
                    contact.nameIndex == _contacts[index - 1].nameIndex) {
                  showGroupTitle = false;
                }
              } else {
                contact = _contacts[index];
                showGroupTitle = false;
              }

              return _ContactItem(
                  contact: contact,
                  showGroupTitle: showGroupTitle
              );
            },
            itemCount: _contacts.length
        ),

        Positioned(
          top: 0.0,
          right: 0.0,
          bottom: 0.0,
          width: 25.0,
          child: LayoutBuilder(
              builder: _buildIndexBar
          ),
        )
      ],

    );
  }
}
