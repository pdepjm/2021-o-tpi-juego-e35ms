import wollok.game.*
import direcciones.*
import carpincho.*
import nivel.*

class Tincho {
	var aspecto = null
	var posicion = game.center()
	
	method position() = posicion

	method image() = aspecto
	
	method moverPara(direccion) {
		posicion = direccion.proximaPosicion(posicion) 
	}
	method posicion(unaPosicion) {
		posicion = unaPosicion
	}
}

const tinchoMontania = new Tincho(posicion = game.at(-1,16), aspecto = "tincho_0001.png")
const tinchoCerca = new Tincho(posicion = game.at(0,4), aspecto = "tincho_0001.png")
