import 'package:flutter/material.dart';
import  '../constants.dart' show AppColors;


enum Device {
  MAC, WIN
}

class Conversation {

  Conversation({
    @required this.avatar,
    @required this.title,
    this.titleColor: AppColors.TitleTextColor,
    this.description,
    @required this.updateAt,
    this.isMute: false,
    this.unreadMsgCount: 0,
    this.displayDot: false
  })
      :
        assert(avatar != null),
        assert(title != null),
        assert(updateAt != null);


  bool avatarFromNetWork(){
    return (avatar.toLowerCase().indexOf("http") ==0
        || avatar.toLowerCase().indexOf("https") ==0 );
  }

  String avatar;

  String title;

  int titleColor;

  String description;

  String updateAt;

  bool isMute;

  int unreadMsgCount;

  bool displayDot;

}


class ConversationPageData {

  ConversationPageData({this.device, this.conversations});

  Device device;
  List<Conversation> conversations;


  static mock (){
    return ConversationPageData(device: Device.MAC, conversations: mockConversations);
  }

  static List<Conversation> mockConversations = [
    Conversation(
      avatar: 'assets/images/ic_file_transfer.png',
      title: '文件传输助手',
      description: '',
      updateAt: '19:56',
    ),

    Conversation(
      avatar: 'assets/images/ic_tx_news.png',
      title: '腾讯新闻',
      description: '豪车与出租车刮擦 俩车主划拳定责',
      updateAt: '17:20',
    ),
    Conversation(
      avatar: 'assets/images/ic_wx_games.png',
      title: '微信游戏',
      titleColor: 0xff586b95,
      description: '25元现金助力开学季！',
      updateAt: '17:12',
    ),
    Conversation(
      avatar: 'https://randomuser.me/api/portraits/men/10.jpg',
      title: '汤姆丁',
      description: '今晚要一起去吃肯德基吗？',
      updateAt: '17:56',
      isMute: true,
      unreadMsgCount: 0,
    ),
    Conversation(
      avatar: 'https://randomuser.me/api/portraits/women/10.jpg',
      title: 'Tina Morgan',
      description: '晚自习是什么来着？你知道吗，看到的话赶紧回复我',
      updateAt: '17:58',
      isMute: false,
      unreadMsgCount: 3,
    ),
    Conversation(
      avatar: 'assets/images/ic_fengchao.png',
      title: '蜂巢智能柜',
      titleColor: 0xff586b95,
      description: '喷一喷，竟比洗牙还神奇！5秒钟还你一个漂亮洁白的口腔。',
      updateAt: '17:12',
    ),
    Conversation(
      avatar: 'https://randomuser.me/api/portraits/women/57.jpg',
      title: 'Lily',
      description: '今天要去运动场锻炼吗？',
      updateAt: '昨天',
      isMute: false,
      unreadMsgCount: 99,
    ),
    Conversation(
      avatar: 'https://randomuser.me/api/portraits/men/10.jpg',
      title: '汤姆丁',
      description: '今晚要一起去吃肯德基吗？',
      updateAt: '17:56',
      isMute: true,
      unreadMsgCount: 0,
    ),
    Conversation(
      avatar: 'https://randomuser.me/api/portraits/women/10.jpg',
      title: 'Tina Morgan',
      description: '晚自习是什么来着？你知道吗，看到的话赶紧回复我',
      updateAt: '17:58',
      isMute: false,
      unreadMsgCount: 3,
    ),
    Conversation(
      avatar: 'https://randomuser.me/api/portraits/women/57.jpg',
      title: 'Lily',
      description: '今天要去运动场锻炼吗？',
      updateAt: '昨天',
      isMute: false,
      unreadMsgCount: 0,
    ),
    Conversation(
      avatar: 'https://randomuser.me/api/portraits/men/10.jpg',
      title: '汤姆丁',
      description: '今晚要一起去吃肯德基吗？',
      updateAt: '17:56',
      isMute: true,
      unreadMsgCount: 0,
    ),
    Conversation(
      avatar: 'https://randomuser.me/api/portraits/women/10.jpg',
      title: 'Tina Morgan',
      description: '晚自习是什么来着？你知道吗，看到的话赶紧回复我',
      updateAt: '17:58',
      isMute: false,
      unreadMsgCount: 1,
    ),
    Conversation(
      avatar: 'https://randomuser.me/api/portraits/women/57.jpg',
      title: 'Lily',
      description: '今天要去运动场锻炼吗？',
      updateAt: '昨天',
      isMute: false,
      unreadMsgCount: 0,
    ),

  ];
}