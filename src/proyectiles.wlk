import wollok.game.*
import direcciones.*
import carpincho.*
import nivel.*
import miscelanea.*


class PelotaTincho {
	var posicion = game.center()
	var aspecto = "pelotaRugby.png"
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
const pelotaGolfArriba = new PelotaTincho(posicion = game.at(4,18), tinchoACargo = tinchoCerca, aspecto = "pelotaGolf.png" )
const pelotaGolfAbajo = new PelotaTincho(posicion = game.at(13,0), tinchoACargo = tinchoCerca, aspecto = "pelotaGolf.png" )
const pelotaGolfDerecha = new PelotaTincho(posicion = game.at(18,9), tinchoACargo = tinchoCerca, aspecto = "pelotaGolf.png" )