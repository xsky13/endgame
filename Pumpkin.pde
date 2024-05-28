class Pumpkin {
    float x;
    float y = height - 180;

    float pumpkinWidth = pumpkin.width;
    float pumpkinHeight = pumpkin.height;

    long collisionTime = 0;

    Pumpkin(float x) {
        this.x = x;
    }

    // dibujar el hongo
    void display() {
        image(pumpkin, this.x, y);
    }

    void detectCollisionWithPlayer(Player player, Pumpkin pumpkin, int currentindex) {
        // Calcular los lados del jugador.
        float currentLeftSide = x - pumpkinWidth/2;
        float currentRightSide = x + pumpkinWidth/2;
        float currentTopSide = y - pumpkinHeight/2;
        float currentBottom = y + pumpkinHeight/2;
        
        // Calcular los lados del jugador.
        float playerLeftSide = player.position.x - player.playerWidth / 2;
        float playerRightSide = player.position.x + player.playerWidth / 2;
        float playerTopSide = player.position.y - player.playerHeight / 2;
        float playerBottom = player.position.y + player.playerHeight / 2;
        
        // Variables booleanas que determinan si hay colision en el eje x eje y.
        boolean collisionX = currentRightSide >= playerLeftSide && currentLeftSide <= playerRightSide;
        boolean collisionY = currentBottom >= playerTopSide && currentTopSide <= playerBottom;
        
        // hay colision
        if (collisionX && collisionY) {
            // establecer el tiempo en que hubo una colision
            long currentTime = millis();
            pumpkinCollisionTime = currentTime;

            // Si hay colision, el jugador inflige mas daño por 5 segundos
            player.damage = 10;    

            // elinimar el zapallo del array
            pumpkins = (Pumpkin[]) subset(pumpkins, 1);
        }
    }
}