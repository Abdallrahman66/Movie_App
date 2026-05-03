
// import 'package:flutter/material.dart';
// import 'package:movie_app/feature/widgets/cache_networkImage_widget.dart';

// class ImageItemWidget extends StatelessWidget {
//   const ImageItemWidget({
//     super.key,
//     required this.image,
//     required this.title,
//     this.onTap,
//   });
//   final String image;
//   final String title;
//   final void Function()? onTap;
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         padding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
//         margin: EdgeInsets.symmetric(horizontal: 8),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           spacing: 10,
//           children: [
//             //!  image
//             ClipRRect(
//               borderRadius: BorderRadius.circular(10),
//               child: CacheNetworkImage(
//                 imageUrl: image,
                // progressIndicatorBuilder: (context, url, downloadProgress) =>
                    // Center(
                      // child: CacheNetworkImage(imageUrl: url,),
                    // ),
                // errorWidget: (context, url, error) => Icon(Icons.error),
                // height: 200,
                // width: double.infinity,
                // fit: BoxFit.cover,
//               ),
//             ),

//             //! title
//             Text(
//               title,
//               style: TextStyle(
//                 color: Color(0xffFFFFFF),
//                 fontSize: 16,
//                 fontWeight: .w400,
//               ),

//               maxLines: 2,
//               overflow: TextOverflow.ellipsis,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
