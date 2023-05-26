// import 'package:flutter/material.dart';
// import 'package:rikedu/src/features/chat/views/widgets/user_image.dart';

// class UserStatus extends StatelessWidget {
//   final String username;
//   final String imageUrl;
//   final bool online;
//   final String description;
//   final String typing;
//   const UserStatus(
//       {super.key,
//       required this.username,
//       required this.imageUrl,
//       required this.online,
//       required this.description,
//       required this.typing});

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: double.maxFinite,
//       child: Row(
//         children: [
//           UserImage(
//             imageUrl: imageUrl,
//             online: online,
//           ),
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Padding(
//                 padding: const EdgeInsets.only(left: 12.0),
//                 child: Text(
//                   username.trim(),
//                   style: Theme.of(context).textTheme.bodyLarge?.copyWith(
//                         fontSize: 16.0,
//                         fontWeight: FontWeight.bold,
//                       ),
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(left: 12.0),
//                 child: typing == ''
//                     ? Text(
//                         online ? 'online' : description,
//                         style: Theme.of(context)
//                             .textTheme
//                             .bodySmall
//                             ?.copyWith(fontStyle: FontStyle.italic),
//                       )
//                     : Text(
//                         typing,
//                         style: Theme.of(context)
//                             .textTheme
//                             .displaySmall
//                             ?.copyWith(fontStyle: FontStyle.italic),
//                       ),
//               ),
//             ],
//           )
//         ],
//       ),
//     );
//   }
// }
