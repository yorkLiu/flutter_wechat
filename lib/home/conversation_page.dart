import 'package:flutter/material.dart';
import '../modal/conversation.dart' show ConversationPageData;
import '../constants.dart' show AppColors, AppStyle, Constants;
import '../modal/conversation.dart' show Conversation, ConversationPageData;


class _ConversationItem extends StatelessWidget{

  const _ConversationItem({Key key, this.conversation}) : super(key: key);

  final Conversation conversation;

  @override
  Widget build(BuildContext context) {
    // 根据图片的获取方式初始化头像组件
    Widget avatar;
    if(conversation.avatarFromNetWork()){
      // 图片来源于网络
      avatar = Image.network(
          conversation.avatar,
          width: Constants.ConversationAvatarSize,
          height: Constants.ConversationAvatarSize
      );
    } else {
      // 图片来源于 assets目录
      avatar = Image.asset(
        conversation.avatar,
        width: Constants.ConversationAvatarSize,
        height: Constants.ConversationAvatarSize,
      );
    }

    return Container(
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: Color(AppColors.ConversationItemBg),
        border: Border(
            bottom: BorderSide(
              color: Color(AppColors.DividerColor),
              width: Constants.DividerWidth
            )
        )
      ),
      child: Row(
        children: <Widget>[

          // 头像
          avatar,

          Container(width: 10.0),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(conversation.title, style: AppStyle.TitleStyle),
                Text(conversation.description, style: AppStyle.DescriptionStyle)

              ],
            ),
          ),
          Container(width: 10.0),

          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Text(conversation.updateAt, style: AppStyle.DescriptionStyle)
            ],
          )

        ],
      ),
    );
  }
}

class ConversationPage extends StatefulWidget {
  @override
  _ConversationPageState createState() => _ConversationPageState();
}

class _ConversationPageState extends State<ConversationPage> {
  final ConversationPageData data = ConversationPageData.mock();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemBuilder: (BuildContext context, int index){
          return _ConversationItem(conversation: data.conversations[index]);
        },
      itemCount: data.conversations.length,
    );
  }
}
