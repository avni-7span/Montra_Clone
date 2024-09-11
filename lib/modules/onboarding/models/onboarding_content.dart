class OnboardingContent {
  const OnboardingContent({
    required this.title,
    required this.subTitle,
    required this.imagePath,
  });

  final String title;
  final String subTitle;
  final String imagePath;
}

const List<OnboardingContent> onboardingContentList = [
  OnboardingContent(
    title: 'Gain total control of your money',
    subTitle:
        'Track your transaction easily, with categories and financial report',
    imagePath: 'assets/images/image_1.png',
  ),
  OnboardingContent(
    title: 'Know where your money goes',
    subTitle:
        'Track your transaction easily, with categories and financial report',
    imagePath: 'assets/images/image_2.png',
  ),
  OnboardingContent(
    title: 'Planning ahead',
    subTitle: 'Setup your budget for each category so you in control',
    imagePath: 'assets/images/image_3.png',
  ),
];
