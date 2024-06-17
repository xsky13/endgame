//imagenes mando
int transXMen = -80; //player 2
int transYMen = -350; //player 2

void  MenControls() {
    imageMode(CORNER);
  //Mando
    if (MandON) {
        if (btxpresOn) {
            image(X1, 120 + transXMen, 700 + transYMen, 80, 80);
        } else {
            image(X0, 120 + transXMen, 700 + transYMen, 80, 80);
        }

        if (jumpButtonPressed) {
            image(A1, 120 + transXMen, 785 + transYMen, 80, 80);
        } else {
            image(A0, 120 + transXMen, 785 + transYMen, 80, 80);
        }
    }
  //image(RB0, 100, 100, 200, 200);
  //image(LB0, 100, 100, 200, 200);

    // comprueba las pulsaciones
    if (keys.getOrDefault(87, false)) {
        image(KeyW1, 1775 + transXMen, 400 + transYMen, 100, 100);
        // w
    } else image(KeyW0, 1775 + transXMen, 400 + transYMen, 100, 100);
    if (keys.getOrDefault(65, false)) {
        image(KeyA1, 1700 + transXMen, 470 + transYMen, 100, 100);
        // a
    } else image(KeyA0, 1700 + transXMen, 470 + transYMen, 100, 100);
    if (keys.getOrDefault(68, false)) {
        image(KeyD1, 1850 + transXMen, 470 + transYMen, 100, 100);
        // d
    } else image(KeyD0, 1850 + transXMen, 470 + transYMen, 100, 100);

    if (keys.getOrDefault(83, false)) {
        image(KeyS1, 1775 + transXMen, 470 + transYMen, 100, 100);
        // s
    } else image(KeyS0, 1775 + transXMen, 470 + transYMen, 100, 100);
    
    if (keys.getOrDefault(81, false)) {
        image(KeyQ1, 1875 + transXMen, 600 + transYMen, 100, 100);
        // q
    } else image(KeyQ0, 1875 + transXMen, 600 + transYMen, 100, 100);

    // player 2
    if (keys.getOrDefault(38, false)) {
        image(KeyUp1, 200 + transXMen, 400 + transYMen, 100, 100);
        // up
    } else image(KeyUp0, 200+ transXMen, 400 + transYMen, 100, 100);

    if (keys.getOrDefault(37, false)) {
        image(KeyRight1, 130 + transXMen, 470 + transYMen, 100, 100);
        // right
    } else image(KeyRight0, 130 + transXMen, 470 + transYMen, 100, 100);
    
    if (keys.getOrDefault(39, false)) {
        image(KeyLeft1, 275 + transXMen, 470 + transYMen, 100, 100);
        // left
    } else image(KeyLeft0, 275 + transXMen, 470 + transYMen, 100, 100);
    
    if (keys.getOrDefault(40, false)) {
        image(KeyDown1, 200 + transXMen, 470 + transYMen, 100, 100);
        // down
    } else image(KeyDown0, 200 + transXMen, 470 + transYMen, 100, 100);
    
    if (keys.getOrDefault(16, false)) {
        image(KeyShift1, 120 + transXMen, 600 + transYMen, 100, 100);
        // shift
    } else  image(KeyShift0, 120 + transXMen, 600 + transYMen, 100, 100);


    textFont(mainFont);//indico que fuente voy a usar
    textSize(50); 
    //player 1
    text("Move", 420 + transXMen, 490 + transYMen);
    text("Attack", 320 + transXMen, 650 + transYMen);

    if (MandON) {
        text("Attack", 240 + transXMen, 750 + transYMen);
        text("Jump", 230 + transXMen, 830 + transYMen);
    }
    //player 2
    text("Move", 1625 + transXMen, 490 + transYMen);
    text("Attack", 1775 + transXMen, 650 + transYMen);

    Button goHome = new Button(width/2, height - 400, 200, 60, "Volver", new Runnable() {
		public void run() {
			state = "start";
		}
    });
    goHome.display();
    goHome.checkForClick();
}
