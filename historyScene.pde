void historyScene() {
    wallpaper();
    textSize(50);
    textAlign(CENTER);
    textFont(mainFont);
    text("Historia", width/2, 200);
    // text();

    Button backButton = new Button(150, 100, 200, 60, "Volver", new Runnable() {
		public void run() {
			// Al apretarlo se cambia el estado al de historia.
			state = "start";
		}
    });
    backButton.display();
    backButton.checkForClick();
}