class OnboardingPageModel {
  final String image;
  final String title;
  final String description;

  OnboardingPageModel({
    required this.image,
    required this.title,
    required this.description,
  });
}

final List<OnboardingPageModel> onboardingPagesData = [
  OnboardingPageModel(
    image: 'assets/images/imagem3.png',
    title: 'De pessoas para pessoas',
    description:
        'Um app para pessoas ajudarem pessoas a reconstruir sua vida.',
  ),
  OnboardingPageModel(
    image: 'assets/images/imagem1.png',
    title: 'Doe o que não utiliza',
    description:
        'Com Help Iguaçu você pode doar o que não utiliza mais, podendo dar novo propósito ajudando novas pessoas.',
  ),
  OnboardingPageModel(
    image: 'assets/images/imagem2.png',
    title: 'Tudo na palma da sua mão',
    description:
        'Help Iguaçu, a um novo modo de ajudar a pessoas terem um novo inicio.',
  ),
];
