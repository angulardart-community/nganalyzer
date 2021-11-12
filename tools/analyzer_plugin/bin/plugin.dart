import 'dart:isolate';

import 'package:nganalyzer/starter.dart' as plugin;

void main(List<String> args, SendPort sendPort) {
	plugin.start(args, sendPort);
}