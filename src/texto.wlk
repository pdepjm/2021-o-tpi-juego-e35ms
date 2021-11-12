import wollok.game.*
import miscelanea.*

object porGolpe { // Causa 1
	
	method position() = game.at(9,14)
	
	method text() = "Has recibido muchos golpes y el carpincho esta llorando :(

¡ Presiona ENTER para volver a inicio !"
	
	method textColor() = paleta.azul()
	
	method hacerEfecto() {}
	
}

object porTiempo { // Causa 2
	
	method position() = game.at(9,14)
	
	method text() = "Se te acabo el tiempo ! y a pincho lo llamaron para cenar ;(

¡ Presiona ENTER para volver a inicio !"
	
	
		method textColor() = paleta.azul()
	
	method hacerEfecto() {}
	
}

object textoFin {
	method position() = game.at(9,9)

	method text() = " Su Puntaje fue " + hud.puntaje() + "!" 
	
	method textColor() = paleta.azul()

}

object paleta {
	method azul() = "29305a"
	method rojo() = "FF0000FF"
	method blanco() = "FFFFFFFF"
	method negro() = "000000"
}
