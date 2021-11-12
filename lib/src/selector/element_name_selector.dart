import '../model.dart';
import 'element_view.dart';
import 'html_tag_for_selector.dart';
import 'selector.dart';
import 'match.dart';
import 'name.dart';

/// The element name based selector.
class ElementNameSelector extends Selector {
  final SelectorName nameElement;

  ElementNameSelector(this.nameElement);

  @override
  bool availableTo(ElementView element) =>
      nameElement.string == element.localName;

  @override
  List<SelectorName> getAttributes(ElementView element) => [];

  @override
  SelectorMatch match(ElementView element, Template template) {
    final name = nameElement.string;
    // match
    if (element.localName != name) {
      return SelectorMatch.NoMatch;
    }
    // record resolution
    if (element.openingNameSpan != null) {
      template?.addRange(element.openingNameSpan, nameElement);
    }
    if (element.closingNameSpan != null) {
      template?.addRange(element.closingNameSpan, nameElement);
    }
    return SelectorMatch.TagMatch;
  }

  @override
  void recordElementNameSelectors(List<ElementNameSelector> recordingList) {
    recordingList.add(this);
  }

  @override
  List<HtmlTagForSelector> refineTagSuggestions(
      List<HtmlTagForSelector> context) {
    for (final tag in context) {
      tag.name = nameElement.string;
    }
    return context;
  }

  @override
  String toString() => nameElement.string;
}
