import 'package:flutter/material.dart';

import 'package:flutter_onboard/flutter_onboard.dart';
import 'package:provider/provider.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

final List<OnBoardModel> onBoardData = [
  const OnBoardModel(
    title: "Adicione uma lista para suas tarefas clicando na primeira opção",
    description:
        "Para cada uma de suas listas, você poderá adicionar várias tarefas",
    imgUrl: 'assets/images/01_add_list.png',
  ),
  const OnBoardModel(
    title: "Nomeie a lista para suas tarefas da forma que desejar",
    description:
        "use o nome que preferir, ele aparecerá sempre no topo da sua nova lista",
    imgUrl: 'assets/images/02_name_list.png',
  ),
  const OnBoardModel(
    title: "Adicione uma tarefa diretamente na lista a qual deseja adicioná-la",
    description: "A sua nova tarefa aparecerá como a última da lista na qual ela for inserida",
    imgUrl: "assets/images/03_add_task.png",
  ),
  const OnBoardModel(
    title: "Ou comece a criar uma tarefa e só então decida a que lista ela pertence",
    description: "A sua nova tarefa aparecerá como a última da lista na qual ela for inserida",
    imgUrl: "assets/images/04_add_task.png",
  ),
  const OnBoardModel(
    title: "Personalize a sua tarefa de acordo com as suas preferÇencias e necessidades",
    description:
        "Escolha até quando ela deve executada, sua categoria, nome e descrição",
    imgUrl: 'assets/images/05_edit_task.png',
  ),
  const OnBoardModel(
    title: "Errou algo durante a definição da tarefa? Corrija!",
    description:
        "Selecione a tarefa que deseja editar e mude o que precisar nela",
    imgUrl: 'assets/images/06_fix_task.png',
  ),
  const OnBoardModel(
    title: "Adicione as tarefas que mais importam para você às suas favoritas",
    description:
        "Selecione a tarefa que deseja editar e mude o que precisar nela",
    imgUrl: 'assets/images/07_favorite_task.png',
  ),
];

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: OnBoardScreen(),
    );
  }
}

class OnBoardScreen extends StatelessWidget {
  final PageController _pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return Provider<OnBoardState>(
      create: (_) => OnBoardState(),
      child: Scaffold(
        body: OnBoard(
          pageController: _pageController,
          onBoardData: onBoardData,
          titleStyles: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w900,
            letterSpacing: 0.15,
          ),
          descriptionStyles: TextStyle(
            fontSize: 16,
          ),
          pageIndicatorStyle: const PageIndicatorStyle(
            width: 100,
            inactiveColor: Colors.lightBlue,
            activeColor: Colors.blue,
            inactiveSize: Size(8, 8),
            activeSize: Size(12, 12),
          ),
          // Either Provide onSkip Callback or skipButton Widget to handle skip state
          skipButton: TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              AppLocalizations.of(context)!.skip,
              style: TextStyle(color: Colors.blue),
            ),
          ),
          // Either Provide onDone Callback or nextButton Widget to handle done state
          nextButton: Consumer<OnBoardState>(
            builder: (BuildContext context, OnBoardState state, Widget? child) {
              return InkWell(
                onTap: () => _onNextTap(state, context),
                child: Container(
                  width: 230,
                  height: 50,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    gradient: const LinearGradient(
                      colors: [Colors.lightBlueAccent, Colors.blueAccent],
                    ),
                  ),
                  child: Text(
                    state.isLastPage ? AppLocalizations.of(context)!.done : AppLocalizations.of(context)!.next,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  void _onNextTap(OnBoardState onBoardState, BuildContext context) {
    if (!onBoardState.isLastPage) {
      _pageController.animateToPage(
        onBoardState.page + 1,
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOutSine,
      );
    } else {
      Navigator.pop(context);
    }
  }
}

