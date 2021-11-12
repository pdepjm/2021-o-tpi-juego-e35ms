import wollok.game.*
import direcciones.*
import carpincho.*
import nivel.*
import miscelanea.*

// MODELAMOS LA CLASE PELOTA
class Pelota inherits Ente{
    var property danioProyectil = 1    
        
    method colisionarCon(capybara){
        capybara.restarVida(danioProyectil)
        particulaNegativa.aparecer()						//lean:   lo q dice abajo
    }
   
    method configurarPelota(tiempo, direccion, velocidad){	// pensar mejor nombre , quizas configurarMovimiento (lo mismo para la pelota)
 		self.ubicarPosicion(direccion)
 		self.mostrar()
 		
		game.onTick(velocidad,"pelotaMoving",{=> self.moverPara(direccion)})
		game.schedule(tiempo-100,{=> game.removeVisual(self)} )
		game.schedule(tiempo-100,{=> game.removeTickEvent("pelotaMoving")} )

	}
	method mostrar()                {    game.addVisual(self)            }
	method ubicarPosicion(direccion){}		// se overridea en las clases
}

class PelotaGolf inherits Pelota{
	override  method ubicarPosicion(direccion){    posicion = direccion.spawnAlAzar()    }
    

}

class PelotaRugby inherits Pelota(danioProyectil = 2){
    const property tinchoACargo = null
    const posicionInicial = posicion
    
    method posicionInicial() = posicionInicial 
    
    override method ubicarPosicion(_){    posicion = posicionInicial     } 
    
    override method mostrar(){
        super()   
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

// MODELAMOS ENTE DENTRO DEL MARGEN
class EnteDentroDelMargen inherits Ente{	
	
	override method moverPara(direccion) {    
		 if (nivel.estaHabilitada(direccion.proximaPosicion(posicion)) )
			posicion = direccion.proximaPosicion(posicion)
	}
}


// MODELAMOS LA CLASE ALIMENTO
class Alimento inherits EnteDentroDelMargen {
	const aumentoDeVida = 0

	method colisionarCon(capybara){
		nuestroReproductor.reproducir("comer")
		capybara.aumentarVida(aumentoDeVida)
		particulaPositiva.aparecer()		// lean: en realidad aparece y desaparece, debe haber una palabra q le caiga mejor
	}
	
	method configurarAlimento(){
		self.posicion(game.at(coordenadaPosible.alAzar(2,16), coordenadaPosible.alAzar(2,16)))
		game.addVisual(self) 
		game.onTick(100,"alimentoMoving", {self.moverPara(direccionesPosibles.direccionAlAzar())}) 
		game.schedule(3000,{=> game.removeVisual(self)} )
		game.schedule(3000,{=> game.removeTickEvent("alimentoMoving")} )
	}
}

object mate inherits Alimento(aspecto="mate.png") {		// ahora el mate hereda de Alimento
	
	override method colisionarCon(capybara){		
		nuestroReproductor.reproducir("mate")
		hud.aumentarPuntaje()
	}
}

// CREAMOS LOS OBJETOS DE LA CLASE ALIMENTO
const sandia = new Alimento(aspecto = "sandiaLoca.png",aumentoDeVida = 1)

