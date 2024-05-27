class Pumpkin {
    float x;
    float y = height - 180;

    float pumpkinWidth = pumpkin.width;
    float pumpkinHeight = pumpkin.height;

    boolean isCollisioning;
    long collisionTime = 0;

    Pumpkin(float x) {
        this.x = x;
        isCollisioning = false;
    }

    // dibujar el hongo
    void display() {
        image(pumpkin, this.x, y);
    }

    void detectCollisionWithPlayer(Player player, Pumpkin pumpkin, int currentindex) {
        float currentLeftSide = x - pumpkinWidth/2;
        float currentRightSide = x + pumpkinWidth/2;
        float currentTopSide = y - pumpkinHeight/2;
        float currentBottom = y + pumpkinHeight/2;
        
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
            long currentTime = millis();
            pumpkinCollisionTime = currentTime;

            player.damage = 10;    
            isCollisioning = true;

            // elinimar el zapallo del array
            pumpkins = (Pumpkin[]) subset(pumpkins, 1);
        } else {
            isCollisioning = false;
        }
    }
}