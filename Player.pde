class Player {
    PVector position;
    PVector speed;

    PImage[] attackImages = new PImage[6];
    PImage[] idleImages = new PImage[6];
    PImage[] movingImages = new PImage[6];

    String dir;
    String enemySide;
    int playerNumber;

    boolean isAttacking = false;
    boolean isMoving = false;
    boolean isCollisioning = false;

    int index = 0;
    int frameCounter = 0;
    int frameDelay = 6;
    long lastAttackTime = 0;
    int attackDuration = 500;

    float playerWidth;
    float playerHeight;

    int health = 100;

    Player(float x, float y, int playerNumber) {
        this.position = new PVector(x, y);
        this.playerNumber = playerNumber;
        this.health = health;

        constrain(this.position.x, 0, width);

        this.health = health;

        this.playerWidth = playerWidth;
        this.playerHeight = playerHeight;

        speed = new PVector(0, 0);

        String playerFolder = playerNumber == 1 ? "player1" : "player2";

        for (int i = 0; i < attackImages.length; i++) {
            attackImages[i] = loadImage("./assets/players/" + playerFolder + "/attack/attack_" + i + ".png");
        }

        for (int i = 0; i < idleImages.length; i++) {
            idleImages[i] = loadImage("./assets/players/" + playerFolder + "/idle/idle_" + i + ".png");
        }

        for (int i = 0; i < movingImages.length; i++) {
            movingImages[i] = loadImage("./assets/players/" + playerFolder + "/moving/moving_" + i + ".png");
        }
    }

    void drawPlayer(PImage[] images) {
        frameCounter++;
        
        if (frameCounter >= frameDelay) {
            index = (index + 1) % images.length; 
            frameCounter = 0;
        }

        for (int i = 0; i < images.length; i++) {
            pushMatrix(); 
            translate(this.position.x, this.position.y);
            scale(dir == "left" ? -1 : 1, 1);
            image(images[index], 0, 0);
            popMatrix();
        }

        
        playerWidth = images[index].width;
        playerHeight = images[index].height;
    }

    void checkBorders() {
        if (this.position.x <= 0) {
            speed.set(-speed.x, speed.y);
            this.position.x = 0;
        }

        if (this.position.x >= width) {
            speed.set(-speed.x, speed.y);
            this.position.x = width;
        }
    }

    void display() {
        imageMode(CENTER);
        if (isAttacking) {
            drawPlayer(attackImages);
        } else if (isMoving) {
            drawPlayer(movingImages);
        } else {
            drawPlayer(idleImages);
        }
        imageMode(CORNERS);
    }

    void applyGravity() {
        speed.add(0, 1);
        this.position.add(speed);
        
        if (this.position.y >= height - 170) {
            this.position.y = height - 170;
            speed.set(speed.x, 0);
        }
    }

    void move(Player enemy) {
        if (this.playerNumber == 1) {
            enemySide = "left";
            if (keyPressed) {
                if (key == 'w' && this.position.y == height - 170) {
                    speed.set(speed.x, -15);
                    isMoving = false;
                } 
                if (key == 'a') {
                    speed.set(-7, speed.y);
                    dir = "left";
                    isMoving = true;
                } 
                if (key == 'd') {
                    speed.set(7, speed.y);
                    dir = "right";
                    isMoving = true;
                } 
            } else {
                isMoving = false;
                speed.set(0, speed.y);
            }
        } else {
            enemySide = "right";
            if (keyPressed) {
                if (keyCode == UP && this.position.y == height - 170) {
                    speed.set(speed.x, -15);
                    isMoving = false;
                } 
                if (keyCode == LEFT) {
                    speed.set(-7, speed.y);
                    dir = "left";
                    isMoving = true;
                } 
                if (keyCode == RIGHT) {
                    speed.set(7, speed.y);
                    dir = "right";
                    isMoving = true;
                } 
            } else {
                isMoving = false;
                speed.set(0, speed.y);
            } 
        }

        if (this.position.x + (this.playerWidth/2) <= enemy.position.x - (enemy.playerWidth/2)) {
            enemySide = "left";
        } else if (this.position.x - (this.playerWidth/2) >= enemy.position.x + (enemy.playerWidth/2)) {
            enemySide = "right";
        }

        this.position.add(speed);
    }

    void attackAnimation() {
        if (this.playerNumber == 2 && keyPressed && keyCode == 16) {
            long currentTime = millis();
            lastAttackTime = currentTime;
            isAttacking = true;
        } else if (this.playerNumber == 1 && keyPressed && key == 'q') {
            long currentTime = millis();
            lastAttackTime = currentTime;
            isAttacking = true;
        }

        if (isAttacking && millis() - lastAttackTime >= attackDuration) {
            isAttacking = false;
        }
    }

    void attack(Player enemy) {
        if (isAttacking && isCollisioning) {
            enemy.health -= 1;
        }
    }

    void detectCollisionWithPlayer(float enemyWidth, float enemyHeight, PVector enemyPos) {
        // calcular los lados del jugador
        float currentLeftSide = this.position.x - this.playerWidth / 2;
        float currentRightSide = this.position.x + this.playerWidth / 2;
        float currentTopSide = this.position.y - this.playerHeight / 2;
        float currentBottom = this.position.y + this.playerHeight / 2;

        // calcular los lados del enemigo
        float enemyLeftSide = enemyPos.x - enemyWidth / 2;
        float enemyRightSide = enemyPos.x + enemyWidth / 2;
        float enemyTopSide = enemyPos.y - enemyHeight / 2;
        float enemyBottom = enemyPos.y + enemyHeight / 2;

        // ver si hay colision
        boolean collisionX = currentRightSide >= enemyLeftSide && currentLeftSide <= enemyRightSide;
        boolean collisionY = currentBottom >= enemyTopSide && currentTopSide <= enemyBottom;

        if (collisionX && collisionY) {
            isCollisioning = true;

            // calcular la superposicion de ambos ejes
            float overlapLeft = currentRightSide - enemyLeftSide;
            float overlapRight = enemyRightSide - currentLeftSide;
            float overlapTop = currentBottom - enemyTopSide;
            float overlapBottom = enemyBottom - currentTopSide;

            // encontrar la superposicion mas pequena en ambos ejes
            float minOverlapX = min(overlapLeft, overlapRight);
            float minOverlapY = min(overlapTop, overlapBottom);

            // si la superposicion mas pequena es en el eje x, entonces hay colision ahi
            if (minOverlapX < minOverlapY) {
                // si la superposicion es mas pequena del lado izquierdo, entonces parar el movimiento
                if (overlapLeft < overlapRight) {
                    this.position.x = enemyLeftSide - this.playerWidth / 2;
                } else {
                    this.position.x = enemyRightSide + this.playerWidth / 2;
                }
                // parar el movimiento
                this.speed.x = 0;  
            } else {
                // si la superposicion es mas pequena arriba, entonces parar el movimiento
                if (overlapTop < overlapBottom) {
                    this.position.y = enemyTopSide - this.playerHeight / 2;
                } else {
                    this.position.y = enemyBottom + this.playerHeight / 2;
                }
                // parar el movimiento
                this.speed.y = 0;  
            }
        } else {
            isCollisioning = false;
        }
    }

}
