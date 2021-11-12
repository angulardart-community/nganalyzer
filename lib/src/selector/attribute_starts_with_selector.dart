import 'attribute_selector_base.dart';
import 'html_tag_for_selector.dart';
import 'selector.dart';
import 'name.dart';

/// The [Selector] that matches elements that have an attribute with any name,
/// and with contents that match the given regex.
class AttributeStartsWithSelector extends AttributeSelectorBase {
  @override
  final SelectorName nameElement;

  final String value;

  AttributeStartsWithSelector(this.nameElement, this.value);

  @override
  bool matchValue(String attributeValue) => attributeValue.startsWith(value);

  @override
  List<HtmlTagForSelector> refineTagSuggestions(
          List<HtmlTagForSelector> context) =>
      context;

  @override
  String toString() => '[$nameElement^=$value]';
}
