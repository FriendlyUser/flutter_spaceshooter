# Summary

Originally I ported the casual game toolkit and the sample flutter spaceshooter game, will try to modify it to have achievements, admob support and more.

Swapping the play widget to be the sample rogueShooterGame.
```
path: 'play',
// replace widget here with flame game?
pageBuilder: (context, state) => buildMyTransition<void>(
        child: GameWidget(game: RogueShooterGame()),
        // child: const LevelSelectionScreen(
        //     key: Key('level selection')),
        color: context.watch<Palette>().backgroundLevelSelection,
    ),
```