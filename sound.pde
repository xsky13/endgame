int attackSoundWaitTime = 500;
int moveSoundWaitTime = 500;

int attackSoundStartTime = 500; // inicio del sonido del ataque
int moveSoundStartTime = 500;// inicio del sonido del move pasto

boolean attackSoundPlayed = false;
boolean moveSoundPlayed = false;


void soundFx() {
	if (players[0].isJumping || players[1].isJumping) {
		jumpFile.play();
	}

	// Si alguno de los jugadores se esta moviendo
	if (players[0].isMoving || players[1].isMoving) {
		// Si hay movimiento, y el sonido no esta siendo producido:
		if (!moveSoundPlayed) {
			moveFile.play();
			// Se establecen los valores de tiempo relacionados con el sonido
			moveSoundPlayed = true;
			moveSoundStartTime = millis();
		}
		
		// Si el sonido esta siendo producido y el tiempo actual restado por el tiempo en el que se produjo el comienzo de movimiento es menor o igual al tiempo que deberia durar el sonido de movimiento, se para el sonido.
		if (moveSoundPlayed && millis() - moveSoundStartTime >= moveSoundWaitTime) {
			moveSoundPlayed = false;
		}
  	}

	if (players[0].isAttacking || players[1].isAttacking) {
		// Si hay ataque, y el sonido no esta siendo producido:
		if (!attackSoundPlayed) {
			// Se elige un indice random de sonido para tocar.
			int randomIndex = int(random(attackSounds.length));
			attackSounds[randomIndex].play();
			// Se establecen los valores de tiempo relacionados con el sonido
			attackSoundPlayed = true;
			attackSoundStartTime = millis();
		}

		// Si el sonido esta siendo producido y el tiempo actual restado por el tiempo en el que se produjo el ataque es menor o igual al tiempo que deberia durar el ataque, se para el sonido.
		if (attackSoundPlayed && millis() - attackSoundStartTime >= attackSoundWaitTime) {
			attackSoundPlayed = false;
		}
	}
}
