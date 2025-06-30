import 'package:url_launcher/url_launcher.dart';

/// A helper class that provides methods to open URLs in browsers
/// or other applications.
///
/// This class wraps the url_launcher package functionality for easier use.
class RedirectHelper {
  /// Opens a URL in a browser or appropriate application.
  ///
  /// [url] The URL to open.
  /// [launchOnExternalApplication] If true, forces opening in an external
  /// browser application. If false, uses the platform's default browser
  /// which may be in-app or external.
  ///
  /// Returns a Future that completes when the URL launch operation is done.
  /// Throws an exception if the URL cannot be launched.
  static Future<void> redirectToBrowser(
    String url, {
    bool launchOnExternalApplication = false,
  }) async {
    // First check if the URL can be launched
    if (await canLaunchUrl(Uri.parse(url))) {
      // Launch the URL with the specified mode
      await launchUrl(
        Uri.parse(url),
        mode:
            launchOnExternalApplication
                ? LaunchMode
                    .externalApplication // Opens in external browser
                : LaunchMode.platformDefault, // Uses platform default behavior
      );
    } else {
      // If URL can't be launched, throw an exception
      throw 'Could not launch $url';
    }
  }
}
