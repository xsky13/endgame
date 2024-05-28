// lee el archivo estadoGamepad.txt
void loadEstadoGamepad() {
	String[] lines = loadStrings("estadoGamepad.txt");
	// si el archivo no esta vacio
	if (lines.length > 0) {
		// se le asigna a MandOn el valor del archivo convertido a boolean
		MandON = Boolean.parseBoolean(lines[0]);
	}
}


void saveEstado() {
	// el contenido del archivo estadoGamepad.txt es convertido al valor de MandOn
  	String[] lines = { str(MandON) };
  	saveStrings("estadoGamepad.txt", lines);
}
