import 'package:analyzer/dart/element/element.dart' as dart;
import 'package:analyzer/source/source_range.dart';
import 'package:analyzer/src/generated/source.dart';

import '../navigable.dart';

/// A [Navigable] location in the code representing a [dart.Element].
class DartElement implements Navigable {
  final dart.Element element;

  @override
  final SourceRange navigationRange;

  DartElement(this.element)
      : navigationRange = SourceRange(element.nameOffset, element.nameLength);

  @override
  Source get source => element.source;
}
