import 'dart:io';

import 'package:static_shock/static_shock.dart';

Future<void> main(List<String> arguments) async {
  // Configure the static website generator.
  final staticShock = StaticShock()
    // Here, you can directly hook into the StaticShock pipeline. For example,
    // you can copy an "images" directory from the source set to build set:
    ..pick(DirectoryPicker.parse("images"))
    // All 3rd party behavior is added through plugins, even the behavior
    // shipped with Static Shock.
    ..plugin(const MarkdownPlugin())
    ..plugin(const JinjaPlugin())
    ..plugin(const PrettyUrlsPlugin())
    ..plugin(const RedirectsPlugin())
    ..plugin(const SassPlugin())
    
    ..plugin(const PubPackagePlugin({
      "flutter_deck",
    }))
    
    
    ..plugin(
      GitHubContributorsPlugin(
        // To load the contributors for a given GitHub package using credentials,
        // place your GitHub API token in an environment variable with the following name.
        authToken: Platform.environment["github_doc_website_token"],
      ),
    )
    
    ..plugin(DraftingPlugin(
      showDrafts: arguments.contains("preview"),
    ));

  // Generate the static website.
  await staticShock.generateSite();
}
