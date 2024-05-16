void changeState() {
    state = "game";
}

void startScene() {
    textSize(50);
    textAlign(CENTER);
    textFont(mainFont);
    text("EndGame", width/2, height/2);

    Button startButton = new Button(width/2, height/2 + 150, 200, 60, "Comenzar", new Runnable() {
      public void run() {
        changeState();
      }
    });
    startButton.display();
    startButton.checkForClick();
}
