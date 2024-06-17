void historyScene() {
    wallpaper();
    textSize(50);
    textAlign(CENTER);
    textFont(mainFont);
    text("Historia", width/2, 200);
    textSize(25);
    text("¡Bienvenido, jugador! Prepárate para sumergirte en la épica batalla entre dos personajes legendarios de nuestro juego PvP medieval: el astuto duende Griznak y el valiente caballero Sir Hugo.\n En el corazón del misterioso bosque de Eldergrove, donde las sombras bailan entre los árboles centenarios, Griznak el Malévolo ha sembrado el terror. Con sus ojos amarillos brillando con malicia,\n este duende ha acechado a los aldeanos y saqueado sus tesoros, acumulando riquezas y poder a costa del miedo de los inocentes.\n Pero la luz de la justicia brilla en la figura de Sir Hugo, un caballero de noble corazón y coraje indomable. Enviado por su reino para poner fin a la amenaza de Griznak,\n Sir Hugo se adentra en el bosque con su armadura reluciente y su espada en mano, listo para enfrentarse al duende y restaurar la paz perdida.\n Ahora, jugador, tienes el poder de decidir el destino de esta batalla legendaria. ¿Te unirás al lado del valiente Sir Hugo y lucharás por la justicia\n y la tranquilidad de los aldeanos? ¿O te pondrás en la piel del astuto Griznak, utilizando tu ingenio y trampas para derrotar al caballero y seguir acumulando poder en las sombras?\n ¡La elección es tuya! Prepárate para desafiar a tu adversario en un duelo lleno de estrategia, habilidad y emoción en nuestro emocionante juego PvP medieval. ¡Que la mejor leyenda salga victoriosa!", width/2, 300);

    Button backButton = new Button(150, 100, 200, 60, "Volver", new Runnable() {
      public void run() {
        // Al apretarlo se cambia el estado al de historia.
        state = "start";
      }
    });
    backButton.display();
    backButton.checkForClick();
}