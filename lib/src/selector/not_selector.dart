import '../model.dart';
import 'element_name_selector.dart';
import 'element_view.dart';
import 'html_tag_for_selector.dart';
import 'selector.dart';
import 'match.dart';
import 'name.dart';

/// The [Selector] that confirms the inner [Selector] condition does NOT match.
class NotSelector extends Selector {
  final Selector condition;

  NotSelector(this.condition);

  @override
  bool availableTo(ElementView element) =>
      condition.match(element, null) == SelectorMatch.NoMatch;

  @override
  List<SelectorName> getAttributes(ElementView element) => [];

  @override
  SelectorMatch match(ElementView element, Template template) =>
      // pass null into the lower condition -- don't record NOT matches.
      condition.match(element, null) == SelectorMatch.NoMatch
          ? SelectorMatch.NonTagMatch
          : SelectorMatch.NoMatch;

  @override
  void recordElementNameSelectors(List<ElementNameSelector> recordingList) {
    // empty
  }

  @override
  List<HtmlTagForSelector> refineTagSuggestions(
          List<HtmlTagForSelector> context) =>
      context;

  @override
  String toString() => ":not($condition)";
}
