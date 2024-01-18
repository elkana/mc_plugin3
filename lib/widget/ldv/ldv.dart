import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mc_plugin3/model/mc_trn_rvcollcomment.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../model/trn_ldv_dtl/i_trn_ldv_dtl.dart';
import '../../model/trn_ldv_dtl/o_trn_ldv_dtl.dart';
import '../../model/trn_ldv_hdr.dart';

class LdvHeader extends StatelessWidget {
  final Widget Function(OutboundLdvHeader, InboundLdvHeader?) onRender;
  const LdvHeader({super.key, required this.onRender});

  @override
  Widget build(context) => ValueListenableBuilder<Box<OutboundLdvHeader>>(
      valueListenable: OutboundLdvHeader().listenTable,
      builder: (context, obox, widget) {
        var o = obox.values.toList();
        if (o.isEmpty) return 'Tidak ada outbound LKP'.text.make();

        return ValueListenableBuilder<Box<InboundLdvHeader>>(
            valueListenable: InboundLdvHeader().listenTable,
            builder: (context, ibox, widget) {
              var i = ibox.values.toList();
              if (i.isEmpty) return onRender(o.first, null);
              return ibox.values.mapIndexed((p, idx) => onRender(o.first, p)).toList().column();
            });
      });
}

class LdvList extends StatelessWidget {
  final Function(OutboundLdvDetail) onTapItem;
  const LdvList({super.key, required this.onTapItem});

  @override
  Widget build(context) => [
        // we need to listen to 2 tables: outbound & inbound
        ValueListenableBuilder<Box<OutboundLdvDetail>>(
            valueListenable: OutboundLdvDetail().listenTable,
            builder: (context, obox, widget) {
              var o = obox.values
                  // hanya tampilkan yg belum submit
                  // .where((e) => e.submitDate == null && e.expiredDate != null)
                  .toList();
              if (o.isEmpty) return 'Empty Data'.text.make().objectCenter().pLTRB(8, 68, 8, 28);

              return ValueListenableBuilder<Box<InboundLdvDetail>>(
                  valueListenable: InboundLdvDetail().listenTable,
                  builder: (context, ibox, widget) => o
                      .mapIndexed((p, idx) => LdvCardSimple(p, rowId: idx, onTapNext: onTapItem).p8())
                      .toList()
                      .column());
            }),
        62.heightBox, // hardcode utk space bottomappbar
      ].column();
}

class LdvCardSimple extends StatelessWidget {
  final OutboundLdvDetail data;
  final int rowId;
  final Function(OutboundLdvDetail) onTapNext;
  const LdvCardSimple(this.data, {super.key, required this.rowId, required this.onTapNext});

  @override
  Widget build(context) {
    var inb = InboundLdvDetail().findByPk(data.pk!.ldvNo!, data.pk!.contractNo!);
    // TODO look for inbound data
    return inb == null
        ? '$data'.text.make().onInkTap(() => onTapNext(data))
        : 'inbound exist for $data\n$inb'.text.make().onInkTap(() => onTapNext(data));
  }
}

class OTrnLdvDetailList extends StatelessWidget {
  final bool removeVisited;
  final Widget Function(OutboundLdvDetail) onRender;
  const OTrnLdvDetailList({super.key, this.removeVisited = false, required this.onRender});

  @override
  Widget build(context) => ValueListenableBuilder<Box<OutboundLdvDetail>>(
      valueListenable: OutboundLdvDetail().listenTable,
      builder: (context, obox, widget) {
        var o = obox.values
            // hanya tampilkan yg belum submit, caranya jika ada di inbound brarti sdh diinput
            .where((e) => removeVisited && InboundLdvDetail().findByPk(e.pk!.ldvNo!, e.pk!.contractNo!) == null)
            .toList();
        if (o.isEmpty) return 'Empty Data'.text.make().objectCenter().pLTRB(8, 68, 8, 28);

        return o.mapIndexed((p, idx) => onRender(p)).toList().column();
      });
}

class ITrnLdvDetailList extends StatelessWidget {
  final Widget Function(InboundLdvDetail contract, TrnRVCollComment? visitForm) onRender;
  const ITrnLdvDetailList({super.key, required this.onRender});

  @override
  Widget build(context) => ValueListenableBuilder<Box<InboundLdvDetail>>(
      valueListenable: InboundLdvDetail().listenTable,
      builder: (context, obox, widget) {
        var i = obox.values.toList();
        if (i.isEmpty) return 'Empty Data'.text.make().objectCenter().pLTRB(8, 68, 8, 28);

        return i
            .mapIndexed((p, idx) {
              var r = TrnRVCollComment().findByContractNo(p.pk!.contractNo);
              return onRender(p, r);
            })
            .toList()
            .column();
      });
}

class PleaseCloseBatch extends StatelessWidget {
  const PleaseCloseBatch({super.key});

  @override
  Widget build(context) => ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(backgroundColor: Colors.red, elevation: 2),
      child: 'Please Close Batch !'.text.make());
}
