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

class PelotaTincho {
	var posicion = game.center()
	var aspecto = "pelota_rugby.png"
	const tinchoACargo = null
	const posicionInicial = posicion

	method position() = posicion
	method image() 	  = aspecto
	method posicionInicial()=	posicionInicial 
	method tinchoACargo() = tinchoACargo
	method esProyectil() = true
	method posicion(cual){	posicion = cual	}
	method moverPara(direccion) {posicion = direccion.proximaPosicion(posicion)}}
	
const pelotaMontania = new PelotaTincho(posicion = tinchoMontania.position(), tinchoACargo = tinchoMontania)
const pelotaCerca = new PelotaTincho(posicion = tinchoCerca.position(), tinchoACargo = tinchoCerca )

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
	method esProyectil() = false
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