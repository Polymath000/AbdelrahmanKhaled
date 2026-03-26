/// Supported contact link kinds for presentation mapping.
enum ContactLinkKind { email, linkedIn, github, youtube }

/// A user-facing contact destination.
class ContactLink {
  /// Creates a contact link.
  const ContactLink({
    required this.title,
    required this.value,
    required this.url,
    required this.kind,
  });

  final String title;
  final String value;
  final String url;
  final ContactLinkKind kind;
}
