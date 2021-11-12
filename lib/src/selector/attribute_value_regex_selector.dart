import '../model.dart';
import 'element_name_selector.dart';
import 'element_view.dart';
import 'html_tag_for_selector.dart';
import 'match.dart';
import 'name.dart';
import 'selector.dart';

/// The [Selector] that matches any attributes contents against the given regex.
class AttributeValueRegexSelector extends Selector {
  final SelectorName regexpElement;
  final RegExp regexp;

  AttributeValueRegexSelector(this.regexpElement)
      : regexp = RegExp(regexpElement.string);

  @override
  bool availableTo(ElementView element) =>
      match(element, null) == SelectorMatch.NonTagMatch;

  @override
  List<SelectorName> getAttributes(ElementView element) => [];

  @override
  SelectorMatch match(ElementView element, Template template) {
    for (final attr in element.attributes.keys) {
      final value = element.attributes[attr];
      if (regexp.hasMatch(value)) {
        template?.addRange(element.attributeValueSpans[value], regexpElement);
        return SelectorMatch.NonTagMatch;
      }
    }
    return SelectorMatch.NoMatch;
  }

  @override
  void recordElementNameSelectors(List<ElementNameSelector> recordingList) {
    // empty
  }

  @override
  List<HtmlTagForSelector> refineTagSuggestions(
          List<HtmlTagForSelector> context) =>
      context;

  @override
  String toString() => '[*=${regexpElement.string}]';
}
