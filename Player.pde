class Player {
    // Posicion y velocidad del jugador.
    PVector position;
    PVector speed = new PVector(0, 0);
    
    // Array de imagenes.
    PImage[] attackImages = new PImage[6];
    PImage[] idleImages = new PImage[6];
    PImage[] movingImages = new PImage[6];
    
    String dir;
    String playerFolder;

    // ID de jugador.
    int playerNumber;
    
    // Estados de ataque, movimiento, y colision.
    boolean isAttacking = false;
    boolean isMoving = false;
    boolean isJumping = false;
    boolean isCollisioning = false;
    
    // Indice de imagen para mostrar.
    int index = 0;
    // Contador de frames.
    int frameCounter = 0;
    // Frames de demora entre cambio de imagen.
    int frameDelay = 6;

    // Tiempo en el que se produjo el ataque.
    long attackTime = 0;
    // Duracion del ataque.
    int attackDuration = 500;
    
    // ancho y alto del jugador
    float playerWidth;
    float playerHeight;

    // Valor que determina si el jugador esta en la posicion x de las rocas flotantes
    boolean isOnRockXpos = false;
    
    int health = 100;
    int damage = 5;

    // las tecladas utilizadas por el jugador
    int[] keyCodes;
    
    Player(float x, float y, int playerNumber, int[] keyCodes) {
        this.position = new PVector(x, y);
        this.playerNumber = playerNumber;
        this.health = health;
        this.health = health;
        this.playerWidth = playerWidth;
        this.playerHeight = playerHeight;
        this.keyCodes = keyCodes;
        this.damage = damage;
        
        // El jugador no puede salir de la pantalla.
        constrain(this.position.x, 0 + this.playerWidth / 2, width - this.playerWidth / 2);
        
        // Encontrar el numero correcto del carpeta
        playerFolder = playerNumber == 1 ? "player1" : "player2";
        
        // Cargar todas las imagenes.
        for (int i = 0; i < attackImages.length; i++) {
            attackImages[i] = loadImage("./data/players/" + playerFolder + "/attack/attack_" + i + ".png");
        }
        
        for (int i = 0; i < idleImages.length; i++) {
            idleImages[i] = loadImage("./data/players/" + playerFolder + "/idle/idle_" + i + ".png");
        }
        
        for (int i = 0; i < movingImages.length; i++) {
            movingImages[i] = loadImage("./data/players/" + playerFolder + "/moving/moving_" + i + ".png");
        }
    }
    
    // deteccion de colision en los bordes
    void checkBorders() {
        // Si la posicion del jugador - su anchura es menor o igual al comienzo de la pantalla entonces invertir su velocidad
        if (this.position.x - this.playerWidth/2 <= 0) {
            speed.set( -speed.x, speed.y);
            this.position.x = 0 + this.playerWidth/2;
        }
        
        // Si la posicion del jugador + su anchura es mayor o igual al tamaño de la pantalla entonces invertir su velocidad
        if (this.position.x + this.playerWidth/2 >= width) {
            speed.set( -speed.x, speed.y);
            this.position.x = width - this.playerWidth/2;
        }
    }

    // Dibuja al jugador. Toma como parametro un array de imagenes, y las muestra como secuencia por 6 segundos
    void drawPlayer(PImage[] images) {
        // se incrementa la cuenta de frames
        frameCounter++;
        
        // hay 6 frames de delay entre cada paso de imagen (ver frameDelay).
        // Entonces, cuando ya se han pasado las frames, se incrementa el indice (index) y se consigue el modulo.
        // El modulo siempre va a dar un resto que este dentro de la longitud del array images.
        if (frameCounter >= frameDelay) {
            index = (index + 1) % images.length; 
            frameCounter = 0;
        }
        
        // Se hace un bucle por images
        for (int i = 0; i < images.length; i++) {
            pushMatrix(); 
            translate(this.position.x, this.position.y);
            // si la direccion del jugador es hacia la izquiera, entonces cambiar el lado hacia donde esta mirando
            scale(dir == "left" ? - 1 : 1, 1);
            // dibujar la imagen con el indice correcto
            image(images[index], 0, 0);
            popMatrix();
        }
        
        // barra de vida arriba del jugador
        fill(255, 0, 0);
        rectMode(CENTER);
        rect(this.position.x - playerWidth / 2 + 40, this.position.y - playerHeight / 2, this.health / 1.5, 10, 10);
        rectMode(CORNER);

        // barra de mas daño arriba del jugador
        if (this.damage == 10) {
            fill(100, 0, 255);
            rectMode(CENTER);
            // la longitud del rect empieza en 50, y se le van restando los milisegundos - el tiempo en el que hubo una colision. Esto esta en milisegundos, asi que hay que dividirlo por 100
            rect(this.position.x - playerWidth / 2 + 40, (this.position.y - playerHeight / 2) - 10, 50 - ((millis() - pumpkinCollisionTime)/100), 10, 10);
            rectMode(CORNER);
        } 
        
        // Se establecen los valores de la anchura y altura del jugador.
        // Esto se hace dentro de esta funcion porque las imagenes pueden tener tamaños distintos en cada frame
        playerWidth = images[index].width;
        playerHeight = images[index].height;
    }
    
    // muestra al jugador en base a si esta atacando, si esta moviendo, o si no esta haciendo ninguno
    // se usa la funcion drawPlayer() para mostrar una secuencia de imagenes dependiendo de que accion este ejectutando 
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
    
    // Se aplica la gravedad
    void applyGravity() {
        speed.add(0, 1);
        this.position.add(speed);

        // Si el jugador esta en el suelo
        if (this.position.y >= height - 180) {
            this.position.y = height - 180;
            speed.set(speed.x, 0);
        } 
        // el jugador esta adentro de la posicion x de las rocas flotantes
        else if (this.position.x + this.playerWidth/2 >= width/2 - groundElevation.width/2 - bridge.width && this.position.x - this.playerWidth/2 <= width/2 + groundElevation.width) {
            // el jugador tambien esta en la posicion y de las rocas flotantes
            if (this.position.y >= height - 401 && this.position.y <= height - 400) {
                this.position.y = height - 401;
                speed.set(speed.x, 0);
                isOnRockXpos = true;
            } else if (this.position.y >= height - 340 + groundElevation.height) {
                // el jugador esta abajo del puente
                speed.set(speed.x, 1);
            } else {
                isOnRockXpos = false;
            }
        } else {
            isOnRockXpos = false;
        }
    }

    // Actualizar las variables de sonido
    void updateSoundVariables() {
        atackIsSounding = isAttacking;
        jumpIsSounding = isJumping;
        moveIsSounding = isMoving;
    }
    
    // Logica de movimiento.
    void move() {
        // Se lee el HashMap keys para determinar que tecla ha sido presionada
        // keys.getOrDefaut() toma como parametro un valor del HashMap. Si esta en el HashMap se toma como verdadero, si no toma como predeterminado el segundo parametro (false)
        if (keys.getOrDefault(this.keyCodes[0], false) && (this.position.y == height - 180 || isOnRockXpos)) {
            speed.set(speed.x, -16);
            isMoving = false;
            isJumping = true;
        } else if (keys.getOrDefault(this.keyCodes[1], false)) {
            speed.set(-7, speed.y);
            dir = "left";
            isMoving = true;
            isJumping = false;
        } else if (keys.getOrDefault(this.keyCodes[2], false)) {
            speed.set(7, speed.y);
            dir = "right";
            isMoving = true;
            isJumping = false;
        } else {
            isMoving = false;
            isJumping = false;
            speed.set(0, speed.y);
        }

        // Si el mando esta prendido, mover con el mando.
        if (MandON && this.playerNumber == 1) {
            // Movimiento en base al eje x.
            this.position.add(mpx*10, 0);

            // Determinar la direccion del jugador basado en mpx.
            if (mpx > 0) {
                dir = "right";
                isMoving = true;
            }
            if (mpx < 0) {
                dir = "left";
                isMoving = true;
            }
            if (mpx == 0) {
                isMoving = false;
            }

            // Si se apreta el boton de salto, y el jugador esta en el suelo o en la roca flotante
            if (jumpButtonPressed && (this.position.y == height - 180 || isOnRockXpos) || rbpresOn) {
                speed.set(speed.x, -16);
                isMoving = false;
            }
        }
        
        // Incrementar la posicion con la velocidad
        this.position.add(speed);
    } 

    // Resetear el daño incrementado por el zapallo.
    void updateDamage() {
        // Si ha pasado 5 segundos desde que se agarro el zapallo, entonces resetar el daño.
        if (millis() - pumpkinCollisionTime >= 5000 && pumpkinCollisionTime != 0) {
            if (this.damage == 10) {
                this.damage = 5;
            }     
        }
    }
    
    // Funcion de ataque.
    void attack(Player enemy) {
        // Si el mando esta prendido y si el jugddor actual es el primero.
        if (MandON && this.playerNumber == 1) {
            // Si se han presionado los botones correctos.
            if (btxpresOn || lbpresOn) {
                // Establecer el tiempo en el que hubo un ataque al tiempo actual.
                long currentTime = millis();
                attackTime = currentTime;
                isAttacking = true;  

                // Si hay colision y ataque, infligir daño.
                if (isAttacking && isCollisioning) {
                    enemy.health -= this.damage;  
                } 
            }
        }

        // Si se ha presionado la tecla correcta, aplicar logica de daño.
        if (keyPressed && keys.getOrDefault(this.keyCodes[3], false)) {
            // Establecer el tiempo en el que hubo un ataque al tiempo actual.
            long currentTime = millis();
            attackTime = currentTime;
            isAttacking = true;

            // Si hay colision, entonces aplicar knockback y restarle vida al enemigo.
            if (isCollisioning) {
                // el enemigo esta a la derecha del jugador
                if (enemy.position.x > this.position.x) {
                    // Agregare a la posicion al enemigo.
                    enemy.position.x += 30;
                }             
                // el enemigo esta a la izquierda del jugador 
                else {
                    // Restarle de la posicion al enemigo.
                    enemy.position.x -= 30;
                }
                // Sacarle la salud al enemigo.
                enemy.health -= this.damage;
            }
        }
        
        // Si hay ataque, y el tiempo actual - el tiempo exacto en que se produjo el ataque es mayor o igual a la duracion del ataque, entonces ya termino el ataque.
        if (isAttacking && millis() - attackTime >= attackDuration) {
            isAttacking = false;
        }
    }
    
    // Deteccion de colisiones entre jugadores.
    void detectCollisionWithPlayer(Player enemy) {
        // calcular los lados del jugador
        float currentLeftSide = this.position.x - this.playerWidth / 2;
        float currentRightSide = this.position.x + this.playerWidth / 2;
        float currentTopSide = this.position.y - this.playerHeight / 2;
        float currentBottom = this.position.y + this.playerHeight / 2;
        
        // calcular los lados del enemigo
        float enemyLeftSide = enemy.position.x - enemy.playerWidth / 2;
        float enemyRightSide = enemy.position.x + enemy.playerWidth / 2;
        float enemyTopSide = enemy.position.y - enemy.playerHeight / 2;
        float enemyBottom = enemy.position.y + enemy.playerHeight / 2;
        
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
