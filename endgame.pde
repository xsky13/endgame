String state = "start";
PFont mainFont;
PImage background;

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

Player player;
Player player2;

Player[] players = new Player[2];

Tree[] trees = new Tree[8];


void setup() {
    fullScreen();

    mainFont = createFont("assets/fonts/Jersey15-Regular.ttf", 70);

    ground = loadImage("assets/backgrounds/ground.png");
    groundSmall = loadImage("assets/backgrounds/ground_small.png");
    groundElevation = loadImage("assets/backgrounds/groundElevation.png");

    grassYellow = loadImage("assets/backgrounds/grass_yellow.png");
    grass = loadImage("assets/backgrounds/grass.png");
    grassSmall = loadImage("assets/backgrounds/grassSmall.png");
    bridge = loadImage("assets/bridge.png");
    water = loadImage("assets/water.png");
    foam = loadImage("assets/foam.png");
    foamWater = loadImage("assets/foamWater.png");

    towerRed = loadImage("assets/tower_red.png");
    towerBlue = loadImage("assets/tower_blue.png");

    players[0] = new Player(100, 800, 1);
    players[1] = new Player(800, 800, 2);

    for (int i = 0; i < trees.length; i++) {
      trees[i] = new Tree(random(width), height - 375);
    }
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