import 'package:flutter/material.dart';
import '../constants.dart' show AppColors, AppStyle, Constants;
import '../modal/contact.dart';

class ContactsPage extends StatefulWidget {
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

  @override
  Widget build(BuildContext context) {
    // 头像图标
    Widget avatar;
    if (contact.isAvatarFromNetWork()) {
      avatar = Image.network(contact.avatar,
          width: Constants.ContactAvatarSize,
          height: Constants.ContactAvatarSize);
    } else {
      avatar = Image.asset(contact.avatar,
          width: Constants.ContactAvatarSize,
          height: Constants.ContactAvatarSize);
    }

    // 通讯主体
    Widget item = Container(
//        padding: EdgeInsets.only(left: 16.0, right: 16.0),
      margin: EdgeInsets.symmetric(horizontal: 16.0),

        child: Container(
//          padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
          padding: EdgeInsets.symmetric(vertical: 10.0),
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
              padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 4.0, bottom: 4.0),
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

  @override
  void initState() {
    super.initState();

    _contacts..addAll(_mainFunctionData)..addAll(_data.data);
    _contacts..sort((Contact a, Contact b) {
      String n1 = a.nameIndex??"0";
      String n2 =b.nameIndex??"0";
      return n1.compareTo(n2);
    });
  }

  Widget buildIndexBar(){
    final List<Widget> indexIndictor= Constants.CONTACT_INDEX_CHARACTERS.map((String character){
      return Expanded(
          child: Text(character)
      );
    }).toList();

    return Column(
        children: indexIndictor,
    );
  // ignore: expected_class_member
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        ListView.builder(
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
          child: buildIndexBar(),
        )
      ],

    );
  }
}
