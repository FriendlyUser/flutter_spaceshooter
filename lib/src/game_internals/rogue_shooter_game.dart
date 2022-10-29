import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'dart:core';
import 'package:flutter/material.dart' as Material;
import 'package:go_router/go_router.dart';
import 'package:flame/game.dart';
import 'package:provider/provider.dart';
import '../games_services/score.dart';
import '../ads/ads_controller.dart';
import './components/enemy_creator.dart';
import './components/player_component.dart';
import './components/star_background_creator.dart';
import './components/bullet_component.dart';
import './components/enemy_component.dart';
import './components/explosion_component.dart';

class RogueShooterGame extends FlameGame
    with PanDetector, HasCollisionDetection {
  static const String description = '''
    A simple space shooter game used for testing performance of the collision
    detection system in Flame.
  ''';

  late final PlayerComponent player;
  late final TextComponent componentCounter;
  late final TextComponent scoreText;
  late final RouterComponent router;

  int score = 0;

  @override
  Future<void> onLoad() async {
    add(player = PlayerComponent());
    addAll([
      FpsTextComponent(
        position: size - Vector2(0, 50),
        anchor: Anchor.bottomRight,
      ),
      scoreText = TextComponent(
        position: size - Vector2(0, 25),
        anchor: Anchor.bottomRight,
        priority: 1,
      ),
      componentCounter = TextComponent(
        position: size,
        anchor: Anchor.bottomRight,
        priority: 1,
      ),
    ]);

    add(EnemyCreator());
    add(StarBackGroundCreator());
    add(
      router = RouterComponent(
        routes: {
          'blank': OverlayRoute(
           (context, game) {
              return Material.Center();
            },
          ),
          'game-over': OverlayRoute(
            (context, game) {
              final adsController = context.read<AdsController?>();
              adsController?.preloadAd();
              return Material.Center(
                child: Material.ElevatedButton(
                  child: const Material.Text('Open route'),
                  onPressed: () {
                    // Navigate to second route when tapped.
                    var gameScore = Score(
                      0,
                      score,
                      Duration(hours: 2, minutes: 3, seconds: 2),
                    );
                    this.resumeEngine();
                    GoRouter.of(context).go('/play/won', extra: {'score': gameScore});
                  },
                ),
              );
            },
          ),
        },
        initialRoute: 'blank',
      ),
    );
  }

  @override
  void update(double dt) {
    super.update(dt);
    scoreText.text = 'Score: $score';
    componentCounter.text = 'Components: ${children.length}';
  }

  @override
  void onPanStart(_) {
    player.beginFire();
  }

  @override
  void onPanEnd(_) {
    player.stopFire();
  }

  @override
  void onPanCancel() {
    player.stopFire();
  }

  @override
  void onPanUpdate(DragUpdateInfo details) {
    player.position += details.delta.game;
  }

  void increaseScore() {
    score++;
  }

  void endGame() {
    // score = 0;
    // set user back to starting position
    children.whereType<EnemyComponent>().forEach(remove);
    // remove all bullets
    children.whereType<BulletComponent>().forEach(remove);
    // remove all explosions
    children.whereType<ExplosionComponent>().forEach(remove);
    // remove enemy creator
    children.whereType<EnemyCreator>().forEach(remove);
    children.whereType<StarBackGroundCreator>().forEach(remove);
    this.pauseEngine();
    // go to game won screen

    //print('Game Over');

    // rresumeEngine();
    player.position = Vector2(100, 500);
    // player position center of screen
    // player.stopFire();
    // overlays.add("GameOverMenu");
    //GoRouter.of().go('/play/won', extra: {'score': score});
    router.pushOverlay('game-over');
  }
}
