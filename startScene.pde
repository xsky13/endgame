void changeState() {
    state = "game";
}

void startScene() {
	// Se dibuja el fondo con las imagenes.
    wallpaper();
    textSize(50);
    textAlign(CENTER);
    textFont(mainFont);
    text("EndGame", width/2, height/2);

	// Boton de juego. 
    Button startButton = new Button(width/2, height/2 + 70, 200, 60, "Comenzar", new Runnable() {
		public void run() {
			// Al apretarlo se cambia el estado al juego.
			changeState();
		}
    });
    startButton.display();
    startButton.checkForClick();

    // Boton de historia.
    Button storyButton = new Button(width/2, height/2 + 150, 200, 60, "Historia", new Runnable() {
		public void run() {
			// Al apretarlo se cambia el estado al de historia.
			state = "story";
		}
    });
    storyButton.display();
    storyButton.checkForClick();

    Button constrolsButton = new Button(width/2, height/2 + 230, 200, 60, "Controles", new Runnable() {
		public void run() {
			// Al apretarlo se cambia el estado al de historia.
			state = "control";
		}
    });
    constrolsButton.display();
    constrolsButton.checkForClick();

	// Estas funciones son responsables por el soldado y la espada 3D.
    tresD();
    tres();
    acel();
}
