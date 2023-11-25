import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../model/trn_lkp_dtl/i_trn_lkp_dtl.dart';
import '../../model/trn_lkp_dtl/o_trn_lkp_dtl.dart';

class LdvList extends StatelessWidget {
  final Function(OTrnLKPDetail) onTapItem;
  const LdvList({super.key, required this.onTapItem});

  @override
  Widget build(context) => [
        // we need to listen to 2 tables: outbound & inbound
        ValueListenableBuilder<Box<OTrnLKPDetail>>(
            valueListenable: OTrnLKPDetail.listenTable(),
            builder: (context, obox, widget) {
              var obuffer = obox.values
                  // hanya tampilkan yg belum submit
                  // .where((e) => e.submitDate == null && e.expiredDate != null)
                  .toList();
              if (obuffer.isEmpty) return 'Empty Data'.text.make().objectCenter().pLTRB(8, 68, 8, 28);

              return ValueListenableBuilder<Box<ITrnLKPDetail>>(
                valueListenable: ITrnLKPDetail.listenTable(),
                builder: (context, ibox, widget) {
                  // rebuild card
                  return obuffer
                      .mapIndexed((p, idx) => LdvCardSimple(p, rowId: idx, onTapNext: onTapItem))
                      .toList()
                      .column();
                },
              );
            }),
        62.heightBox, // hardcode utk space bottomappbar
      ].column();
}

class LdvCardSimple extends StatelessWidget {
  final OTrnLKPDetail data;
  final int rowId;
  final Function(OTrnLKPDetail) onTapNext;
  const LdvCardSimple(this.data, {super.key, required this.rowId, required this.onTapNext});

  @override
  Widget build(context) {
    var inb = ITrnLKPDetail.findByPK(data.pk?.ldvNo, data.pk?.contractNo);
    // TODO look for inbound data
    return inb == null
        ? '$data'.text.make().onInkTap(() => onTapNext(data))
        : 'inbound exist for $data\n$inb'.text.make().onInkTap(() => onTapNext(data));
  }
}
