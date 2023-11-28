import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../model/trn_ldv_dtl/i_trn_ldv_dtl.dart';
import '../../model/trn_ldv_dtl/o_trn_ldv_dtl.dart';

class LdvList extends StatelessWidget {
  final Function(OTrnLdvDetail) onTapItem;
  const LdvList({super.key, required this.onTapItem});

  @override
  Widget build(context) => [
        // we need to listen to 2 tables: outbound & inbound
        ValueListenableBuilder<Box<OTrnLdvDetail>>(
            valueListenable: OTrnLdvDetail().listenTable,
            builder: (context, obox, widget) {
              var obuffer = obox.values
                  // hanya tampilkan yg belum submit
                  // .where((e) => e.submitDate == null && e.expiredDate != null)
                  .toList();
              if (obuffer.isEmpty) return 'Empty Data'.text.make().objectCenter().pLTRB(8, 68, 8, 28);

              return ValueListenableBuilder<Box<ITrnLdvDetail>>(
                valueListenable: ITrnLdvDetail().listenTable,
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
  final OTrnLdvDetail data;
  final int rowId;
  final Function(OTrnLdvDetail) onTapNext;
  const LdvCardSimple(this.data, {super.key, required this.rowId, required this.onTapNext});

  @override
  Widget build(context) {
    var inb = ITrnLdvDetail().findByPk(data.pk!.ldvNo!, data.pk!.contractNo!);
    // TODO look for inbound data
    return inb == null
        ? '$data'.text.make().onInkTap(() => onTapNext(data))
        : 'inbound exist for $data\n$inb'.text.make().onInkTap(() => onTapNext(data));
  }
}
