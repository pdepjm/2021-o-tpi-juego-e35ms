import wollok.game.*
import direcciones.*
import carpincho.*
import nivel.*
import miscelanea.*

// MODELAMOS LA CLASE PELOTA
class Pelota inherits Ente {
	const tinchoACargo = null
	const posicionInicial = posicion
	const danioProyectil = 1

	method posicionInicial() = posicionInicial 
	method tinchoACargo() = tinchoACargo
	method hacerEfecto(capybara){
		capybara.restarVida(danioProyectil)
		nivel.configuracionParticula(particulaNegativa)		// 
	}
}	

// CREAMOS OBJETOS DE LA CLASE PELOTA
const pelotaMontania = new Pelota(posicion = tinchoMontania.position(),aspecto = "pelotaRugby.png", tinchoACargo = tinchoMontania,danioProyectil = 2)
const pelotaCerca = new Pelota(posicion = tinchoCerca.position(), tinchoACargo = tinchoCerca, aspecto = "pelotaRugby.png",danioProyectil = 2 )
const pelotaGolfArriba = new Pelota(posicion = game.at(4,18), tinchoACargo = tinchoCerca, aspecto = "pelotaGolf.png",danioProyectil = 1 )
const pelotaGolfAbajo = new Pelota(posicion = game.at(13,0), tinchoACargo = tinchoCerca, aspecto = "pelotaGolf.png",danioProyectil = 1 )
const pelotaGolfDerecha = new Pelota(posicion = game.at(18,9), tinchoACargo = tinchoCerca, aspecto = "pelotaGolf.png",danioProyectil = 1 )

// MODELAMOS LA CLASE ALIMENTO
class Alimento inherits Ente {
	const aumentoDeVida = null

	override method moverPara(direccion) {     if ( nivel.estaHabilitada(direccion.proximaPosicion(posicion)) )
											posicion = direccion.proximaPosicion(posicion)}
	method hacerEfecto(capybara){
		capybara.aumentarVida(aumentoDeVida)
		nivel.configuracionParticula(particulaNegativa)		// Cambiar a particula Positiva
	}
}

// CREAMOS LOS OBJETOS DE LA CLASE ALIMENTO
const sandia = new Alimento(aspecto = "sandiaLoca.png",aumentoDeVida = 1)
const mate = new Alimento(aspecto = "mate.png",aumentoDeVida = 0) // El mate será un Alimento que use herencia ya que será igual que la sandia pero se agregaria un metodo "contador" que sume los mates 