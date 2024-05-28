class Button {
    float x, y, w, h;
    String text;
    // La funcion pasada como paramentro que se corre al hacer clic.
    Runnable action;
    

    Button(float x, float y, float w, float h, String text, Runnable action) {
        this.x = x;
        this.y = y;
        this.w = w;
        this.h = h;
        this.text = text;
        this.action = action;
    }

    // Dibujar el boton
    void display() {
        rectMode(CENTER);
        noStroke();
        fill(255, 0, 0);
        if (isMouseOver()) {
            translate(0, -5);
        }
        rect(this.x, this.y, this.  w, h);

        fill(255);
        textFont(mainFont, 37);
        text(text, this.x, this.y + 7);
    }
    
    // Metodo que retorna verdadero si el mouse esta en el boton.s
    boolean isMouseOver() {
        // Posiciones x e y.
        float xCoord = this.x - (this.w/2);
        float yCoord = this.y - (this.h/2);
        
        return mouseX >= xCoord && mouseX <= xCoord + this.w && mouseY >= yCoord && mouseY <= yCoord + this.h;
    }
    
    void checkForClick() {  
        // Si hay clic en el mouse y si el mouse esta encima del boton, entonces correr la funcion que es pasada como parametro al boton.
        if (mousePressed && isMouseOver()) {
            action.run();
        }
    }
}
