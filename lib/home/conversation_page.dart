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

    Widget avatarUnReadMix;

    // 如果有 unread 消息，则显示其数量
    // 如果没有，则不显示
    if(conversation.unreadMsgCount > 0){
      // 未读消息数量
      Widget unReadMsgContainer = Container(
        width: Constants.UnReadMsgNotifyDotSize,
        height: Constants.UnReadMsgNotifyDotSize,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: Color(AppColors.NotifyDotBg),
            borderRadius: BorderRadius.circular(Constants.UnReadMsgNotifyDotSize/2)
        ),

        child: Text(
            conversation.unreadMsgCount.toString(),
            style: AppStyle.UnreadMsgCountDotStyle
        ),
      );

      avatarUnReadMix = Stack(
        overflow: Overflow.visible,
        children: <Widget>[
          avatar,
          Positioned(
            top: -6.0,
            right: -6.0,
            child: unReadMsgContainer,
          )
        ],
      );
    } else {
      avatarUnReadMix = avatar;
    }

    var rightPartItems = <Widget>[
      Text(conversation.updateAt, style: AppStyle.DescriptionStyle),
      SizedBox(height: 10.0)
    ];

    if(conversation.isMute){
      // 勿扰图标
      rightPartItems.add(
          Icon(IconData(
              0xe755,
              fontFamily: Constants.AppFontFamily
          ),
            size: Constants.ConversationMuteIconSize,
            color: Color(AppColors.ConversationMuteIcon))
      );
    } else {
      // 如果没有 mute icon, 则用 sizedbox 来填充一个大小于 mute icon的区域
      // 以免 『updateAt』显示的位置不统一
      rightPartItems.add(
          SizedBox(
              width: Constants.ConversationMuteIconSize,
              height: Constants.ConversationMuteIconSize));
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
          avatarUnReadMix,

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
            children: rightPartItems,
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
