---
title: Navigation drawer
navOrder: 2
---

Every slide deck comes with a navigation drawer that can be used to navigate through the slide deck. The navigation drawer is automatically generated based on the slide deck configuration.

The navigation drawer item title is generated based on the following rules:

- The slide title is used if it is set in the slide configuration (`FlutterDeckSlideConfiguration.title`).
- If the slide title is not set, the header title is used if it is set in the slide header configuration (`FlutterDeckHeaderConfiguration.title`).
- The slide route is used otherwise.

![Navigation demo](https://github.com/mkobuolys/flutter_deck/blob/main/images/navigation.gif?raw=true)
