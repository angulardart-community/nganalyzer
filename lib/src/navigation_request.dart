import 'package:analyzer/file_system/file_system.dart';
import 'package:analyzer_plugin/utilities/navigation/navigation.dart';
import 'angular_driver.dart';

class AngularNavigationRequest extends NavigationRequest {
  @override
  final String path;
  @override
  final int length;
  @override
  final int offset;
  final DirectivesResult result;

  AngularNavigationRequest(this.path, this.length, this.offset, this.result);

  @override
  ResourceProvider get resourceProvider => null;
}
