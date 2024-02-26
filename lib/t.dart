// LQuestionCard(),
//               Divider(),
//               Obx(
//                 () => ListView.builder(
//                   itemCount: commentController.comments.length,
//                   itemBuilder: (context, index) {
//                     return ListTile(
//                       title: Text(commentController.comments[index]),
//                     );
//                   },
//                 ),
//               ),

//               Padding(
//                 padding: EdgeInsets.all(16.0),
//                 child: Row(
//                   children: [
//                     Expanded(
//                       child: TextField(
//                         maxLines: null,
//                         controller: commentController.commentText,
//                         decoration: InputDecoration(
//                           hintText: 'Enter your comment',
//                         ),
//                       ),
//                     ),
//                     IconButton(
//                       icon: Icon(Iconsax.send1),
//                       onPressed: commentController.addComment,
//                     ),
//                   ],
//                 ),
//               ),