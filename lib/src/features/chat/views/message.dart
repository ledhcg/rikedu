import 'package:flutter/material.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:rikedu/src/utils/constants/sizes_constants.dart';

import 'widgets/user_status.dart';

class MessageScreen extends StatelessWidget {
  const MessageScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        leading: Transform.translate(
          offset: const Offset(SizesConst.P1, 0),
          child: IconButton(
            onPressed: () {
              Navigator.of(context).pop(true);
            },
            icon: const Icon(FluentIcons.chevron_left_48_filled),
          ),
        ),
        title: const UserStatus(
          username: 'John Doe',
          imageUrl: 'https://picsum.photos/250?image=8',
          online: true,
          description: 'Available for chat',
          typing: '',
        ),
      ),
      resizeToAvoidBottomInset: true,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Column(children: [
          // Flexible(
          //   flex: 6,
          //   child: BlocBuilder<MessageThreadCubit, List<LocalMessage>>(
          //     builder: (__, messages) {
          //       this.messages = messages;
          //       if (this.messages.isEmpty)
          //         return Container(
          //           alignment: Alignment.topCenter,
          //           padding: EdgeInsets.only(top: 30),
          //           color: Colors.transparent,
          //           child: widget.chat.type == ChatType.group
          //               ? DecoratedBox(
          //                   decoration: BoxDecoration(
          //                       color: kPrimary.withOpacity(0.9),
          //                       borderRadius: BorderRadius.circular(20)),
          //                   child: Padding(
          //                     padding: const EdgeInsets.all(4.0),
          //                     child: Text('Group created',
          //                         style: Theme.of(context)
          //                             .textTheme
          //                             .caption
          //                             .copyWith(color: Colors.white)),
          //                   ),
          //                 )
          //               : Container(),
          //         );
          //       WidgetsBinding.instance
          //           .addPostFrameCallback((_) => _scrollToEnd());
          //       return _buildListOfMessages();
          //     },
          //   ),
          // ),
          Expanded(
            child: Container(
              height: 100,
              decoration: const BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, -3),
                    blurRadius: 6.0,
                    color: Colors.black12,
                  ),
                ],
              ),
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Expanded(child: Text('ABC')),
                    Padding(
                      padding: const EdgeInsets.only(left: 12.0),
                      child: SizedBox(
                        height: 45.0,
                        width: 45.0,
                        child: RawMaterialButton(
                          shape: const CircleBorder(),
                          elevation: 5.0,
                          child: const Icon(
                            FluentIcons.send_24_filled,
                            color: Colors.white,
                          ),
                          onPressed: () {},
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ]),
      ),
    );
  }
}
