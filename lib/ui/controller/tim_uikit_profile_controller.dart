import 'package:flutter/cupertino.dart';
import 'package:tencent_im_base/tencent_im_base.dart';
import 'package:tencent_cloud_chat_uikit/business_logic/separate_models/tui_profile_view_model.dart';
import 'package:tencent_cloud_chat_uikit/ui/widgets/text_input_bottom_sheet.dart';

class TIMUIKitProfileController {
  late TUIProfileViewModel model;

  /// Remove a user from friend or contact
  Future<V2TimFriendOperationResult?> deleteFriend(String userID) {
    return model.deleteFriend(userID);
  }

  /// Deprecated: Please use [pinConversation] instead. Pin the conversation to the top
  @Deprecated("Please use [pinConversation] instead")
  Future<V2TimCallback> pinedConversation(bool isPined, String convID) {
    return model.pinedConversation(isPined, convID);
  }

  /// pin the conversation to the top
  Future<V2TimCallback> pinConversation(bool isPined, String convID) {
    return model.pinedConversation(isPined, convID);
  }

  /// add a user to block list
  Future<List<V2TimFriendOperationResult>?> addUserToBlackList(
      bool shouldAdd, String userID) {
    return model.addToBlackList(shouldAdd, userID);
  }

  /// Change the friend adding request verification method,
  /// 0 represents "Accept all friend request",
  /// 1 represents "Require approval for friend requests",
  /// 2 represents "reject all friend requests".
  Future<V2TimCallback> changeFriendVerificationMethod(int allowType) {
    return model.changeFriendVerificationMethod(allowType);
  }

  /// update the remarks for other users,
  Future<V2TimCallback> updateRemarks(String userID, String remark) {
    return model.updateRemarks(userID, remark);
  }

  /// set the message from a specific user as not disturb, mute notification
  Future<V2TimCallback> setMessageDisturb(String userID, bool isDisturb) {
    return model.setMessageDisturb(userID, isDisturb);
  }

  /// Show the text input bottom sheet
  showTextInputBottomSheet({
    required BuildContext context,
    required String title,
    required String tips,
    required Function(String text) onSubmitted,
    required TUITheme theme,
    Future<bool> Function(String remark, String toast)? onDetectRemask,
    Offset? initOffset,
    String? initText,
  }) {
    TextInputBottomSheet.showTextInputBottomSheet(
        context: context,
        title: title,
        tips: tips,
        onSubmitted: onSubmitted,
        theme: theme,
        initOffset: initOffset,
        initText: initText,
        onDetectRemask: onDetectRemask);
  }

  /// Load the profile data
  loadData(String userID) {
    model.loadData(userID: userID);
  }

  dispose() {
    model.dispose();
  }

  /// Add a user as friend or contact
  Future<V2TimFriendOperationResult?> addFriend(String userID) {
    return model.addFriend(userID);
  }

  Future<V2TimCallback> updateSelfSignature(String selfSignature) {
    return model.updateSelfSignature(selfSignature);
  }

  Future<V2TimCallback> updateNickName(String nickName) {
    return model.updateNickName(nickName);
  }

  Future<V2TimCallback> updateGender(int gender) {
    return model.updateGender(gender);
  }
}
