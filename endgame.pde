// Estado del juego
String state = "start";

// Fuente utilizada
PFont mainFont;

// Graficos que se cargan antes del loop
PGraphics staticScene;

// imagenes
PImage ground;
PImage groundSmall;
PImage groundElevation;
PImage grass;
PImage grassSmall;
PImage grassYellow;
PImage bridge;
PImage water;
PImage foam;
PImage foamWater;

PImage mushroom;

PImage towerRed;
PImage towerBlue;

PImage cloud1;
PImage cloud2;
PImage cloud3;

// Jugadores
Player player;
Player player2;
Player[] players = new Player[2];

// arboles y hongos
Tree tree;
Tree tree2;
Mushroom[] mushrooms = new Mushroom[1];
Mushroom[] usedMushrooms = new Mushroom[0];

// Se almacenan valores asociados con llaves, la llave siendo tipo integer (la tecla presionada), y su valor es si ha sido presionado o no
// Su valor se establece en keyPressed() y keyReleased()
// Intente hacer lo mismo con un array (boolean[] keys = new boolean[256]), y aunque esto funcionaba, el juego andaba mucho mas lento.
HashMap<Integer, Boolean> keys = new HashMap<Integer, Boolean>();

// Los valores de las teclas para cada jugador
int[] playerOneKeys = {87, 65, 68, 81};
int[] playerTwoKeys = {38, 37, 39, 16};


void setup() {
    fullScreen();

    mainFont = createFont("data/fonts/Jersey15-Regular.ttf", 70);

    tree = new Tree(width - 670, height - 350);
    tree2 = new Tree(180, height - 350);

    // Cargar imagenes
    ground = loadImage("data/backgrounds/ground.png");
    groundSmall = loadImage("data/backgrounds/ground_small.png");
    groundElevation = loadImage("data/backgrounds/groundElevation.png");

    grassYellow = loadImage("data/backgrounds/grass_yellow.png");
    grass = loadImage("data/backgrounds/grass.png");
    grassSmall = loadImage("data/backgrounds/grassSmall.png");
    bridge = loadImage("data/bridge.png");
    water = loadImage("data/water.png");
    foam = loadImage("data/foam.png");
    foamWater = loadImage("data/foamWater.png");

    mushroom = loadImage("data/mushroom.png");

    cloud1 = loadImage("data/backgrounds/cloud_1.png");
    cloud2 = loadImage("data/backgrounds/cloud_2.png");
    cloud3 = loadImage("data/backgrounds/cloud_3.png");

    towerRed = loadImage("data/tower_red.png");
    towerBlue = loadImage("data/tower_blue.png");

    // cargar los hongos
    for (int i = 0; i < mushrooms.length; i++) {
        mushrooms[i] = new Mushroom(random(1, width));
    }

    players[0] = new Player(100, height - 170, 1, playerOneKeys);
    players[1] = new Player(width - 100, height - 170, 2, playerTwoKeys);

	// todas las imagenes estaticas las cargamos y dibujamos en el setup() para que no se laguee en draw()
    staticScene = createGraphics(width, height);
    staticScene.beginDraw();
    staticScene.background(57, 217, 237); // Background color

    // la espuma del agua
    for (int i = 0; i < 60; i++) {
      	staticScene.image(foam, ground.width + (i * 20), height - 205);
    }

    // agua
    staticScene.fill(2, 153, 193);
    staticScene.noStroke();
    staticScene.rect(0, height - 200, width, 200);

	// nubes
    staticScene.pushMatrix();
    staticScene.scale(2, 2);
    staticScene.image(cloud1, 100, 220);
    staticScene.image(cloud2, 500, 120);
    staticScene.image(cloud3, 800, 200);
    staticScene.popMatrix();

	// espuma del primer bloque
	staticScene.image(foam, ground.width - foam.width + 12, height - 205);
    staticScene.image(foam, ground.width - foam.width + 12, height - 205 + foam.height);
    staticScene.image(foam, ground.width - foam.width + 12, height - 205 + foam.height * 2);
	// primer bloque con pasto
    staticScene.image(ground, 0, height - 250);
    staticScene.image(grass, 0, height - 250);

	// puente
    staticScene.image(bridge, ground.width, height - 170);
    staticScene.image(bridge, ground.width + bridge.width, height - 170);

	// espuma de segundo bloque
	staticScene.image(foam, ground.width + (bridge.width*2) - 10, height - 205);
    staticScene.image(foam, ground.width + (bridge.width*2) - 10, height - 205 + foam.height);
    staticScene.image(foam, ground.width + (bridge.width*2) - 10, height - 205 + foam.height * 2);

	staticScene.image(foam, (ground.width + foam.width*2 + 15) + (bridge.width*2), height - 205);
    staticScene.image(foam, (ground.width + foam.width*2 + 15) + (bridge.width*2), height - 205 + foam.height);
    staticScene.image(foam, (ground.width + foam.width*2 + 15) + (bridge.width*2), height - 205 + foam.height * 2);

	// segundo bloque, con pasto amarillo
    staticScene.image(ground, ground.width + (bridge.width * 2), height - 250);
    staticScene.image(grassYellow, ground.width + (bridge.width * 2), height - 250);
	
	// puente de piedra, con su espuma
    staticScene.image(foam, (ground.width*2) + (bridge.width*2), height - 202 + foam.height);
    staticScene.image(foam, (ground.width*2) + (bridge.width*2) + foam.width, height - 202 + foam.height);
    staticScene.image(groundElevation, (ground.width*2) + (bridge.width*2), height - 170);

	// espuma de bloque 3
	staticScene.image(foam, (ground.width*2) + (bridge.width*2) + groundElevation.width - 10, height - 205);
    staticScene.image(foam, (ground.width*2) + (bridge.width*2) + groundElevation.width - 10, height - 205 + foam.height);
    staticScene.image(foam, (ground.width*2) + (bridge.width*2) + groundElevation.width - 10, height - 205 + foam.height * 2);

    staticScene.image(foam, (ground.width*2) + (bridge.width*2) + groundElevation.width + (foam.width*3) + 53, height - 205);
    staticScene.image(foam, (ground.width*2) + (bridge.width*2) + groundElevation.width + (foam.width*3) + 53, height - 205 + foam.height);
    staticScene.image(foam, (ground.width*2) + (bridge.width*2) + groundElevation.width + (foam.width*3) + 53, height - 205 + foam.height * 2);
	// tercer bloque
    staticScene.image(groundSmall, (ground.width * 2) + (bridge.width * 2) + groundElevation.width, height - 250);
    staticScene.image(grassSmall, (ground.width * 2) + (bridge.width * 2) + groundElevation.width, height - 250);
    staticScene.image(groundSmall, (ground.width * 2) + (bridge.width * 2) + groundElevation.width + groundSmall.width, height - 250);
    staticScene.image(grassSmall, (ground.width * 2) + (bridge.width * 2) + groundElevation.width + groundSmall.width, height - 250);
    
	// puente
	staticScene.image(bridge, (ground.width * 2) + (bridge.width * 2) + groundElevation.width + groundSmall.width * 2, height - 170);
    
	// espuma para cuarto bloque de piedra
	staticScene.image(foam, (ground.width*2) + (bridge.width*2) + groundElevation.width + groundSmall.width*2 + bridge.width - 10, height - 205);
    staticScene.image(foam, (ground.width*2) + (bridge.width*2) + groundElevation.width + groundSmall.width*2 + bridge.width - 10, height - 205 + foam.height);
    staticScene.image(foam, (ground.width*2) + (bridge.width*2) + groundElevation.width + groundSmall.width*2 + bridge.width - 10, height - 205 + foam.height * 2);
	// cuarto bloque
	staticScene.image(ground, (ground.width * 2) + (bridge.width * 2) + groundElevation.width + groundSmall.width * 2 + bridge.width, height - 250);
    staticScene.image(ground, (ground.width * 3) + (bridge.width * 2) + groundElevation.width + groundSmall.width * 2 + bridge.width, height - 250);

	// torres
    staticScene.image(towerRed, 50, height - 350);
    staticScene.image(towerBlue, width - 150, height - 350);

    staticScene.image(groundElevation, width/2, height - 400);
    staticScene.image(groundElevation, width/2 - groundElevation.width/2 - bridge.width, height - 400);
    staticScene.image(bridge, width/2 - groundElevation.width/2, height - 400);

    staticScene.endDraw();
}

void draw() {
    background(0);
    
    // Dibujar cada escena basado en el estado
    if (state == "start") {
      startScene();
    } else if (state == "game") {
      gameScene();
    } else if (state == "end") {
      endScene();
    }
}


// Al presionar cada tecla se los agrega al HashMap keys con un valor de verdadero
void keyPressed() {
    keys.put(keyCode, true);
}

// Al soltar la tecla el valor en el HashMap es eliminado o puesto a falso
void keyReleased() {
    keys.put(keyCode, false);
}
