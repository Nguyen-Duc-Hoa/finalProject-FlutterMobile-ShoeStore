
import 'package:finalprojectmobile/common.dart';

class Voucher{
  final String? voucherId;
  final String? voucherName;
  final num? voucherValue;
  final DateTime? startDate;
  final DateTime? endDate;
  Voucher({this.voucherId, this.voucherName, this.voucherValue,this.startDate, this.endDate});

}
Voucher bronzeVoucher= Voucher(voucherId: 'BRONZE',voucherName: 'Giảm 100k cho toàn bộ đơn hàng',voucherValue:100000,startDate: null,endDate: null );
Voucher silverVoucher= Voucher(voucherId: 'SILVER',voucherName: 'Giảm 150k cho toàn bộ đơn hàng',voucherValue:150000,startDate: null,endDate: null );
Voucher goldVoucher= Voucher(voucherId: 'VCGOLD',voucherName: 'Giảm 200k cho toàn bộ đơn hàng',voucherValue:200000,startDate: null,endDate: null );
Voucher diamondVoucher= Voucher(voucherId: 'DIAMON',voucherName: 'Giảm 400k cho toàn bộ đơn hàng',voucherValue:400000,startDate: null,endDate: null );
