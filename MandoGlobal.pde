float dx, dy, posX = height *5, posY = 315;// de 1
float mpx, mpy; //var para el menu
boolean jumpButtonPressed; //boton a
boolean btxpresOn; // boton x
boolean rbpresOn;
boolean lbpresOn;
boolean BackOn;

// Conseguir la configuracion del mando.
void initializeJoystick() {
	noStroke();
  	if (MandON) {
		// Inicializar el mando con la instancia actual.
		control = ControlIO.getInstance(this);
		
		// Conectar el dispostivo usando la configuracion que esta en el archivo MandC en data para filtrar todos los dispositivos que se pueden usar.
		stick = control.filter(GCP.GAMEPAD).getMatchedDevice("MandC"); // lama a la confi creada por mi
	}
}

// Conseguir la entrada del usuario.
public void getUserInput() {
	// Si el mando esta prendido, entonces establecer todos los valores de las variables en base al valor del mando.
	if (MandON) {
		dx = map(stick.getSlider("Xder").getValue(), -1, 1, -180, 180);
		dy = map(stick.getSlider("Yder").getValue(), -1, 1, -180, 180);
		mpx = map(stick.getSlider("Xisq").getValue(), -1, 1, -1, 1);
		mpy = map(stick.getSlider("Yisq").getValue(), -1, 1, -1.8, 1.8);
		jumpButtonPressed = stick.getButton("Bta").pressed();
		btxpresOn = stick.getButton("Btx").pressed();
		rbpresOn = stick.getButton("Rb").pressed();
		lbpresOn = stick.getButton("Lb").pressed();
		BackOn = stick.getButton("Back").pressed();
	}
}

// No tengo ni idea que hace esto
void MandoGlobal () {
  getUserInput(); // Polling the input device

  //menu 
  posX += mpx;

  //movimiento incluyendo el tp
  if (posY >= 300 && posY <= 540 ) {
    posY += mpy * 8; //sensivilidad
  } else if (posY < 300) {
    posY = 540;
  } else if (posY > 540) {
    posY = 300;
  }
   if(BackOn){
       pause = false;
        println(BackOn+ "a"+ random(0,100));
      }
  //fill(0, 0, 0);// referencia
  //rect(posX, posY, 20, 20);
}
