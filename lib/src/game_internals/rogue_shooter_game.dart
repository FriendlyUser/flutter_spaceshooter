import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
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
    player.position = Vector2(100, 500);
    // player position center of screen
    player.stopFire();
    children.whereType<EnemyComponent>().forEach(remove);
    // remove all bullets
    children.whereType<BulletComponent>().forEach(remove);
    // remove all explosions
    children.whereType<ExplosionComponent>().forEach(remove);
    // remove enemy creator
    children.whereType<EnemyCreator>().forEach(remove);
    // remove star background creator
    children.whereType<StarBackGroundCreator>().forEach(remove);

    // remove StarComponent
    pauseEngine();
    // go to game won screen

    print('Game Over');
  }
}
