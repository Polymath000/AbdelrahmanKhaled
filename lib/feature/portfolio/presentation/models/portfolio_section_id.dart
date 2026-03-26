/// Addressable one-page sections used by navigation and scroll tracking.
enum PortfolioSectionId {
  hero('Home'),
  about('About'),
  skills('Skills'),
  featuredWork('Published'),
  projectArchive('Training'),
  contact('Contact');

  const PortfolioSectionId(this.navLabel);

  final String navLabel;
}
