String state = "start";
PFont mainFont;
PImage background;

PGraphics staticScene;


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

PImage towerRed;
PImage towerBlue;

PImage cloud1;
PImage cloud2;
PImage cloud3;

Player player;
Player player2;

Player[] players = new Player[2];

Tree[] trees = new Tree[8];


void setup() {
    fullScreen();

    mainFont = createFont("data/fonts/Jersey15-Regular.ttf", 70);

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

    cloud1 = loadImage("data/backgrounds/cloud_1.png");
    cloud2 = loadImage("data/backgrounds/cloud_2.png");
    cloud3 = loadImage("data/backgrounds/cloud_3.png");

    towerRed = loadImage("data/tower_red.png");
    towerBlue = loadImage("data/tower_blue.png");

    players[0] = new Player(100, 800, 1);
    players[1] = new Player(800, 800, 2);

    for (int i = 0; i < trees.length; i++) {
      	trees[i] = new Tree(random(width), height - 375);
    }

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

    staticScene.endDraw();
}

void draw() {
    background(0);
    if (state == "start") {
      startScene();
    } else if (state == "game") {
      gameScene();
    } else if (state == "end") {
      endScene();
    }
}