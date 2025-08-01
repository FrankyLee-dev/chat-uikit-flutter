import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tencent_cloud_chat_uikit/tencent_cloud_chat_uikit.dart';
import 'package:tencent_cloud_chat_uikit/ui/utils/screen_utils.dart';
import 'package:tencent_cloud_chat_uikit/base_widgets/tim_ui_kit_state.dart';
import 'package:tencent_cloud_chat_uikit/business_logic/life_cycle/add_friend_life_cycle.dart';
import 'package:tencent_cloud_chat_uikit/business_logic/view_models/tui_self_info_view_model.dart';
import 'package:tencent_cloud_chat_uikit/data_services/friendShip/friendship_services.dart';
import 'package:tencent_cloud_chat_uikit/data_services/services_locatar.dart';

import 'package:tencent_cloud_chat_uikit/ui/widgets/avatar.dart';
import 'package:tencent_cloud_chat_uikit/base_widgets/tim_ui_kit_base.dart';

class SendApplication extends StatefulWidget {
  final V2TimUserFullInfo friendInfo;
  final TUISelfInfoViewModel model;
  final bool? isShowDefaultGroup;
  final AddFriendLifeCycle? lifeCycle;
  final AppBar? appBar;

  const SendApplication({Key? key,
    this.lifeCycle,
    required this.friendInfo,
    required this.model,
    this.appBar,
    this.isShowDefaultGroup = false})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _SendApplicationState();
}

class _SendApplicationState extends TIMUIKitState<SendApplication> {
  final TextEditingController _verficationController = TextEditingController();
  final TextEditingController _nickNameController = TextEditingController();

  bool availableSendBtn = true;

  @override
  void initState() {
    super.initState();
    final showName =
        widget.model.loginInfo?.nickName ?? widget.model.loginInfo?.userID;
    // _verficationController.text = "${TIM_t("哈喽，我是")} $showName";
  }

  @override
  Widget tuiBuild(BuildContext context, TUIKitBuildValue value) {
    final TUITheme theme = value.theme;
    final FriendshipServices _friendshipServices =
    serviceLocator<FriendshipServices>();

    final faceUrl = widget.friendInfo.faceUrl ?? "";
    final userID = widget.friendInfo.userID ?? "";
    final String showName = ((widget.friendInfo.nickName != null &&
        widget.friendInfo.nickName!.isNotEmpty)
        ? widget.friendInfo.nickName
        : userID) ??
        "";
    final option2 = widget.friendInfo.selfSignature ?? "";

    Widget sendApplicationBody() {
      return SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: theme.white,
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              margin: const EdgeInsets.only(bottom: 12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    margin: const EdgeInsets.only(right: 12),
                    child: Avatar(faceUrl: faceUrl,
                      showName: showName,
                      borderRadius: BorderRadius.circular(4),),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        showName,
                        style:
                        TextStyle(color: theme.darkTextColor, fontSize: 18),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Text(
                        "ID: $userID",
                        style:
                        TextStyle(fontSize: 13, color: theme.weakTextColor),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      if (TencentUtils.checkString(option2) != null)
                        Text(
                          TIM_t_para(
                              "个性签名: {{option2}}", "个性签名: $option2")(
                              option2: option2),
                          style: TextStyle(
                              fontSize: 13, color: theme.weakTextColor),
                        ),
                    ],
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Text(
                TIM_t("填写验证信息"),
                style: TextStyle(fontSize: 16, color: theme.weakTextColor),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 6, bottom: 12),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              color: theme.white,
              child: TextField(
                // minLines: 1,
                maxLines: 4,
                controller: _verficationController,
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintStyle: TextStyle(color: theme.textgrey),
                  hintText: '${TIM_t("请填写添加好友的理由")}',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Text(
                TIM_t("请填写备注"),
                style: TextStyle(fontSize: 16, color: theme.weakTextColor),
              ),
            ),
            Container(
              color: theme.white,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              margin: const EdgeInsets.only(top: 6),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    TIM_t("备注"),
                    style: TextStyle(color: theme.darkTextColor, fontSize: 16),
                  ),
                  SizedBox(width: 16,),
                  Expanded(
                    child: TextField(
                      controller: _nickNameController,
                      inputFormatters: [
                        LengthLimitingChineseAndCharacterInputFormatter(32, 16),
                      ],
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.zero,
                        border: InputBorder.none,
                        hintStyle: TextStyle(
                          color: theme.textgrey,
                        ),
                        hintText: '',
                      ),
                    ),
                  )
                ],
              ),
            ),
            const Divider(
              height: 1,
            ),
            if (widget.isShowDefaultGroup == true)
              Container(
                color: theme.white,
                padding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      TIM_t("分组"),
                      style:
                      TextStyle(color: theme.darkTextColor, fontSize: 16),
                    ),
                    Text(
                      TIM_t("我的好友"),
                      style:
                      TextStyle(color: theme.darkTextColor, fontSize: 16),
                    )
                  ],
                ),
              ),
            Container(
              color: availableSendBtn ? theme.white : theme.weakBackgroundColor,
              width: double.infinity,
              margin: const EdgeInsets.only(top: 10),
              child: TextButton(
                style: TextButton.styleFrom(
                  splashFactory: availableSendBtn ? InkSplash.splashFactory : NoSplash.splashFactory,
                ),
                onPressed: () async {
                  if (!availableSendBtn) return;
                  final remark = _nickNameController.text;
                  final addWording = _verficationController.text;
                  final friendGroup = TIM_t("我的好友");

                  if (widget.lifeCycle?.shouldAddFriend != null &&
                      await widget.lifeCycle!.shouldAddFriend(userID, remark,
                          friendGroup, addWording, context) ==
                          false) {
                    return;
                  }

                  if (widget.lifeCycle?.showLoading != null) {
                    widget.lifeCycle?.showLoading!.call();
                  }

                  final res = await _friendshipServices.addFriend(
                      userID: userID,
                      addType: FriendTypeEnum.V2TIM_FRIEND_TYPE_BOTH,
                      remark: remark,
                      addWording: addWording,
                      friendGroup: friendGroup);

                  if (widget.lifeCycle?.dissmissLoading != null) {
                    widget.lifeCycle?.dissmissLoading!.call();
                  }

                  if (res.code == 0 && res.data?.resultCode == 0) {
                    onTIMCallback(TIMCallback(
                        type: TIMCallbackType.INFO,
                        infoRecommendText: TIM_t("好友添加成功"),
                        infoCode: 6661202));
                    setState(() {
                      availableSendBtn = false;
                    });
                  } else if (res.code == 0 && res.data?.resultCode == 30539) {
                    if (widget.lifeCycle != null &&
                        widget.lifeCycle!.sendApplyMessage != null) {
                      widget.lifeCycle!.sendApplyMessage!(userID);
                    }
                    onTIMCallback(TIMCallback(
                        type: TIMCallbackType.INFO,
                        infoRecommendText: TIM_t("好友申请已发出"),
                        infoCode: 6661203));
                    setState(() {
                      availableSendBtn = false;
                    });
                  } else if (res.code == 0 && res.data?.resultCode == 30515) {
                    onTIMCallback(TIMCallback(
                        type: TIMCallbackType.INFO,
                        infoRecommendText: TIM_t("当前用户在黑名单"),
                        infoCode: 6661204));
                    setState(() {
                      availableSendBtn = false;
                    });
                  }
                },
                child: Text(TIM_t("发送"), style: TextStyle(
                    color: availableSendBtn ? theme.primaryColor : theme
                        .textgrey, fontSize: 16),),),
            )
          ],
        ),
      );
    }

    return TUIKitScreenUtils.getDeviceWidget(
        context: context,
        desktopWidget: Container(
          padding: const EdgeInsets.only(top: 10),
          color: theme.weakBackgroundColor,
          child: sendApplicationBody(),
        ),
        defaultWidget: Scaffold(
          appBar: widget.appBar ?? AppBar(
            title: Text(
              TIM_t("添加好友"),
              style: TextStyle(color: theme.appbarTextColor, fontSize: 17),
            ),
            shadowColor: theme.white,
            backgroundColor: theme.appbarBgColor ?? theme.primaryColor,
            iconTheme: IconThemeData(
              color: theme.appbarTextColor,
            ),
          ),
          body: sendApplicationBody(),
        ));
  }
}

class LengthLimitingChineseAndCharacterInputFormatter
    extends TextInputFormatter {
  final int maxLength;
  final int maxChineseLength;

  LengthLimitingChineseAndCharacterInputFormatter(this.maxLength,
      this.maxChineseLength);

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue,
      TextEditingValue newValue) {
    String newText = newValue.text;
    int charCount = 0;
    int chineseCharCount = 0;

    for (int i = 0; i < newText.length; i++) {
      String char = newText[i];
      if (RegExp(r'[\u4e00-\u9fa5]').hasMatch(char)) {
        chineseCharCount++;
        charCount += 2;
      } else {
        charCount++;
      }

      if (chineseCharCount > maxChineseLength || charCount > maxLength) {
        // 超过限制，返回旧的值（也可以截断）
        return oldValue;
      }
    }

    return newValue;
  }
}
