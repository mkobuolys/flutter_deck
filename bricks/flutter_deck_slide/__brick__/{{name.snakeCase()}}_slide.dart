import 'package:flutter/widgets.dart';
import 'package:flutter_deck/flutter_deck.dart';

class {{name.pascalCase()}}Slide extends FlutterDeckSlideWidget {
  const {{name.pascalCase()}}Slide()
      : super(
          configuration: const FlutterDeckSlideConfiguration(
            route: '/{{name.paramCase()}}',
          ),
        );

  @override
  FlutterDeckSlide build(BuildContext context) {
    return {{#use_blank}}{{>blank}}{{/use_blank}}{{#use_custom}}{{>custom}}{{/use_custom}}{{#use_big_fact}}{{>big-fact}}{{/use_big_fact}}{{#use_quote}}{{>quote}}{{/use_quote}}{{#use_image}}{{>image}}{{/use_image}}{{#use_split}}{{>split}}{{/use_split}}{{#use_template}}{{>template}}{{/use_template}}{{#use_title}}{{>title}}{{/use_title}}
  }
}
