// import 'package:flutter/material.dart';

// class StepCardWidget extends StatelessWidget {
//   const StepCardWidget(
//       {Key? key,
//       required this.stepNumber,
//       required this.label,
//       required this.hasCompleted,
//       required this.onDonePressed,
//       required this.showSkipButton,
//       this.onSkipPressed})
//       : super(key: key);

//   final String stepNumber;
//   final String label;
//   final bool hasCompleted;
//   final bool showSkipButton;

//   final void Function() onDonePressed;
//   final void Function()? onSkipPressed;

//   @override
//   Widget build(BuildContext context) {
//     Color buttonColor = Colors.deepOrange;
//     if (hasCompleted) {
//       buttonColor = Colors.green;
//     }
//     return Container(
//       //Outer Container Decoration
//       margin: const EdgeInsets.only(bottom: 5, top: 5, left: 5, right: 5),
//       decoration: BoxDecoration(
//         border: Border.all(color: Colors.white60, width: 1),
//         borderRadius: const BorderRadius.all(
//           Radius.circular(5),
//         ),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.end,
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: [
//               Container(
//                 margin:
//                     const EdgeInsets.only(top: 8, right: 5, bottom: 5, left: 5),
//                 height: 60,
//                 width: (MediaQuery.of(context).size.width * 0.13),
//                 decoration:
//                     BoxDecoration(color: buttonColor, shape: BoxShape.circle),
//                 child: Center(
//                   child: Text(stepNumber),
//                 ),
//               ),
//               const SizedBox(
//                 width: 5,
//               ),
//               Container(
//                 margin: const EdgeInsets.only(top: 8, right: 5, bottom: 5),
//                 decoration: const BoxDecoration(
//                     color: Colors.black38,
//                     borderRadius: BorderRadius.all(Radius.circular(8))),
//                 height: 55,
//                 width: (MediaQuery.of(context).size.width * 0.77),
//                 child: Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Text(
//                     label,
//                     textAlign: TextAlign.start,
//                     style: const TextStyle(fontSize: 15),
//                     maxLines: 2,
//                   ),
//                 ),
//               )
//             ],
//           ),
//           Padding(
//             padding: const EdgeInsets.only(right: 8, bottom: 8),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.end,
//               children: [
//                 Builder(builder: (context) {
//                   if (showSkipButton) {
//                     return SizedBox(
//                       height: 30,
//                       child: ElevatedButton(
//                           style: TextButton.styleFrom(
//                             backgroundColor: buttonColor,
//                           ),
//                           onPressed: onSkipPressed,
//                           child: const Text('skip')),
//                     );
//                   } else {
//                     return const SizedBox();
//                   }
//                 }),
//                 const SizedBox(
//                   width: 20,
//                 ),
//                 SizedBox(
//                   height: 30,
//                   child: ElevatedButton(
//                     style: TextButton.styleFrom(backgroundColor: buttonColor),
//                     onPressed: onDonePressed,
//                     child: const Text('go'),
//                   ),
//                 ),
//               ],
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
