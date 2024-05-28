class Mushroom {
    float x;
    float y = height - 180;

    // Anchura y altura del hongo.
    float mushroomWidth = mushroom.width;
    float mushroomHeight = mushroom.height;

    Mushroom(float x) {
        this.x = x;
    }

    // dibujar el hongo
    void display() {
        image(mushroom, this.x, y);
    }

    // Deteccion de colision con el jugador.
    void detectCollisionWithPlayer(Player player, Mushroom mushroom) {
        // Calcular lados del hongo.
        float currentLeftSide = x - mushroomWidth/2;
        float currentRightSide = x + mushroomWidth/2;
        float currentTopSide = y - mushroomHeight/2;
        float currentBottom = y + mushroomHeight/2;
        
        // Calcular los lados del jugador.
        float playerLeftSide = player.position.x - player.playerWidth / 2;
        float playerRightSide = player.position.x + player.playerWidth / 2;
        float playerTopSide = player.position.y - player.playerHeight / 2;
        float playerBottom = player.position.y + player.playerHeight / 2;
        
        // ver si hay colision
        boolean collisionX = currentRightSide >= playerLeftSide && currentLeftSide <= playerRightSide;
        boolean collisionY = currentBottom >= playerTopSide && currentTopSide <= playerBottom;
        
        // Hay colision.
        if (collisionX && collisionY) {
            // si la vida del jugador es menor o igual a 80 agregarle a su vida
            // si esta colisionando, el hongo va a desaparecer, y despues de 10 segundos volver a aparecer.
            if (player.health <= 80) {
                // establecer el tiempo en que hubo una colision
                long currentTime = millis();
                mushroomCollisionTime = currentTime;

                player.health += 20;

                // eliminar el hongo
                mushrooms = (Mushroom[]) subset(mushrooms, 1);
            } 
        }
    }
}