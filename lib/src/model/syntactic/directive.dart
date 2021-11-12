import 'package:analyzer/src/generated/source.dart' show Source, SourceRange;
import 'annotated_class.dart';
import 'content_child.dart';
import 'directive_base.dart';
import 'input.dart';
import 'output.dart';
import '../../selector.dart';
import 'package:meta/meta.dart';

/// Syntactic model of an Angular directive.
///
/// This excludes functional directives, if you want to include functional
/// directives then use [DirectiveBase].
///
/// ```dart
/// @Directive(
///   selector: 'my-selector', // required
///   exportAs: 'foo', // optional
/// )
/// class MyDirective { // must be a class
///   @Input() input; // may have inputs
///   @Output() output; // may have outputs
///
///   // may have content child(ren).
///   @ContentChild(...) child;
///   @ContentChildren(...) children;
///
///   MyComponent(
///     @Attribute() String attr, // may have attributes
///   );
/// }
/// ```
class Directive extends AnnotatedClass implements DirectiveBase {
  @override
  final Selector selector;

  /// The value of the `exportAs` property of this directive annotation.
  final String exportAs;

  /// The source range of [exportAs] for this directive. Used for navigation.
  final SourceRange exportAsRange;

  Directive(String className, Source source,
      {@required this.exportAs,
      @required this.exportAsRange,
      @required List<Input> inputs,
      @required List<Output> outputs,
      @required this.selector,
      @required List<ContentChild> contentChildFields,
      @required List<ContentChild> contentChildrenFields})
      : super(className, source,
            inputs: inputs,
            outputs: outputs,
            contentChildFields: contentChildFields,
            contentChildrenFields: contentChildrenFields);
}
