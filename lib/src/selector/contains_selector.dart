import '../model.dart';
import 'element_name_selector.dart';
import 'element_view.dart';
import 'html_tag_for_selector.dart';
import 'match.dart';
import 'name.dart';
import 'selector.dart';

/// The [Selector] that checks a TextNode for contents by a regex.
class ContainsSelector extends Selector {
  final String regex;

  ContainsSelector(this.regex);

  @override
  bool availableTo(ElementView element) => false;

  @override
  List<SelectorName> getAttributes(ElementView element) => [];

  /// Not yet supported.
  ///
  /// TODO(b/129973082) check against actual text contents so we know which
  /// `:contains` directives were used (for when we want to advise removal of
  /// unused directives).
  ///
  /// We could also highlight the matching region in the text node with a color
  /// so users know it was applied.
  ///
  /// Not sure what else we could do.
  ///
  /// Never matches elements. Only matches [TextNode]s. Return false for now.
  @override
  SelectorMatch match(ElementView element, Template template) =>
      SelectorMatch.NoMatch;

  @override
  void recordElementNameSelectors(List<ElementNameSelector> recordingList) {
    // empty
  }

  @override
  List<HtmlTagForSelector> refineTagSuggestions(
          List<HtmlTagForSelector> context) =>
      context;

  @override
  String toString() => ":contains($regex)";
}
