import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/error/listener.dart';
import 'package:analyzer/source/source_range.dart';
import 'package:analyzer/src/generated/source.dart' show SourceRange;
import '../ignoring_error_listener.dart';
import 'directive_provider.dart';
import 'eager_linker.dart';
import 'link.dart';
import 'top_level_linker.dart';
import '../model.dart';
import '../model/lazy/component.dart' as lazy;
import '../model/lazy/directive.dart' as lazy;
import '../model/lazy/pipe.dart' as lazy;
import '../selector.dart';
import '../selector/element_name_selector.dart';
import '../standard_components.dart';
import '../summary/idl.dart';

/// Lazily link+resolve summaries into the resolved model.
///
/// This improves performance, especially when users use lists of directives
/// for convenience which would otherwise trigger a lot of potentially deep
/// analyses.
///
/// You cannot get linker errors from this approach because they are not
/// guaranteed to be calculated.
class LazyLinker implements TopLevelLinker {
  final EagerLinker _eagerLinker;

  LazyLinker(StandardAngular standardAngular, StandardHtml standardHtml,
      DirectiveProvider directiveProvider)
      : _eagerLinker = EagerLinker(
            standardAngular,
            standardHtml,
            ErrorReporter(
                IgnoringErrorListener(), standardAngular.component.source),
            directiveProvider);

  @override
  AnnotatedClass annotatedClass(
          SummarizedClassAnnotations classSum, ClassElement classElement) =>
      _eagerLinker.annotatedClass(classSum, classElement);

  @override
  Component component(SummarizedDirective dirSum, ClassElement classElement) {
    assert(dirSum.functionName == "");
    assert(dirSum.isComponent);

    final source = classElement.source;
    final selector =
        SelectorParser(source, dirSum.selectorOffset, dirSum.selectorStr)
            .parse();
    final elementTags = <ElementNameSelector>[];
    selector.recordElementNameSelectors(elementTags);

    return lazy.Component(
        selector, source, () => _eagerLinker.component(dirSum, classElement))
      ..classElement = classElement;
  }

  @override
  Directive directive(SummarizedDirective dirSum, ClassElement classElement) {
    assert(dirSum.functionName == "");
    assert(!dirSum.isComponent);

    final source = classElement.source;
    final selector =
        SelectorParser(source, dirSum.selectorOffset, dirSum.selectorStr)
            .parse();
    final elementTags = <ElementNameSelector>[];
    selector.recordElementNameSelectors(elementTags);

    return lazy.Directive(
        selector, () => _eagerLinker.directive(dirSum, classElement))
      ..classElement = classElement;
  }

  /// Functional directive has so few capabilities, it isn't worth lazy linking.
  ///
  /// The selector must be loaded eagerly so we can know when to bind it to a
  /// template. If it were lazy, this is where we would link it. However, for
  /// a functional directive, there would be very little linking left to do at
  /// that point.
  @override
  FunctionalDirective functionalDirective(
          SummarizedDirective dirSum, FunctionElement functionElement) =>
      _eagerLinker.functionalDirective(dirSum, functionElement);

  /// It is easy to pipes lazy because they are identified by a plain string.
  @override
  Pipe pipe(SummarizedPipe pipeSum, ClassElement classElement) => lazy.Pipe(
      pipeSum.pipeName,
      SourceRange(pipeSum.pipeNameOffset, pipeSum.pipeName.length),
      () => _eagerLinker.pipe(pipeSum, classElement))
    ..classElement = classElement;
}
