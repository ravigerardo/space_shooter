import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import 'overlays/game_over_overlay.dart';
import 'space_shoot_game.dart';

void main() {
  runApp(
    GameWidget(
      game: SpaceShooterGame(),
      overlayBuilderMap: {
        'GameOver': (context, SpaceShooterGame game) => GameOverOverlay(game: (game)),
      },
    ),
  );
}
