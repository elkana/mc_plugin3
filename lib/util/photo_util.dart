import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';

import '../controller/auth_controller.dart';
import '../model/mc_photo.dart';
import '../provider/baseapi.dart';
import 'commons.dart';
import 'gps_util.dart';
import 'time_util.dart';

/**

REPO(OTO) (idnya 4XX)
Foto Serah Terima Unit(FC, Debitur, & Unit)
Foto BASTBJ
Foto Tampak depan Unit
Foto Tampak belakang Unit
Foto Tampak Kanan Unit
Foto Tampak Kiri unit
Foto Interior Depan(Dashboard)
Foto Interior Belakang
Foto Mesin unit

REPO(Agri) (idnya 5XX)
Foto Serah Terima Unit(FC, Debitur, & Unit)
Foto BASTBJ
Foto Tampak depan Unit
Foto Tampak belakang Unit
Foto Tampak Kanan Unit
Foto Tampak Kiri unit
Foto Mesin unit
 */

// enum from mobile collection
enum PhotoGroup { ldv, copycontract, sp, repoVehicle, others, transfer, unknown }

// pls check with #identifyPhotoGroup
enum PhotoType {
  ldvCollAndDebitur,
  // ldvFrontHouse, udah ada PoA
  ldvFrontNeighbour,
  // lupa knp ldvSpjb pernah disable ya ?
  ldvSpjb,
  ldvReceipt,
  ccSigned,
  ccCollAndDebitur,
  // ccFrontHouse, udah ada PoA
  ccNeighbour,
  spTTTTD,

  // per 30 oct 2020 masih draft berubah2
  repoPoA,
  repoDebiturAndVehicle,
  repoFrontVehicle,
  repoSideLeftVehicle,
  repoSideRightVehicle,
  repoInteriorFrontVehicle,
  repoInteriorBackVehicle,
  repoBastkVehicle,

  transferBill,

  otherUnit
}

extension PhotoTypeExtension on PhotoType {
  static const photoIds = {
    PhotoType.ldvCollAndDebitur: 101,
    PhotoType.ldvFrontNeighbour: 103,
    PhotoType.ldvSpjb: 104,
    PhotoType.ldvReceipt: 109,
    PhotoType.ccSigned: 201,
    PhotoType.ccCollAndDebitur: 202,
    PhotoType.ccNeighbour: 204,
    PhotoType.spTTTTD: 301,
    PhotoType.repoPoA: 401,
    PhotoType.repoDebiturAndVehicle: 402,
    PhotoType.repoFrontVehicle: 403,
    PhotoType.repoSideLeftVehicle: 404,
    PhotoType.repoSideRightVehicle: 405,
    PhotoType.repoInteriorFrontVehicle: 406,
    PhotoType.repoBastkVehicle: 407,
    PhotoType.repoInteriorBackVehicle: 408,
    PhotoType.otherUnit: 701,
    PhotoType.transferBill: 801,
  };

  int? get photoId => photoIds[this];

  static const photoLabels = {
    PhotoType.ldvCollAndDebitur: 'Collector & Debitur',
    // PhotoType.ldvFrontHouse: 'Depan Rumah',
    PhotoType.ldvFrontNeighbour: 'Sebrang Rumah',
    PhotoType.ldvSpjb: 'SPJB',
    PhotoType.ldvReceipt: 'Struk Tercetak',
    PhotoType.ccSigned: 'Tanda Terima CC sudah di TTD',
    PhotoType.ccCollAndDebitur: 'Collector & Debitur',
    // PhotoType.ccFrontHouse: 'Tampak Depan Rumah',
    PhotoType.ccNeighbour: 'Sebrang Rumah',
    PhotoType.spTTTTD: 'Tanda Terima SP sudah di TTD',
    PhotoType.repoPoA: 'Kunjungan',
    PhotoType.repoDebiturAndVehicle: 'Debitur & Kendaraan',
    PhotoType.repoFrontVehicle: 'Tampak Depan',
    PhotoType.repoSideLeftVehicle: 'Samping Kiri',
    PhotoType.repoSideRightVehicle: 'Samping Kanan',
    PhotoType.repoInteriorFrontVehicle: 'Interior Depan',
    PhotoType.repoInteriorBackVehicle: 'Interior Belakang',
    PhotoType.repoBastkVehicle: 'BASTK',
    PhotoType.transferBill: 'Bukti Transfer',
    PhotoType.otherUnit: 'Unit',
  };

  String? get photoLabel => photoLabels[this];

// in trn_photo, fileKey is identified as photoId
  static const fileKeys = {
    PhotoType.ldvCollAndDebitur: 'foto_ldv_coll_and_debitur',
    PhotoType.ldvFrontNeighbour: 'foto_ldv_sebrang_rumah',
    PhotoType.ldvSpjb: 'foto_ldv_spjb',
    PhotoType.ldvReceipt: 'foto_struk',
    PhotoType.ccSigned: 'foto_cc_tt_ttd',
    PhotoType.ccCollAndDebitur: 'foto_cc_coll_and_debitur',
    PhotoType.ccNeighbour: 'foto_cc_sebrang_rmh',
    PhotoType.spTTTTD: 'foto_sp_tt_ttd',
    PhotoType.repoPoA: 'foto_poa',
    PhotoType.repoDebiturAndVehicle: 'foto_repo_vhcl_debitur',
    PhotoType.repoFrontVehicle: 'foto_repo_depan',
    PhotoType.repoSideLeftVehicle: 'foto_repo_kiri',
    PhotoType.repoSideRightVehicle: 'foto_repo_kanan',
    PhotoType.repoInteriorFrontVehicle: 'foto_repo_interior_front',
    PhotoType.repoInteriorBackVehicle: 'foto_repo_interior_back',
    PhotoType.repoBastkVehicle: 'foto_repo_bastk',
    PhotoType.transferBill: 'foto_transfer',
    PhotoType.otherUnit: 'foto_unit',
  };

  String? get fileKey => fileKeys[this];

  static const icons = {
    PhotoType.ldvCollAndDebitur: Icons.supervisor_account,
    PhotoType.ldvFrontNeighbour: Icons.home,
    PhotoType.ldvSpjb: Icons.description,
    PhotoType.ldvReceipt: Icons.receipt_long_rounded,
    PhotoType.ccSigned: Icons.description,
    PhotoType.ccCollAndDebitur: Icons.supervisor_account,
    PhotoType.ccNeighbour: Icons.home,
    PhotoType.spTTTTD: Icons.description,
    PhotoType.repoPoA: Icons.home,
    PhotoType.repoDebiturAndVehicle: Icons.directions_car_outlined,
    PhotoType.repoFrontVehicle: Icons.directions_car_outlined,
    PhotoType.repoSideLeftVehicle: Icons.directions_car_outlined,
    PhotoType.repoSideRightVehicle: Icons.directions_car_outlined,
    PhotoType.repoInteriorFrontVehicle: Icons.directions_car_outlined,
    PhotoType.repoInteriorBackVehicle: Icons.directions_car_outlined,
    PhotoType.repoBastkVehicle: Icons.description,
    PhotoType.transferBill: Icons.description,
    PhotoType.otherUnit: Icons.enhance_photo_translate_outlined,
  };

  IconData? get icon => icons[this];
}

class PhotoUtil {
  static List<PhotoType> getPhotoTypesOfGroup(PhotoGroup group) {
    List<PhotoType> list = [];
    if (group == PhotoGroup.ldv) {
      list.add(PhotoType.ldvCollAndDebitur);
      // _list.add(PhotoType.ldvFrontHouse);
      list.add(PhotoType.ldvFrontNeighbour);
      list.add(PhotoType.ldvSpjb);
      list.add(PhotoType.ldvReceipt);
    } else if (group == PhotoGroup.sp) {
      list.add(PhotoType.spTTTTD);
    } else if (group == PhotoGroup.copycontract) {
      list.add(PhotoType.ccCollAndDebitur);
      // _list.add(PhotoType.ccFrontHouse);
      list.add(PhotoType.ccNeighbour);
      list.add(PhotoType.ccSigned);
    } else if (group == PhotoGroup.repoVehicle) {
      list.add(PhotoType.repoPoA);
      list.add(PhotoType.repoDebiturAndVehicle);
      list.add(PhotoType.repoFrontVehicle);
      list.add(PhotoType.repoSideLeftVehicle);
      list.add(PhotoType.repoSideRightVehicle);
      list.add(PhotoType.repoInteriorFrontVehicle);
      list.add(PhotoType.repoInteriorBackVehicle);
      list.add(PhotoType.repoBastkVehicle);
    } else if (group == PhotoGroup.others) {
      list.add(PhotoType.otherUnit);
    } else if (group == PhotoGroup.transfer) {
      list.add(PhotoType.transferBill);
    } else {
      throw Exception('unhandled group $group');
    }

    return list;
  }

  static PhotoGroup identifyPhotoGroup(PhotoType photoType) {
    if (photoType == PhotoType.spTTTTD) {
      return PhotoGroup.sp;
    } else if (photoType == PhotoType.ldvCollAndDebitur ||
        // photoType == PhotoType.ldvFrontHouse ||
        photoType == PhotoType.ldvSpjb ||
        photoType == PhotoType.ldvFrontNeighbour ||
        photoType == PhotoType.ldvReceipt) {
      return PhotoGroup.ldv;
    } else if (photoType == PhotoType.ccCollAndDebitur ||
        // photoType == PhotoType.ccFrontHouse ||
        photoType == PhotoType.ccNeighbour ||
        photoType == PhotoType.ccSigned) {
      return PhotoGroup.copycontract;
    } else if (photoType == PhotoType.repoPoA ||
        photoType == PhotoType.repoDebiturAndVehicle ||
        photoType == PhotoType.repoFrontVehicle ||
        photoType == PhotoType.repoSideLeftVehicle ||
        photoType == PhotoType.repoSideRightVehicle ||
        photoType == PhotoType.repoInteriorFrontVehicle ||
        photoType == PhotoType.repoInteriorBackVehicle ||
        photoType == PhotoType.repoBastkVehicle) {
      return PhotoGroup.repoVehicle;
    } else if (photoType == PhotoType.otherUnit) {
      return PhotoGroup.others;
    } else if (photoType == PhotoType.transferBill) {
      return PhotoGroup.transfer;
    } else {
      return PhotoGroup.unknown;
    }
  }

  // for web as Uint8List
  // for mobile as File
  static Future<XFile?> takePhotoGeneric() async {
    int photoQuality = 40;
    //await ConfigUtil.getPhotoQuality();
    double maxWidth = 1080;
    //await ConfigUtil.getPhotoMaxWidth();
    final xFile = await ImagePicker().pickImage(
        source: ImageSource.camera, imageQuality: photoQuality, maxHeight: maxWidth + 200, maxWidth: maxWidth);
    if (xFile == null) return null;
    return xFile;
  }

  static List<PhotoType> get collateralsGroup =>
      PhotoType.values.where((e) => e.photoId! > 401 && e.photoId! < 500).toList();

  // static String? getPoALink(String? sktNo, String userId, {String? orElseUseBlobPath}) {
  //   try {
  //     TblPhoto? local = sktNo == null ? null : TblPhoto.findPoABy(sktNo);
  //     if (local != null) {
  //       if (!Utility.isEmpty(local.blobPath)) {
  //         log('poalink using local ${local.blobPath}');
  //         return local.blobPath;
  //       } else {
  //         var url = '${BaseApi.imageUri}skt/${local.id}.jpg';
  //         log('poalink using web $url');
  //         return url;
  //       }
  //     } else if (orElseUseBlobPath != null) {
  //       // udah pasti ada di local
  //       return orElseUseBlobPath;
  //     }
  //     // bisa juga retrieve by skt no
  //     var url = '${BaseApi.imageUri}skt_by/$userId/${PhotoType.repoPoA.fileKey}.jpg?source_id=$sktNo';
  //     log('poalink using web $url');
  //     return url;
  //   } catch (e) {
  //     return null;
  //   }
  // }

  // static String? getVisitLink(String? sktNo, String visitId, String userId, {String? orElseUseBlobPath}) {
  //   try {
  //     TblPhoto? local = sktNo == null ? null : TblPhoto.findPoABy(concatVisitIdWithSktNo(sktNo, visitId));
  //     if (local != null) {
  //       if (!Utility.isEmpty(local.blobPath)) {
  //         log('visitlink using local ${local.blobPath}');
  //         return local.blobPath;
  //       } else {
  //         var url = '${BaseApi.imageUri}skt/${local.id}.jpg';
  //         log('visitlink using web $url');
  //         return url;
  //       }
  //     } else if (orElseUseBlobPath != null) {
  //       // udah pasti ada di local
  //       return orElseUseBlobPath;
  //     }
  //     // bisa juga retrieve by skt no
  //     var url = '${BaseApi.imageUri}skt_by/$userId/${PhotoType.repoPoA.fileKey}.jpg?source_id=$sktNo';
  //     log('visitlink using web $url');
  //     return url;
  //   } catch (e) {
  //     return null;
  //   }
  // }

  static String? getLink(String imageUri, String? ldvNo, String? photoKey, {String? orElseUseBlobPath}) {
    if (ldvNo == null || photoKey == null) return null;
    try {
      var local = TrnPhoto().findBy(ldvNo, photoKey, AuthController.instance.loggedUserId);
      if (local != null) {
        if (!Utility.isEmpty(local.blobPath)) {
          return local.blobPath;
        } else {
          var url = '$imageUri/contract/${local.id}.jpg'; // uploaded
          log('collink ($photoKey) using web -> $url');
          return url;
        }
        // if (_local.fileName.contains('/')) return _local.fileName; // if android
      } else if (orElseUseBlobPath != null) {
        // udah pasti ada di local
        return orElseUseBlobPath;
      }
      // bisa juga retrieve by ldv no
      var url = '$imageUri/ldv_by/${AuthController.instance.loggedUserId}/$photoKey.jpg?source_id=$ldvNo';
      log('collink using web $url');
      return url;
    } catch (e) {
      return null;
    }
  }

  /// not a real table, just return variable to store more information
  static Future<TrnPhoto> xFileToPhoto(XFile file, PhotoType pt, String sourceId, String contractNo) async {
    var gps = await GpsUtil.currentLocationInForeground;
    var loggedUser = AuthController.instance.loggedUser!;
    var tblPhoto = TrnPhoto(sourceId: sourceId, photoId: pt.fileKey!, fileName: file.name)
      ..blobPath = file.path
      ..label = pt.photoLabel
      // ..label = PhotoType.repoPoA.photoLabel
      ..userId = loggedUser.userId
      ..officeId = loggedUser.branchId
      ..contractNo = contractNo
      ..mimeType = lookupMimeType(file.name)
      ..latitude = gps.latitude.toString()
      ..longitude = gps.longitude.toString();

    return tblPhoto;
  }

  // static Future<TblPhoto?> saveAsPoA(XFile file, String sktNo, String contractNo) async {
  //   var gps = await GpsUtil.getCurrentLocationInForeground();
  //   var loggedUser = AuthController.instance.loggedUser!;
  //   var tblPhoto = TblPhoto(
  //       sourceId: sktNo, // <-- using sktNo as source_id
  //       photoId: PhotoType.repoPoA.fileKey!,
  //       fileName: file.name)
  //     ..blobPath = file.path
  //     ..label = PhotoType.repoPoA.photoLabel
  //     ..userId = loggedUser.userId
  //     ..officeId = loggedUser.branchId
  //     ..contractNo = contractNo
  //     ..mimeType = lookupMimeType(file.name)
  //     ..latitude = gps.latitude.toString()
  //     ..longitude = gps.longitude.toString();

  //   await TblPhoto.deleteData(TblPhoto.findPoABy(sktNo));
  //   await TblPhoto.saveOrUpdate(tblPhoto);
  //   return tblPhoto;
  // }

  // static Future<TblPhoto?> saveAsCollateral(
  //     PhotoType pt, XFile file, String sktNo, String collateralNo, String contractNo) async {
  //   var gps = await GpsUtil.getCurrentLocationInForeground();
  //   var loggedUser = AuthController.instance.loggedUser!;
  //   var tblPhoto = TblPhoto(
  //       sourceId: '${sktNo}_$collateralNo', // <-- using concat sktNo_collateralNo as source_id
  //       photoId: pt.fileKey!,
  //       fileName: file.name)
  //     ..blobPath = file.path
  //     ..label = pt.photoLabel
  //     ..userId = loggedUser.userId
  //     ..officeId = loggedUser.branchId
  //     ..contractNo = contractNo
  //     ..mimeType = lookupMimeType(file.name) //file.mimeType
  //     ..latitude = gps.latitude.toString()
  //     ..longitude = gps.longitude.toString();

  //   await TblPhoto.deleteData(TblPhoto.findCollateralBy(sktNo, collateralNo, pt.fileKey!, loggedUser.userId!));
  //   await TblPhoto.saveOrUpdate(tblPhoto);
  //   return tblPhoto;
  // }

  static String concatVisitIdWithSktNo(String sktNo, String visitId) => '${sktNo}_$visitId';

  /// visit20230310183559
  static String generateVisitId() => 'visit${TimeUtil.convertMillis2YYYYMMDDHHMMSS(null)}';

  /// sourceId = SKT123/3839/VII/23_visit20230310183559
  /// return visit20230310183559
  static String getVisitId(String sourceId) {
    int idx = sourceId.indexOf('_visit');
    if (idx < 0) return '';
//     print('idx=$idx');
//     print(sourceId.substring(idx+1));
    return sourceId.substring(idx + 1);
  }
}
