void endScene() {
    fill(0);
    rect(0, 0, width, height);
    textSize(50);

    fill(255, 0, 0);
	// Mostrar cual de los jugadores perdio en base a su vida.
    if (players[0].health <= 0) {
        text("El Jugador 1 ha perdido.", width/2, height/2);
    } else if (players[1].health <= 0) {      
        text("El Jugador 2 ha perdido.", width/2, height/2);
    }

	// Boton de reinicio al juego.
    Button startButton = new Button(width/2, height/2 + 150, 200, 60, "Reiniciar", new Runnable() {
		public void run() {
			setup();
			state = "start";
		}
    });
    startButton.display();
    startButton.checkForClick();
}