import wollok.game.*
import direcciones.*
import carpincho.*
import nivel.*
import miscelanea.*

// MODELAMOS LA CLASE PELOTA
class PelotaGolf inherits Ente {
	const danioProyectil = 1

	method hacerEfecto(capybara){
		capybara.restarVida(danioProyectil)
		nivel.configuracionParticula(particulaNegativa)		// 
	}
	method ubicarPosicion(direccion){	posicion = direccion.spawnAlAzar()	}
	method mostrar()				{	game.addVisual(self)			}			

}

class PelotaRugby inherits PelotaGolf(danioProyectil = 2) {
	const tinchoACargo = null
	const posicionInicial = posicion
	

	method posicionInicial() = posicionInicial 
	
	method tinchoACargo() = tinchoACargo
	
	override method hacerEfecto(capybara){
		capybara.restarVida(danioProyectil)
		nivel.configuracionParticula(particulaNegativa)		// acadeberia haber una particula distinta
	}
	override method ubicarPosicion(direccion){	posicion = posicionInicial 	} 
	override method mostrar(){					//usa polimorfismo Lindo para hacer interfaz porq usa al tincho acargo
		game.addVisual(self)	
		tinchoACargo.mandarMensaje()
	
	}
}	

// CREAMOS OBJETOS DE LA CLASE PELOTA
const pelotaMontania = new PelotaRugby(posicion = tinchoMontania.position(),aspecto = "pelotaRugby.png", tinchoACargo = tinchoMontania,danioProyectil = 2)
const pelotaCerca = new PelotaRugby(posicion = tinchoCerca.position(), tinchoACargo = tinchoCerca, aspecto = "pelotaRugby.png",danioProyectil = 2 )
const pelotaGolfArriba = new PelotaGolf(posicion = game.at(4,18), aspecto = "pelotaGolf.png",danioProyectil = 1 )
const pelotaGolfAbajo = new PelotaGolf(posicion = game.at(13,0),  aspecto = "pelotaGolf.png",danioProyectil = 1 )
const pelotaGolfDerecha = new PelotaGolf(posicion = game.at(18,9), aspecto = "pelotaGolf.png",danioProyectil = 1 )

// MODELAMOS LA CLASE ALIMENTO
class Alimento inherits Ente {
	const aumentoDeVida = 0

	override method moverPara(direccion) {     if ( nivel.estaHabilitada(direccion.proximaPosicion(posicion)) )
											posicion = direccion.proximaPosicion(posicion)}
	method hacerEfecto(capybara){
		capybara.aumentarVida(aumentoDeVida)
		nivel.configuracionParticula(particulaPositiva)		// Cambiar a particula Positiva
	}
}

object mate inherits Alimento(aspecto="mate.png") {
	override method hacerEfecto(capybara){
		capybara.sumarPuntaje()
	}
}

// CREAMOS LOS OBJETOS DE LA CLASE ALIMENTO
const sandia = new Alimento(aspecto = "sandiaLoca.png",aumentoDeVida = 1)
//const mate = new Alimento(aspecto = "mate.png",aumentoDeVida = 0) // El mate será un Alimento que use herencia ya que será igual que la sandia pero se agregaria un metodo "contador" que sume los mates 