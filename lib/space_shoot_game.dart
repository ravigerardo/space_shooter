import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/experimental.dart';
import 'package:flame/game.dart';
import 'package:flame/parallax.dart';
import 'package:flutter/material.dart';
import 'package:space_shooter/actors/enemy.dart';

import 'actors/player.dart';
import 'objects/explosion.dart';

class SpaceShooterGame extends FlameGame
    with DragCallbacks, HasCollisionDetection {
  late Player player;
  late SpawnComponent enemiesSpawn;

  void initialize() {
    player = Player();
    add(player);

    enemiesSpawn = SpawnComponent(
      factory: (index) => Enemy(),
      period: 1,
      area: Rectangle.fromLTWH(0, 0, size.x, -Enemy.enemySize),
    );
    add(enemiesSpawn);
  }

  void gameOver() {
    player.removeFromParent();
    enemiesSpawn.removeFromParent();
    overlays.add('GameOver');
  }

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    final parallax = await loadParallaxComponent(
      [
        ParallaxImageData('stars_0.png'),
        ParallaxImageData('stars_1.png'),
        ParallaxImageData('stars_2.png'),
      ],
      baseVelocity: Vector2(0, -5),
      repeat: ImageRepeat.repeat,
      velocityMultiplierDelta: Vector2(0, 5),
    );
    add(parallax);

    initialize();
  }

  @override
  void onDragUpdate(DragUpdateEvent event) {
    player.move(event.localDelta);
  }

  @override
  void onDragStart(DragStartEvent event) {
    super.onDragStart(event);
    player.startShooting();
  }

  @override
  void onDragEnd(DragEndEvent event) {
    super.onDragEnd(event);
    player.stopShooting();
  }
}
