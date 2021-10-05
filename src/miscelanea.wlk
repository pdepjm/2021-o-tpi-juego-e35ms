import wollok.game.*
import direcciones.*
import carpincho.*
import nivel.*

// MODELAMOS LA CLASE TINCHO

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

// CREAMOS LOS OBJETOS DE LA CLASE TINCHO

const tinchoMontania = new Tincho(posicion = game.at(-1,16), aspecto = "tincho_0001.png")
const tinchoCerca = new Tincho(posicion = game.at(0,4), aspecto = "tincho_0003.png")

// MODELAMOS LA CLASE COMIDA

class Comida {
	var posicion = game.at(2,3)
	var aspecto = null

	method position() = posicion
	method image() = aspecto
	method moverPara(direccion) {     if ( nivel.estaHabilitada(direccion.proximaPosicion(posicion)) )
											posicion = direccion.proximaPosicion(posicion) 
	}
	method posicion(unaPosicion) {
		posicion = unaPosicion
	}
	
	method esProyectil() = false
}

// CREAMOS LOS OBJETOS DE LA CLASE COMIDA
const sandia = new Comida(aspecto = "sandiaLoca.png")