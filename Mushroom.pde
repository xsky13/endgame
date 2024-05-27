class Mushroom {
    float x;
    float y = height - 180;

    float mushroomWidth = mushroom.width;
    float mushroomHeight = mushroom.height;

    boolean isCollisioning;

    Mushroom(float x) {
        this.x = x;
        isCollisioning = false;
    }

    // dibujar el hongo
    void display() {
        image(mushroom, this.x, y);
    }

    void detectCollisionWithPlayer(Player player, Mushroom mushroom) {
        float currentLeftSide = x - mushroomWidth/2;
        float currentRightSide = x + mushroomWidth/2;
        float currentTopSide = y - mushroomHeight/2;
        float currentBottom = y + mushroomHeight/2;
        
        // calcular los lados del enemigo
        float enemyLeftSide = player.position.x - player.playerWidth / 2;
        float enemyRightSide = player.position.x + player.playerWidth / 2;
        float enemyTopSide = player.position.y - player.playerHeight / 2;
        float enemyBottom = player.position.y + player.playerHeight / 2;
        
        // ver si hay colision
        boolean collisionX = currentRightSide >= enemyLeftSide && currentLeftSide <= enemyRightSide;
        boolean collisionY = currentBottom >= enemyTopSide && currentTopSide <= enemyBottom;
        
        // hay colision
        if (collisionX && collisionY) {
            // si la vida del jugador es menor o igual a 80 agregarle a su vida
            // si esta colisionando, el hongo va a desaparecer
            if (player.health <= 80) {
                long currentTime = millis();
                mushroomCollisionTime = currentTime;

                player.health += 20;
                isCollisioning = true;

                // eliminar el hongo
                mushrooms = (Mushroom[]) subset(mushrooms, 1);
            } else {
                // si la vida del jugador no  es menor o igual a 80 no puede agarrar el hongo
                isCollisioning = false;
            }
        } else {
            isCollisioning = false;
        }
    }
}