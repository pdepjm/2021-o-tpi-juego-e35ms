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

// MODELAMOS LA CLASE Item

class Item {
	var posicion = game.at(2,3)
	var aspecto = null
	var aumentoDeVida = null

	method position() = posicion
	method image() = aspecto
	method moverPara(direccion) {     if ( nivel.estaHabilitada(direccion.proximaPosicion(posicion)) )
											posicion = direccion.proximaPosicion(posicion) 
	}
	method posicion(unaPosicion) {
		posicion = unaPosicion
	}
	method hacerEfecto(capybara){
		capybara.aumentarVida(aumentoDeVida)
	}
	
}

// CREAMOS LOS OBJETOS DE LA CLASE Item
const sandia = new Item(aspecto = "mate.png",aumentoDeVida = 1)
const mate = new Item(aspecto = "mate.png",aumentoDeVida = 0) // El mate será un item que use herencia ya que será igual que la sandia pero se agregaria un metodo "contador" que sume los mates agarrados

class Particula {
	var aspecto = null
	method image() = aspecto
	method position() = carpincho.position()
}

// CREAMOS LOS OBJETOS DE LA CLASE particula
const particulaNegativa = new Particula(aspecto = "hitnegative.png")

object hud {
	method image() = "hud" + ((carpincho.vida() + 1).max(1)).toString() + ".png"
	method position() = game.at(10,1)
}
