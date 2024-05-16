int screenLimit = height - 170;

void gameScene() {
    background(57, 217, 237);
    
    noStroke();

	rectMode(CORNER);

    // health pplayer 1
    fill(255, 0, 0);
    rect(30, 30, players[0].health * 3, 15, 10);
    fill(0);
	text("Vida de Jugador 1: " + players[0].health, 174, 75);

    // barra de salud jugador 2
    fill(255, 0, 0);
	rect(width - players[1].health * 3 - 30, 30, players[1].health * 3, 15, 10);
    fill(0);
	text("Vida de Jugador 2: " + players[1].health, width - 174, 75);

    // agua y espuma de agua
    for (int i = 0; i < 100; i++) {
        image(foam, i * 20, height - 205);
    }
    
    for (int i = 0; i < 100; i++) {
        for (int j = 0; j < 20; j++) {
            image(water, i * water.width, (j * water.height) + (height - 200));
        }
    }
    // image(water, 0, 0, width, height);

    pushMatrix();
    scale(2, 2);
    image(loadImage("assets/backgrounds/cloud_1.png"), 100, 220);

    image(loadImage("assets/backgrounds/cloud_2.png"), 500, 120);

    image(loadImage("assets/backgrounds/cloud_3.png"), 800, 200);
    popMatrix();
    
    // first ground and foam
    image(foam, ground.width - foam.width + 12, height - 205);
    image(foam, ground.width - foam.width + 12, height - 205 + foam.height);
    image(foam, ground.width - foam.width + 12, height - 205 + foam.height * 2);

    image(ground, 0, height - 250);
    image(grass, 0, height - 250);
    
    //two bridges
    image(bridge, ground.width, height - 170);
    image(bridge, ground.width + bridge.width, height - 170);

    // second ground
    image(foam, ground.width + (bridge.width*2) - 10, height - 205);
    image(foam, ground.width + (bridge.width*2) - 10, height - 205 + foam.height);
    image(foam, ground.width + (bridge.width*2) - 10, height - 205 + foam.height * 2);

    image(foam, (ground.width + foam.width*2 + 15) + (bridge.width*2), height - 205);
    image(foam, (ground.width + foam.width*2 + 15) + (bridge.width*2), height - 205 + foam.height);
    image(foam, (ground.width + foam.width*2 + 15) + (bridge.width*2), height - 205 + foam.height * 2);

    image(ground, ground.width + (bridge.width*2), height - 250);
    image(grassYellow, ground.width + (bridge.width*2), height - 250);

    // espuma para el tercer bloque de piedra
    image(foam, (ground.width*2) + (bridge.width*2) + groundElevation.width - 10, height - 205);
    image(foam, (ground.width*2) + (bridge.width*2) + groundElevation.width - 10, height - 205 + foam.height);
    image(foam, (ground.width*2) + (bridge.width*2) + groundElevation.width - 10, height - 205 + foam.height * 2);

    image(foam, (ground.width*2) + (bridge.width*2) + groundElevation.width + (foam.width*3) + 53, height - 205);
    image(foam, (ground.width*2) + (bridge.width*2) + groundElevation.width + (foam.width*3) + 53, height - 205 + foam.height);
    image(foam, (ground.width*2) + (bridge.width*2) + groundElevation.width + (foam.width*3) + 53, height - 205 + foam.height * 2);

    // puente de piedra
    image(foam, (ground.width*2) + (bridge.width*2), height - 202 + foam.height);
    image(foam, (ground.width*2) + (bridge.width*2) + foam.width, height - 202 + foam.height);
    image(groundElevation, (ground.width*2) + (bridge.width*2), height - 170);

    // tercer bloque de piedra
    image(groundSmall, (ground.width*2) + (bridge.width*2) + groundElevation.width, height - 250);
    image(grassSmall, (ground.width*2) + (bridge.width*2) + groundElevation.width, height - 250);

    image(groundSmall, (ground.width*2) + (bridge.width*2) + groundElevation.width + groundSmall.width, height - 250);
    image(grassSmall, (ground.width*2) + (bridge.width*2) + groundElevation.width + groundSmall.width, height - 250);

    // espuma de cuarto bloque de piedra
    image(foam, (ground.width*2) + (bridge.width*2) + groundElevation.width + groundSmall.width*2 + bridge.width - 10, height - 205);
    image(foam, (ground.width*2) + (bridge.width*2) + groundElevation.width + groundSmall.width*2 + bridge.width - 10, height - 205 + foam.height);
    image(foam, (ground.width*2) + (bridge.width*2) + groundElevation.width + groundSmall.width*2 + bridge.width - 10, height - 205 + foam.height * 2);

    // segundo puente
    image(bridge, (ground.width*2) + (bridge.width*2) + groundElevation.width + groundSmall.width*2, height - 170);

    // cuarto bloque de piedra

    image(ground, (ground.width*2) + (bridge.width*2) + groundElevation.width + groundSmall.width*2 + bridge.width, height - 250);
    image(ground, (ground.width*3) + (bridge.width*2) + groundElevation.width + groundSmall.width*2 + bridge.width, height - 250);

    // torres
    image(towerRed, 50, height - 350);
    image(towerBlue, width - 150, height - 350);
    
    for (int i = 0; i < players.length; i++) {
        players[i].applyGravity();
        players[i].checkBorders();
        players[i].move(players[i == players.length - 1 ? 0 : 1]);
        players[i].attackAnimation();

		if (i == 1) {
            players[i].attack(players[0]);
		} else if (i == 0) {
            players[i].attack(players[1]);
		}

        players[i].detectCollisionWithPlayer(players[i == players.length - 1 ? 0 : 1].playerWidth, players[i == players.length - 1 ? 0 : 1].playerHeight, players[i == players.length - 1 ? 0 : 1].position);
        players[i].display();
    }
    
}

