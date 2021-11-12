import 'top_level.dart';
import '../../selector.dart';

/// Core behavior to directives and components, including functional directives,
/// but excluding non directive parts of angular such as pipes and regular
/// annotated classes.
abstract class DirectiveBase extends TopLevel {
  Selector get selector;
}
