int waitTime = 550;
int waitTime2 = 550;

int startTime = 550; // inicio del sonido del ataque
int startTime2 = 550;// inicio del sonido del move pasto

boolean soundPlayed = false;
boolean soundPlayed2 = false;

boolean atackIsSounding; // variable pública para el sonido
boolean jumpIsSounding; // variable de salto publica
boolean WarMusic; // musica que se escucha en el combate 
boolean moveIsSounding; // var de movimiento de jugadores publica

SoundFile sound; //música fondo
SoundFile[] atkSounds; //sonido ataque
SoundFile Salto; // sonido de salto
SoundFile mover; //sonido de pasto movimiento
SoundFile EpicWar;//sonido de batalla 
void sound() {
	//sonidos ataque
	atkSounds = new SoundFile[7];
	for (int i = 0; i < atkSounds.length; i++) {
		atkSounds[i] = new SoundFile(this, "./assets/Fx/" + (i + 1) + ".mp3");
	}
	mover = new SoundFile(this, "./assets/Fx/rustling.mp3");
	Salto = new SoundFile(this, "./assets/Fx/jump.mp3");
	sound = new SoundFile(this, "MedievalLofi.mp3"); //música de fondo
	EpicWar = new SoundFile(this, "./assets/Fx/epicWar.mp3");
	// EpicWar.play();
}


void soundFx() {
	if (jumpIsSounding) {
		Salto.play();
		jumpIsSounding = false;
	}
	if (moveIsSounding) {
		if (!soundPlayed2) {
			mover.play();
			moveIsSounding = false;
			soundPlayed2 = true;
			startTime2 = millis();
		}
		
		if (soundPlayed2 && millis() - startTime2 >= waitTime2) {
			soundPlayed2 = false;
		}
  	}
	if (atackIsSounding) {
		//sonido de ataque con random
		if (!soundPlayed) {
			int randomIndex = int(random(atkSounds.length));
			atkSounds[randomIndex].play();
			soundPlayed = true;
			startTime = millis();
		}

		if (soundPlayed && millis() - startTime >= waitTime) {
			soundPlayed = false;
		}
	}
}
