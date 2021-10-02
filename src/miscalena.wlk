import wollok.game.*
import direcciones.*
import carpincho.*
import nivel.*

object tincho {
	var posicion = game.center()
	
	method position() = posicion

	method image() = "tincho_0001.png"
	
	method moverPara(direccion) {
		posicion = direccion.proximaPosicion(posicion) 
	}
	
	method posicion(unaPosicion) {
		posicion = unaPosicion
	}
}

object pelotaTincho {
	var posicion = game.at(1,1)
	var aspecto = "pelota_rugby.png"
	
	method position() = posicion
	
	method image() = aspecto
}

class Comida {
	var tipoComida = comidaSanadora
	var posicion = game.at(2,3)
	var aspecto = ""

	method position() = posicion
	method image() = aspecto
	method moverPara(direccion) {     if ( nivel.estaHabilitada(direccion.proximaPosicion(posicion)) )
											posicion = direccion.proximaPosicion(posicion) 
	}
	method posicion(unaPosicion) {
		posicion = unaPosicion
	}
	method efecto(){
		tipoComida.efecto()
	}
}
const sandia = new Comida(aspecto = "sandia.png")

object comidaSanadora {
	const vidaQueRecupera = 1
	
	method efecto(){
		carpincho.aumentarVida(vidaQueRecupera)}
}

//object comidaFrenetica {
//	method efecto(){
//		carpincho.aumentarVelocidad()
//	}
//}

//object vallas {
//	method position() = game.center()
//	
//	method image() = "Background2vallas.png"
//}