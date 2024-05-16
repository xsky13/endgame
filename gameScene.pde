int screenLimit = height - 170;

void gameScene() {
    background(57, 217, 237);
    
    noStroke();

    // todas las imagenes cargadas anteriormente
    image(staticScene, 0, 0);

    if (players[0].health <= 0 || players[1].health <= 0) {
        state = "end";
    }

	rectMode(CORNER);

    // barra de vida jugador 1
    fill(255, 0, 0);
    rect(30, 30, players[0].health * 3, 15, 10);
    fill(0);
	text("Vida de Jugador 1: " + players[0].health, 174, 75);

    // barra de salud jugador 2
    fill(255, 0, 0);
	rect(width - players[1].health * 3 - 30, 30, players[1].health * 3, 15, 10);
    fill(0);
	text("Vida de Jugador 2: " + players[1].health, width - 174, 75);
    
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

