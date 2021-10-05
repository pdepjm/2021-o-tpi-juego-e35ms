import wollok.game.*
import direcciones.*
import carpincho.*
import nivel.*
import miscelanea.*


class Pelota {
	var posicion = game.center()
	var aspecto = "pelotaRugby.png"
	const tinchoACargo = null
	const posicionInicial = posicion
	var danioProyectil = 1

	method position() = posicion
	method image() 	  = aspecto
	method posicionInicial()=	posicionInicial 
	method tinchoACargo() = tinchoACargo
	method posicion(cual){	posicion = cual	}
	method moverPara(direccion) {posicion = direccion.proximaPosicion(posicion)}
	method hacerEfecto(capybara){
		capybara.restarVida(danioProyectil)
	}
}
	
	
const pelotaMontania = new Pelota(posicion = tinchoMontania.position(), tinchoACargo = tinchoMontania,danioProyectil = 2)
const pelotaCerca = new Pelota(posicion = tinchoCerca.position(), tinchoACargo = tinchoCerca,danioProyectil = 2 )
const pelotaGolfArriba = new Pelota(posicion = game.at(4,18), tinchoACargo = tinchoCerca, aspecto = "pelotaGolf.png",danioProyectil = 1 )
const pelotaGolfAbajo = new Pelota(posicion = game.at(13,0), tinchoACargo = tinchoCerca, aspecto = "pelotaGolf.png",danioProyectil = 1 )
const pelotaGolfDerecha = new Pelota(posicion = game.at(18,9), tinchoACargo = tinchoCerca, aspecto = "pelotaGolf.png",danioProyectil = 1 )