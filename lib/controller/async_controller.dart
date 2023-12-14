import '../provider/api.dart';
import 'abasic_controller.dart';

abstract class ASyncController extends ABasicController {
  Future get sync async {
    await Api.instance.setBatch();
  }
}
