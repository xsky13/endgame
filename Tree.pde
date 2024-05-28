class Tree {
    float x;
    float y;

    int index = 0;
    int frameCounter = 0;
    // el numero de frames que hay de demora entre cada imagen
    int frameDelay = 6;

    // Array de imagenes
    PImage[] treeImages = new PImage[6];

    Tree(float x, float y) {
        this.x = x;
        this.y = y;

        // cargar las imagenes
        for (int i = 0; i < treeImages.length; i++) {
            treeImages[i] = loadImage("./data/trees/tree_" + i + ".png");
        }
    }

    void display() {
        // incrementar el valor de frameCounter cada frame
        frameCounter++;
        
        // Se utiliza el mismo sistema para hacer una animacion que se usa en Player.pde
        if (frameCounter >= frameDelay) {
            index = (index + 1) % treeImages.length; 
            frameCounter = 0;
        }

        for (int i = 0; i < treeImages.length; i++) {
            // se dibuja la imagen con el indice correcto
            image(treeImages[index], this.x, this.y);
        }
    }
}