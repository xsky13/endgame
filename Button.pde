class Button {
    float x, y, w, h;
    String text;
    Runnable action;
    

    Button(float x, float y, float w, float h, String text, Runnable action) {
        this.x = x;
        this.y = y;
        this.w = w;
        this.h = h;
        this.text = text;
        this.action = action;
    }

    void display() {
        rectMode(CENTER);
        fill(255, 0, 0);
        if (isMouseOver()) {
            translate(0, -5);
         }
        rect(this.x, this.y, this.  w, h);

        fill(255);
        textFont(mainFont, 37);
        text(text, this.x, this.y + 7);
    }
    
    boolean isMouseOver() {
        float xCoord = this.x - (this.w/2);
        float yCoord = this.y - (this.h/2);
        
        return mouseX >= xCoord && mouseX <= xCoord + this.w && mouseY >= yCoord && mouseY <= yCoord + this.h;
    }
    
    void checkForClick() {  
        if (mousePressed && isMouseOver()) {
          action.run();
        }
    }
}
