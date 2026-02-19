---
title: Template overrides
navOrder: 9
---

The `flutter_deck` package comes with a set of predefined slide templates. However, sometimes you might want to customize the look and feel of these templates to match your brand or design. For instance, you might want to change the layout of the title slide or update the layout of the split slide.

To achieve this, you can provide a `FlutterDeckTemplateOverrideConfiguration` to the `FlutterDeckConfiguration` of your slide deck. This configuration allows you to override the default builders for the slide templates.

## Usage

To override a slide template, you need to provide a builder function for the specific template in the `FlutterDeckTemplateOverrideConfiguration`. The builder function will be called whenever the corresponding slide template is used.

The builder function receives all the necessary parameters to build the slide. You can use these parameters to build your custom slide.

Ideally, you should use the `FlutterDeckSlideBase` widget as the root of your custom slide template. This widget is responsible for placing the header, footer, and content of the slide in the correct places. Also, it is responsible for displaying the background of the slide.

## Example

Here is an example of how to override the title slide template to change the layout:

```dart
class CustomTitleSlide extends StatelessWidget {
  const CustomTitleSlide({required this.title, required this.subtitle, super.key});

  final String title;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    return FlutterDeckSlideBase(
      contentBuilder: (context) => Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 96, fontWeight: FontWeight.bold),
            ),
            if (subtitle != null)
              Text(
                subtitle!,
                style: const TextStyle(fontSize: 80, height: 1),
              ),
            const SizedBox(height: 64),
            FlutterDeckSpeakerInfoWidget(
              speakerInfo: context.flutterDeck.speakerInfo!,
            ),
          ],
        ),
      ),
    );
  }
}

FlutterDeckApp(
  configuration: FlutterDeckConfiguration(
    templateOverrides: FlutterDeckTemplateOverrideConfiguration(
      titleSlideBuilder: (context, title, subtitle, backgroundBuilder, footerBuilder, headerBuilder, speakerInfoBuilder) {
        return CustomTitleSlide(
          title: title,
          subtitle: subtitle,
        );
      },
    ),
  ),
  <...>
);
```

Now, whenever you use `FlutterDeckSlide.title` in your slide deck, the `CustomTitleSlide` widget will be used instead of the default title slide template.

## Available overrides

You can override the following slide templates:

- `bigFactSlideBuilder`: Overrides the `FlutterDeckSlide.bigFact` template.
- `blankSlideBuilder`: Overrides the `FlutterDeckSlide.blank` template.
- `imageSlideBuilder`: Overrides the `FlutterDeckSlide.image` template.
- `quoteSlideBuilder`: Overrides the `FlutterDeckSlide.quote` template.
- `splitSlideBuilder`: Overrides the `FlutterDeckSlide.split` template.
- `templateSlideBuilder`: Overrides the `FlutterDeckSlide.template` template.
- `titleSlideBuilder`: Overrides the `FlutterDeckSlide.title` template.
