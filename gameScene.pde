void gameScene() {
    background(57, 217, 237);
    noStroke();

    // todas las imagenes cargadas anteriormente
    image(staticScene, 0, 0);

    // Si a alguno de los jugadores se les acabo la vida, entonces el juego termino.
    if (players[0].health <= 0 || players[1].health <= 0) {
        state = "end";
    }

    // Dibujar los arboles
    tree.display();
    tree2.display();

    // barra de vida jugador 1
    rectMode(CORNER);
    fill(255, 0, 0);
    rect(30, 30, players[0].health * 3, 15, 10);
    fill(0);
	text("Vida de Jugador 1: " + players[0].health, 174, 75);

    // barra de salud jugador 2
    fill(255, 0, 0);
	rect(width - players[1].health * 3 - 30, 30, players[1].health * 3, 15, 10);
    fill(0);
	text("Vida de Jugador 2: " + players[1].health, width - 174, 75);

    // Actualizar los hongos.
    checkForMushrooms();
    // Actualizar los zapallos.
    checkForPumpkins();

    // Hacer un bucle en el array de jugadores.
    for (int i = 0; i < players.length; i++) {
        // Hacer un bucle en el array de hongos, dibujarlos, y detectar colisiones.
        for (int j = 0; j < mushrooms.length; j++) {
            mushrooms[j].display();
            mushrooms[j].detectCollisionWithPlayer(players[i], mushrooms[j]);
        } 

        // Hacer un bucle en el array de zapallos, dibujarlos, y detectar colisiones.
        for (int j = 0; j < pumpkins.length; j++) {
            pumpkins[j].display();
            pumpkins[j].detectCollisionWithPlayer(players[i], pumpkins[j], j);
        } 

        // Llamar todas los metodos necesarios para que el jugador funcione correctamente.
        players[i].checkBorders();
        players[i].move();
        players[i].applyGravity();
        players[i].attack(players[(i + 1) % players.length]);
        players[i].detectCollisionWithPlayer(players[(i + 1) % players.length]);
        players[i].display();
        players[i].updateDamage();
        players[i].updateSoundVariables();
    }
}

