---
title: Big Fact Slide
navOrder: 2
---
To create a big fact slide, use the `FlutterDeckSlide.bigFact` constructor. It is responsible for rendering the title (fact) with the description (subtitle) below it.

```dart
class BigFactSlide extends FlutterDeckSlideWidget {
  const BigFactSlide()
      : super(
          configuration: const FlutterDeckSlideConfiguration(
            route: '/big-fact',
            header: FlutterDeckHeaderConfiguration(
              title: 'Big fact slide template',
            ),
          ),
        );

  @override
  FlutterDeckSlide build(BuildContext context) {
    return FlutterDeckSlide.bigFact(
      title: '100%',
      subtitle: 'The test coverage value that flutter_deck will probably never achieve',
      theme: FlutterDeckTheme.of(context).copyWith(
        bigFactSlideTheme: const FlutterDeckBigFactSlideThemeData(
          titleTextStyle: TextStyle(color: Colors.amber),
        ),
      ),
    );
  }
}
```

![Big fact slide example](https://github.com/mkobuolys/flutter_deck/blob/main/images/templates/big_fact.png?raw=true)