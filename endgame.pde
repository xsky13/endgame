// librerias
import processing.sound.*;
import org.gamecontrolplus.gui.*;
import org.gamecontrolplus.*;
import net.java.games.input.*;
ControlIO control;
ControlDevice stick;

boolean MandON;//variable para activar el mando mapeo, etc
boolean pause = true;

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
PImage pumpkin;

PImage towerRed;
PImage towerBlue;

PImage cloud1;
PImage cloud2;
PImage cloud3;

// Imagenes de detalle
PImage bush;
PImage stone;
PImage xThingy;
PImage arrowThingy;

// Musica de fondo.
SoundFile backgroundMusic;
// Sonidos ataque.
SoundFile[] attackSounds; 
// Sonido de salto.
SoundFile jumpFile; 
// Sonido de pasto movimiento.
SoundFile moveFile; 

// Jugadores
Player player;
Player player2;
Player[] players = new Player[2];

// arboles y hongos
Tree tree;
Tree tree2;
// Power Ups
Mushroom[] mushrooms = new Mushroom[1];
Pumpkin[] pumpkins = new Pumpkin[1];

// cosos 3d
PShape cat, espd;

// Se almacenan valores asociados con llaves, la llave siendo tipo integer (la tecla presionada), y su valor es si ha sido presionado o no
// Su valor se establece en keyPressed() y keyReleased()
// Intente hacer lo mismo con un array (boolean[] keys = new boolean[256]), y aunque esto funcionaba, el juego andaba mucho mas lento.
HashMap<Integer, Boolean> keys = new HashMap<Integer, Boolean>();

// Los valores de las teclas para cada jugador
int[] playerOneKeys = {87, 65, 68, 81};
int[] playerTwoKeys = {38, 37, 39, 16};

// Tiempo de colision con hongo y zapallo.
long mushroomCollisionTime;
long pumpkinCollisionTime;

// Imagenes de fondo de pantalla de inicio.
PImage[] wallpaperImages = new PImage[20];
// Indice de image para mostrar en el fondo de pantalla.
int wallperImageIndex = 0;

// Variables para 3D.
float transX = 300, transY = 100, transZ = 600, scaleFactor = 2;
float rotX = 60, rotY = 90;
float desaceleracion = 0.0002; // Desaceleración


void setup() {
    fullScreen(P3D);
    
    // Música de fondo.
	backgroundMusic = new SoundFile(this, "MedievalLofi.mp3"); 
    backgroundMusic.play();

    // Cargar los sonidos de ataque.
    attackSounds = new SoundFile[7];
	for (int i = 0; i < attackSounds.length; i++) {
		attackSounds[i] = new SoundFile(this, "./data/fx/" + (i + 1) + ".mp3");
	}
    // Sonido de movimiento.
	moveFile = new SoundFile(this, "./data/fx/rustling.mp3");
    // Sonido de salto.
	jumpFile = new SoundFile(this, "./data/fx/jump.mp3");

    // Cosos 3d.
    cat = loadShape("Baby_Yoda.obj"); // 3d
    espd = loadShape("espd.obj"); 

    // Funcion que lee los contenidos del archivo txt y determina si se esta usando el mando.
    loadEstadoGamepad();
    // Si el mando esta prendido, entonces llamar la funcion que consigue la configuracion del mando.
    if (MandON) {
        initializeJoystick();
    } 
    
    // Cargar fondos de pantalla.
    for (int i = 0; i < wallpaperImages.length; i++) {
        wallpaperImages[i] = loadImage("data/startWallpapers/wallpaper_" + i + ".png");
    }
    
    // Establecer la fuente.
    mainFont = createFont("data/fonts/Jersey15-Regular.ttf", 70);
    
    // Inicializar arboles.
    tree = new Tree(width - 670, height - 350);
    tree2 = new Tree(180, height - 350);
    
    // Cargar imagenes.
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
    pumpkin = loadImage("data/pumpkin.png");
    
    cloud1 = loadImage("data/backgrounds/cloud_1.png");
    cloud2 = loadImage("data/backgrounds/cloud_2.png");
    cloud3 = loadImage("data/backgrounds/cloud_3.png");
    
    towerRed = loadImage("data/tower_red.png");
    towerBlue = loadImage("data/tower_blue.png");

    bush = loadImage("data/details/bush.png");
    stone = loadImage("data/details/stone.png");
    xThingy = loadImage("data/details/xThingy.png");
    arrowThingy = loadImage("data/details/arrowThingy.png");
    
    // Crear los hongos.
    for (int i = 0; i < mushrooms.length; i++) {
        mushrooms[i] = new Mushroom(random(1, width));
    }
    
    // Crear los zapallos.
    for (int i = 0; i < pumpkins.length; i++) {
        pumpkins[i] = new Pumpkin(random(1, width));
    }
    
    // Inicializar los jugadores
    players[0] = new Player(100, height - 180, 1, playerOneKeys);
    players[1] = new Player(width - 100, height - 180, 2, playerTwoKeys);
    
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

    // arbustos.
    staticScene.image(bush, 50, height - 100);
    staticScene.image(bush, 75, height - 100);
    staticScene.image(bush, 100, height - 100);
    
    // puente
    staticScene.image(bridge, ground.width, height - 170);
    staticScene.image(bridge, ground.width + bridge.width, height - 170);
    
    // espuma de segundo bloque
    staticScene.image(foam, ground.width + (bridge.width * 2) - 10, height - 205);
    staticScene.image(foam, ground.width + (bridge.width * 2) - 10, height - 205 + foam.height);
    staticScene.image(foam, ground.width + (bridge.width * 2) - 10, height - 205 + foam.height * 2);
    
    staticScene.image(foam,(ground.width + foam.width * 2 + 15) + (bridge.width * 2), height - 205);
    staticScene.image(foam,(ground.width + foam.width * 2 + 15) + (bridge.width * 2), height - 205 + foam.height);
    staticScene.image(foam,(ground.width + foam.width * 2 + 15) + (bridge.width * 2), height - 205 + foam.height * 2);
    
    // segundo bloque, con pasto amarillo
    staticScene.image(ground, ground.width + (bridge.width * 2), height - 250);
    staticScene.image(grassYellow, ground.width + (bridge.width * 2), height - 250);

    // piedra random
    staticScene.image(stone, ground.width*2 + (bridge.width * 2) - 45, height - 210);
    
    // puente de piedra, con su espuma
    staticScene.image(foam,(ground.width * 2) + (bridge.width * 2), height - 202 + foam.height);
    staticScene.image(foam,(ground.width * 2) + (bridge.width * 2) + foam.width, height - 202 + foam.height);
    staticScene.image(groundElevation,(ground.width * 2) + (bridge.width * 2), height - 170);

    // piedras
    staticScene.image(stone, (ground.width * 2) + (bridge.width * 2) + 50, height - 182);
    staticScene.image(stone, (ground.width * 2) + (bridge.width * 2) + groundElevation.width - 50, height - 134);
    
    // espuma de bloque 3
    staticScene.image(foam,(ground.width * 2) + (bridge.width * 2) + groundElevation.width - 10, height - 205);
    staticScene.image(foam,(ground.width * 2) + (bridge.width * 2) + groundElevation.width - 10, height - 205 + foam.height);
    staticScene.image(foam,(ground.width * 2) + (bridge.width * 2) + groundElevation.width - 10, height - 205 + foam.height * 2);
    
    staticScene.image(foam,(ground.width * 2) + (bridge.width * 2) + groundElevation.width + (foam.width * 3) + 53, height - 205);
    staticScene.image(foam,(ground.width * 2) + (bridge.width * 2) + groundElevation.width + (foam.width * 3) + 53, height - 205 + foam.height);
    staticScene.image(foam,(ground.width * 2) + (bridge.width * 2) + groundElevation.width + (foam.width * 3) + 53, height - 205 + foam.height * 2);
    // tercer bloque
    staticScene.image(groundSmall,(ground.width * 2) + (bridge.width * 2) + groundElevation.width, height - 250);
    staticScene.image(grassSmall,(ground.width * 2) + (bridge.width * 2) + groundElevation.width, height - 250);
    staticScene.image(groundSmall,(ground.width * 2) + (bridge.width * 2) + groundElevation.width + groundSmall.width, height - 250);
    staticScene.image(grassSmall,(ground.width * 2) + (bridge.width * 2) + groundElevation.width + groundSmall.width, height - 250);
    
    // arbustos.
    staticScene.image(bush, (ground.width * 2) + (bridge.width * 2) + groundElevation.width + 50, height - 230);
    staticScene.image(bush, (ground.width * 2) + (bridge.width * 2) + groundElevation.width + 75, height - 230);

    staticScene.image(bush, (ground.width * 2) + (bridge.width * 2) + groundElevation.width + 200, height - 100);

    staticScene.image(bush, (ground.width * 2) + (bridge.width * 2) + groundElevation.width + 275, height - 120);
    
    // puente
    staticScene.image(bridge,(ground.width * 2) + (bridge.width * 2) + groundElevation.width + groundSmall.width * 2, height - 170);
    
    // espuma para cuarto bloque de piedra
    staticScene.image(foam,(ground.width * 2) + (bridge.width * 2) + groundElevation.width + groundSmall.width * 2 + bridge.width - 10, height - 205);
    staticScene.image(foam,(ground.width * 2) + (bridge.width * 2) + groundElevation.width + groundSmall.width * 2 + bridge.width - 10, height - 205 + foam.height);
    staticScene.image(foam,(ground.width * 2) + (bridge.width * 2) + groundElevation.width + groundSmall.width * 2 + bridge.width - 10, height - 205 + foam.height * 2);
    // cuarto bloque
    staticScene.image(ground,(ground.width * 2) + (bridge.width * 2) + groundElevation.width + groundSmall.width * 2 + bridge.width, height - 250);
    staticScene.image(ground,(ground.width * 3) + (bridge.width * 2) + groundElevation.width + groundSmall.width * 2 + bridge.width, height - 250);
    
    // torres
    staticScene.image(towerRed, 50, height - 350);
    staticScene.image(towerBlue, width - 150, height - 350);

    staticScene.image(xThingy, width - 200, height - 250);
    staticScene.image(stone, width - 300, height - 140);
    
    staticScene.image(groundElevation, width / 2, height - 400);
    staticScene.image(groundElevation, width / 2 - groundElevation.width / 2 - bridge.width, height - 400);
    staticScene.image(bridge, width / 2 - groundElevation.width / 2, height - 400);

    staticScene.image(arrowThingy, (width/2) - groundElevation.width/2 - bridge.width + 10, height - 370 - groundElevation.width/2);
    
    
    staticScene.endDraw();
}

// Funcion para mostrar cada imagen del fondo.
void wallpaper() {
    image(wallpaperImages[wallperImageIndex], 0, 0, width, height); // imagen, posx, posy, tamx, tamy
    wallperImageIndex = (wallperImageIndex + 1) % wallpaperImages.length;
}

void tresD() {
    getUserInput(); // Polling the input device
    //lights(); //si desactivo esto se ve plano el 3d
    
    //LUCES
    pointLight(35, 2, 7, 10, 10, 8); // punto de luz
    pointLight(42, 3, 5, 20, 100, 12); // punto de luz
    pointLight(41, 6, 4, 30, 200, 20); // punto de luz
    pointLight(66, 7, 8, 10, 300, 5); // punto de luz
    pointLight(156, 100, 8, 10, 300, 5); // punto de luz
    
    //3D puro
    translate(width / 2 + transX - 100, height / 2 + transY, transZ); // trasladar el 3 eje para que no se superponga
    //rotateY(radians(frameCount));
    rotateX(rotX);
    rotateY( -rotY);
    
    scale(4 + scaleFactor);
    shape(cat);
    
    rotY += dx * 0.0002;
    rotX -= dy * 0.0002; // si le pongo - se invierten los controles
}

void tres() {//tenes que poner primero que hacer y luego a que aplicarlo
    translate(45, 30, 1); // trasladar el 3 eje para que no se superponga
    //rotateY(radians(frameCount));
    rotateX(rotX - (rotY * 0.1));
    //rotateX(20);
    rotateY( -rotY);
    //rotateY(10);
    //rotateZ(10);
    pointLight(0, 100, 255, 10, 10, 158);
    pointLight(0, 0, 255, 10, 10, 208);
    pointLight(0, 100, 255, 10, 10, 100);
    
    scale(scaleFactor);
    shape(espd);
}
// mov con el mouse
void acel() {
    rotY *= (1 - desaceleracion); 
}

// Actualizacion de hongos.
void checkForMushrooms() {
    // Si el tiempo actual restado por el momento de colision entre un jugador y un hongo es mayor a 10000 (y el momento de colision no es 0), aplicar logica. 
    if (millis() - mushroomCollisionTime >= 10000 && mushroomCollisionTime != 0) {
        // Agregar un nuevo hongo al array.
        mushrooms = (Mushroom[]) append(mushrooms, new Mushroom(random(width)));  
        // Resetar el momento de colision.
        mushroomCollisionTime = 0;
    }
}

// Actualizacion de zapallos.
void checkForPumpkins() {
    // Si el tiempo actual restado por el momento de colision entre un jugador y un zapallo es mayor a 20000 (y el momento de colision no es 0), aplicar logica. 
    if (millis() - pumpkinCollisionTime >= 20000 && pumpkinCollisionTime != 0) {
        // Agregar un nuevo zapallo al array.
        pumpkins = (Pumpkin[]) append(pumpkins, new Pumpkin(random(width)));  
        // Resetar el momento de colision.
        pumpkinCollisionTime = 0;
    }
}

void draw() {
    background(0);
    
    // Dibujar cada escena basado en el estado
    if (state == "start") {
        startScene();
    } else if (state == "game") {
        gameScene();
    } else if (state == "story") {
        historyScene();
    } else if (state == "end") {
        endScene();
    }

    // Si el mando esta prendido llamar la funcion de mando.
    if (MandON) {
        MandoGlobal();
    }
    
    // Correr el sonido.
    soundFx();
}

// Al presionar cada tecla se los agrega al HashMap keys con un valor de verdadero
void keyPressed() {
    keys.put(keyCode, true);

    if (key == 'b' || key == 'B') {
        MandON = !MandON; // Cambiar el estado entre true y false
        saveEstado(); // Guardar el valor actual en el archivo
    }
}

// Al soltar la tecla el valor en el HashMap es eliminado o puesto a falso
void keyReleased() {
    keys.put(keyCode, false);
}

void mouseDragged() {
    rotY -= (mouseX - pmouseX) * 0.01;
    rotX -= (mouseY - pmouseY) * 0.001;
}
