import wollok.game.*
import miscelanea.*

// ¡Los visuales también pueden ser texto!
// Hay que definir la posición en la que debe aparecer
// Y el texto que se debe mostrar. Para eso debe implementar el método text()
// el cual debe devolver un string
// Por defecto el color es azul, pero se puede modificar
// Para ello debe entender el mensaje textColor()
// El método debe devolver un string que represente el color
// Debe ser en un formato particular: tiene que ser un valor RGBA en hexa "rrggbbaa"
// Les dejamos algunos ejemplos
// ¡También se puede combinar con las imágenes!

object porGolpe {
	
	method position() = game.at(9,14)
	
	method text() = "Has recibido muchos golpes y el carpincho esta llorando :(

¡ Presiona ENTER para volver a inicio !"
	
	method textColor() = paleta.azul()
	
	method hacerEfecto() {}
	
}

object porTiempo {
	
	method position() = game.at(9,14)
	
	method text() = "Se te acabo el tiempo ! y a pincho lo llamaron para cenar ;(

¡ Presiona ENTER para volver a inicio !"
	
	
		method textColor() = paleta.azul()
	
	method hacerEfecto() {}
	
}

object textoFin {
	method position() = game.at(9,9)

	
	method textColor() = paleta.azul()

}

object paleta {
	method azul() = "29305a"
	method rojo() = "FF0000FF"
	method blanco() = "FFFFFFFF"
	method negro() = "000000"
}
