// ignore_for_file: unused_import, unnecessary_import
// image_picker: 0.8.4+2
import 'dart:io';
import 'dart:typed_data';
// please reimport 'dart:typed_data'; sometimes vscode delete by itself
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../util/commons.dart';
import 'package:velocity_x/velocity_x.dart';

/// what if blob:http doesnt work ? cek kambali uidnya, biasanya ga bisa bedain file fisik dgn di cloud. kalau ada di cloud harusnya udah bukan blob lagi.
class PhotoFrame extends StatefulWidget {
  final String? label;
  // 'https://picsum.photos/80/100'
  final String? urlOrFile;
  final Future Function(XFile)? onPickPhoto;
  final Widget? emptyThumbnail;
  final bool disable;
  final bool showCheck;
  const PhotoFrame({
    Key? key,
    this.label,
    this.urlOrFile,
    this.onPickPhoto,
    this.disable = false,
    this.emptyThumbnail,
    this.showCheck = false,
  }) : super(key: key);

  @override
  State<PhotoFrame> createState() => _PhotoFrameState();
}

class _PhotoFrameState extends State<PhotoFrame> {
  var loading = false;

  @override
  Widget build(context) => [
        '${widget.label}'.selectableText.xs.center.bold.make().p8().hide(isVisible: widget.label != null),
        '${widget.urlOrFile}'.selectableText.size(6).make().hide(isVisible: kDebugMode),
        [
          FittedBox(
              fit: BoxFit.fill,
              child: (widget.urlOrFile == null || widget.urlOrFile!.isEmpty
                  ? (loading
                          ? const CircularProgressIndicator()
                          : (widget.emptyThumbnail ?? const Icon(Icons.image_outlined)))
                      .p12()
                  : widget.urlOrFile!.isUrl
                      ? [
                          ConstrainedBox(
                              constraints: const BoxConstraints(minWidth: 1, minHeight: 1),
                              child: Image.network(widget.urlOrFile!, errorBuilder: (ctx, exception, stackTrace) {
                                //2mar23, di mobile bisa exception 'Handshake error in client' jika pake https yg ssl dummy. trik lain didownload ke cache.
                                // https://stackoverflow.com/questions/49853006/trying-to-load-an-image-using-networkimage-fails-with-certificate-verify-failed/51081238#51081238
                                debugPrint('Invalid Photo Web ${widget.urlOrFile}');
                                return widget.emptyThumbnail ?? const Icon(Icons.image_outlined);
                              }, loadingBuilder: (context, child, loadingProgress) {
                                if (loadingProgress == null) return child;
                                return CircularProgressIndicator(
                                        value: loadingProgress.expectedTotalBytes != null
                                            ? loadingProgress.cumulativeBytesLoaded /
                                                loadingProgress.expectedTotalBytes!
                                            : null)
                                    .centered();
                              })),
                          // Icon(
                          //   Icons.check_circle,
                          //   color: Colors.green.shade500,
                          //   size: 30,
                          // ).hide(isVisible: ignore),
                        ].stack(fit: StackFit.passthrough, alignment: Alignment.topRight)
                      : widget.urlOrFile!.startsWith('blob') || widget.urlOrFile!.startsWith('https')
                          // please reimport 'dart:typed_data'; when using Uint8List. sometimes vscode delete by itself
                          ? FutureBuilder<Uint8List>(
                              future: XFile(widget.urlOrFile!).readAsBytes(),
                              builder: (context, snapshot) {
                                if (!snapshot.hasData) {
                                  return '...'.text.makeCentered();
                                }
                                log('FotoFrame ${widget.label} using memory for ${widget.urlOrFile}, because isURL=${widget.urlOrFile!.isUrl}');
                                return [
                                  ConstrainedBox(
                                      constraints: const BoxConstraints(minWidth: 1, minHeight: 1),
                                      child: Image.memory(snapshot.data!, errorBuilder: (ctx, exception, stackTrace) {
                                        debugPrint('Invalid Photo Blob ${widget.urlOrFile}');
                                        return const Placeholder();
                                      })),
                                  // Icon(
                                  //   Icons.check_circle,
                                  //   color: Colors.green.shade500,
                                  //   size: 30,
                                  // ),
                                ].stack(
                                    fit: StackFit.passthrough,
                                    alignment: Alignment.topRight); // must passthrough to show icon
                              })
                          : ConstrainedBox(
                              constraints: const BoxConstraints(minWidth: 1, minHeight: 1),
                              child: Image.file(File(widget.urlOrFile!), errorBuilder: (ctx, exception, stackTrace) {
                                debugPrint('Invalid Photo File ${widget.urlOrFile}');
                                return const Placeholder();
                              })))),
          Icon(Icons.check_circle, color: Colors.green.shade500, size: 30)
              .objectTopRight()
              .hide(isVisible: widget.showCheck)
        ].stack(fit: StackFit.passthrough).expand(),
        MaterialButton(
                onPressed: () async {
                  if (widget.onPickPhoto == null) {
                    debugPrint('WARNING, you need to apply onPickPhoto.');
                    return;
                  }
                  if (loading) return;
                  int photoQuality = 40;
                  double maxWidth = 1080;
                  final xFile = await ImagePicker().pickImage(
                      source: ImageSource.camera,
                      imageQuality: photoQuality,
                      maxHeight: maxWidth + 200,
                      maxWidth: maxWidth);
                  if (xFile == null) return;
                  setState(() => loading = true);
                  try {
                    await widget.onPickPhoto!(xFile);
                  } catch (e, s) {
                    showError(e.toString(), stacktrace: s);
                  } finally {
                    await 1.delay();
                    setState(() => loading = false);
                  }
                },
                color: Colors.indigo,
                child: '+'.text.xl.bold.white.make())
            .wFull(context)
            .hide(isVisible: !widget.disable)
      ].column().onTap(() async {
        if (widget.disable || widget.urlOrFile == null || widget.urlOrFile!.isEmpty) {
          log('ignoring tap (disable=${widget.disable}, urlOrFile=${widget.urlOrFile})');
          return;
        }
        Navigator.push(
            context,
            PageRouteBuilder(
                opaque: false,
                barrierColor: Get.isDarkMode ? Colors.black : Colors.white,
                pageBuilder: (context, _, __) => Scaffold(
                    body: (widget.urlOrFile!.isUrl
                            ? Image.network(widget.urlOrFile!,
                                fit: BoxFit.cover,
                                height: double.infinity,
                                width: double.infinity,
                                alignment: Alignment.center)
                            : widget.urlOrFile!.startsWith('blob')
                                ? FutureBuilder<Uint8List>(
                                    future: XFile(widget.urlOrFile!).readAsBytes(),
                                    builder: (context, snapshot) {
                                      if (!snapshot.hasData) {
                                        return '__'.text.makeCentered();
                                      }
                                      return ConstrainedBox(
                                          constraints: const BoxConstraints(minWidth: 1, minHeight: 1),
                                          child:
                                              Image.memory(snapshot.data!, errorBuilder: (ctx, exception, stackTrace) {
                                            debugPrint('Invalid Photo Blob ${widget.urlOrFile}');
                                            return const Placeholder();
                                          }));
                                    })
                                : Image.file(File(widget.urlOrFile!),
                                    fit: BoxFit.cover,
                                    height: double.infinity,
                                    width: double.infinity,
                                    alignment: Alignment.center))
                        .onTap(() => Navigator.pop(context)))));
      });
}
