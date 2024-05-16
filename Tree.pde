class Tree {
    float x;
    float y;
    int index = 0;
    int frameCounter = 0;
    int frameDelay = 6;

    PImage[] treeImages = new PImage[6];

    Tree(float x, float y) {
        this.x = x;
        this.y = y;

        for (int i = 0; i < treeImages.length; i++) {
            treeImages[i] = loadImage("./assets/trees/tree_" + i + ".png");
        }
    }

    void display() {
        frameCounter++;
        
        if (frameCounter >= frameDelay) {
            index = (index + 1) % treeImages.length; 
            frameCounter = 0;
        }

        for (int i = 0; i < treeImages.length; i++) {
            image(treeImages[index], this.x, this.y);
        }
    }
}