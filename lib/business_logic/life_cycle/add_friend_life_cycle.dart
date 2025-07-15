import 'package:flutter/cupertino.dart';
import 'package:tencent_cloud_chat_uikit/business_logic/life_cycle/base_life_cycle.dart';

class AddFriendLifeCycle {
  /// Before requesting to add a user as friend or a contact,
  /// `true` means can add continually, while `false` will not add.
  /// You can make a second confirmation here by a modal, etc.
  FutureBool Function(
      String userID, String? remark, String? friendGroup, String? addWording,
      [BuildContext? context]) shouldAddFriend;

  void Function(String userID)? sendApplyMessage;

  void Function()? showLoading;
  void Function()? dissmissLoading;

  AddFriendLifeCycle({
    this.shouldAddFriend = DefaultLifeCycle.defaultAddFriend,
    this.sendApplyMessage,
    this.showLoading,
    this.dissmissLoading,
  });
}
