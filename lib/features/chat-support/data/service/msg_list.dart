/// msgId : 6
/// senderId : 212
/// receiverId : null
/// msg : "df"
/// roomId : 212
/// sendTime : 1640189755772
/// createdAt : "2021-12-22T16:15:55.772Z"
/// updatedAt : "2021-12-22T16:15:55.772Z"

class MsgList {
  MsgList({
    this.msgId,
    this.senderId,
    this.receiverId,
    this.msg,
    this.roomId,
    this.sendTime,
    this.createdAt,
    this.updatedAt,
  });

  MsgList.fromJson(dynamic json) {
    msgId = json['msgId'];
    senderId = json['senderId'];
    receiverId = json['receiverId'];
    msg = json['msg'];
    roomId = json['roomId'];
    sendTime = json['sendTime'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }
  int? msgId;
  int? senderId;
  dynamic receiverId;
  String? msg;
  int? roomId;
  int? sendTime;
  String? createdAt;
  String? updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['msgId'] = msgId;
    map['senderId'] = senderId;
    map['receiverId'] = receiverId;
    map['msg'] = msg;
    map['roomId'] = roomId;
    map['sendTime'] = sendTime;
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    return map;
  }
}
