import 'package:bunche/src/data/models/qrcode/qrcode.dart';
import 'package:bunche/src/data/models/qrcode_list.dart';
import 'package:get_it/get_it.dart';

class QrcodeDetailViewModel {
  QrcodeList qrcodeList = GetIt.instance.get<QrcodeList>();
  // late final String qrcodeId;
  late final QRCode qrcodeInstance;

  QrcodeDetailViewModel({required this.qrcodeInstance}) {
    // tryToFetchQrcode(qrcodeId);
  }
}
