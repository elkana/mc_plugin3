class Constants {
  Constants._();

  static const uriUploadFoto = '/matel/media/v1/upload_foto';
  static const uriUploadFotoCollateral = '/matel/media/v1/upload_foto_collateral';
  static const uriUploadAvatar = '/matel/media/v1/upload_avatar';

  static const valueSuccess = 'SUCCESS';
  static const valueFailed = 'FAILED';
  static const valueStop = 'STOP';
  static final optionsRepoStatus = [
    '',
    'SUCCESS REPO',
    'SUCCESS CURRENT',
    'SUCCESS ET',
    'FAILED'
  ]; // blank dianggap tidak input apa2
  static final optionsRepoExtend = [
    '',
    'EXTENDED',
    valueStop,
  ]; // blank dianggap tidak input apa2
}
