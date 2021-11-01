import wollok.game.*
import direcciones.*
import carpincho.*
import nivel.*
import miscelanea.*

// MODELAMOS LA CLASE PELOTA

class Pelota inherits Ente{
    var property danioProyectil = 1    
        
    method hacerEfecto(capybara){
        capybara.restarVida(danioProyectil)
        nivel.configuracionParticula(particulaNegativa)    
    }
    method mostrar()                {    game.addVisual(self)            }        
}

class PelotaGolf inherits Pelota{
    method ubicarPosicion(direccion){    posicion = direccion.spawnAlAzar()    }
    
}

class PelotaRugby inherits Pelota(danioProyectil = 2){
    const property tinchoACargo = null
    const posicionInicial = posicion
    
    method posicionInicial() = posicionInicial 
    
    method ubicarPosicion(_){    posicion = posicionInicial     } 
    
    override method mostrar(){                    //usa polimorfismo Lindo para hacer interfaz porq usa al tincho acargo
        super()                  // no uso super porq se acopla con la imagen de clase superior     
        tinchoACargo.mandarMensaje()
    }
    
}


// CREAMOS OBJETOS DE LA CLASE PELOTA
const pelotaMontania = new PelotaRugby(posicion = tinchoMontania.position(),aspecto = "pelotaRugby.png", tinchoACargo = tinchoMontania,danioProyectil = 2)
const pelotaCerca = new PelotaRugby(posicion = tinchoCerca.position(), tinchoACargo = tinchoCerca, aspecto = "pelotaRugby.png",danioProyectil = 2 )
const pelotaGolfArriba = new PelotaGolf(posicion = game.at(4,18), aspecto = "pelotaGolf.png",danioProyectil = 1 )
const pelotaGolfArriba2 = new PelotaGolf(posicion = game.at(4,18), aspecto = "pelotaGolf.png",danioProyectil = 1 )
const pelotaGolfAbajo = new PelotaGolf(posicion = game.at(13,0),  aspecto = "pelotaGolf.png",danioProyectil = 1 )
const pelotaGolfDerecha = new PelotaGolf(posicion = game.at(18,9), aspecto = "pelotaGolf.png",danioProyectil = 1 )
const pelotaGolfDerecha2 = new PelotaGolf(posicion = game.at(18,9), aspecto = "pelotaGolf.png",danioProyectil = 1 )


class EnteDentroDelMargen inherits Ente{	// clase que sirve para elementos dentro del margen por el cual se puede mover
	
	override method moverPara(direccion) {    
		 if (nivel.estaHabilitada(direccion.proximaPosicion(posicion)) )
			posicion = direccion.proximaPosicion(posicion)
	}
}


// MODELAMOS LA CLASE ALIMENTO
class Alimento inherits EnteDentroDelMargen {
	const aumentoDeVida = 0

	method hacerEfecto(capybara){
		nuestroReproductor.reproducir("comer")
		capybara.aumentarVida(aumentoDeVida)
		nivel.configuracionParticula(particulaPositiva)		// Cambiar a particula Positiva
	}
}

object mate inherits EnteDentroDelMargen(aspecto="mate.png") {
	
	method hacerEfecto(capybara){		
		nuestroReproductor.reproducir("mate")
		hud.aumentarPuntaje()
	}
}

// CREAMOS LOS OBJETOS DE LA CLASE ALIMENTO
const sandia = new Alimento(aspecto = "sandiaLoca.png",aumentoDeVida = 1)
//const mate = new Alimento(aspecto = "mate.png",aumentoDeVida = 0) // El mate será un Alimento que use herencia ya que será igual que la sandia pero se agregaria un metodo "contador" que sume los mates 