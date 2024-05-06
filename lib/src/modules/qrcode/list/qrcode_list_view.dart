// import 'package:bunche/src/common/components/card_qrcode.dart';
// import 'package:bunche/src/data/models/qrcode/qrcode.dart';
// import 'package:flutter/material.dart';

// class QrcodeListView extends StatelessWidget {
//   const QrcodeListView({super.key, required this.qrcodes, this.isEdit = false});

//   final List<QRCode> qrcodes;
//   final bool? isEdit;

//   @override
//   Widget build(BuildContext context) {
//     // _friendViewModel.qrcodes = qrcodes;
//     return Container(
//       padding: const EdgeInsets.all(20),
//       width: double.infinity,
//       child: ListView.builder(
//           itemCount: qrcodes.length,
//           itemBuilder: (context, index) {
//             if (qrcodes.isEmpty) {
//               return const Center(
//                 child: Text('No QR Codes'),
//               );
//             }
//             return CardQrcode(
//               isEdit: isEdit,
//               accountName: qrcodes[index].accountName,
//               qrCode: qrcodes[index].qrCodeImage,
//               index: index,
//               deleteQRCode: (int index) {},
//               qrcodeId: '',
//             );
//           }),
//     );
//   }
// }

// // // import 'package:bunche/src/data/models/qrcode/qrcode.dart';
// // // import 'package:bunche/src/common/components/card_qrcode.dart';
// // // import 'package:flutter/material.dart';

// // // class QrcodeListPreview extends StatelessWidget {
// // //   const QrcodeListPreview({super.key, required this.qrcodes, this.isEdit});
// // //   final List<QRCodeHive> qrcodes;
// // //   final bool? isEdit;

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     // _friendViewModel.qrcodes = qrcodes;
// // //     return Container(
// // //       padding: const EdgeInsets.all(20),
// // //       width: double.infinity,
// // //       child: ListView.builder(
// // //           itemCount: qrcodes.length,
// // //           itemBuilder: (context, index) {
// // //             if (qrcodes.isEmpty) {
// // //               return const Center(
// // //                 child: Text('No QR Codes'),
// // //               );
// // //             }
// // //             return CardQrcode(
// // //               isEdit: isEdit,
// // //               accountName: qrcodes[index].accountName,
// // //               qrCode: qrcodes[index].qrCodeImage,
// // //               index: index,
// // //             );
// // //           }),
// // //     );
// // //   }
// // // }
