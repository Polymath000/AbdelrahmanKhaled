import 'package:portofolio/feature/portfolio/domain/entities/cv_state.dart';

/// Core profile information for the portfolio.
class Profile {
  /// Creates a profile.
  const Profile({
    required this.name,
    required this.role,
    required this.tagline,
    required this.bio,
    required this.interests,
    required this.cvState,
    this.heroImageAsset,
    this.cvAssetPath,
  });

  final String name;
  final String role;
  final String tagline;
  final String bio;
  final List<String> interests;
  final String? heroImageAsset;
  final String? cvAssetPath;
  final CvState cvState;

  /// Returns a copy with a resolved CV state.
  Profile copyWith({CvState? cvState}) {
    return Profile(
      name: name,
      role: role,
      tagline: tagline,
      bio: bio,
      interests: interests,
      heroImageAsset: heroImageAsset,
      cvAssetPath: cvAssetPath,
      cvState: cvState ?? this.cvState,
    );
  }
}
