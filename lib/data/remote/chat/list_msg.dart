import 'msg_list.dart';

/// msgList : [{"msgId":6,"senderId":212,"receiverId":null,"msg":"df","roomId":212,"sendTime":1640189755772,"createdAt":"2021-12-22T16:15:55.772Z","updatedAt":"2021-12-22T16:15:55.772Z"}]
/// isMore : false

class ListMsg {
  ListMsg({
    this.msgList,
    this.isMore,
  });

  ListMsg.fromJson(dynamic json) {
    if (json['msgList'] != null) {
      msgList = [];
      json['msgList'].forEach((v) {
        msgList?.add(MsgList.fromJson(v));
      });
    }
    isMore = json['isMore'];
  }
  List<MsgList>? msgList;
  bool? isMore;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (msgList != null) {
      map['msgList'] = msgList?.map((v) => v.toJson()).toList();
    }
    map['isMore'] = isMore;
    return map;
  }
}
