import 'package:analyzer/dart/element/element.dart';
import '../model.dart';
import '../summary/idl.dart';

/// Common behavior between [EagerLinker] and [LazyLinker].
///
/// To be used with the top-level linking methods [linkPipe], [likePipes],
/// [linkTopLevel], and [linkTopLevels].
abstract class TopLevelLinker {
  AnnotatedClass annotatedClass(
      SummarizedClassAnnotations classSum, ClassElement classElement);
  Component component(SummarizedDirective dirSum, ClassElement classElement);
  Directive directive(SummarizedDirective dirSum, ClassElement classElement);
  FunctionalDirective functionalDirective(
      SummarizedDirective dirSum, FunctionElement functionElement);
  Pipe pipe(SummarizedPipe pipeSum, ClassElement classElement);
}
