import wollok.game.*
import direcciones.*
import carpincho.*
import nivel.*
import miscelanea.*

// MODELAMOS VISIBLE
class Visible {
	var posicion = game.center()
	var aspecto = "questionMarkNull.png"

	method position() = posicion
	method image() = aspecto
	method posicion(unaPosicion) {posicion = unaPosicion}
}
// MODELAMOS MOVIBLE 
class Movible inherits Visible {
	method moverPara(direccion) {posicion = direccion.proximaPosicion(posicion)}
}

// MODELAMOS MOVIBLE DENTRO DEL MARGEN
class MovibleDentroDelMargen inherits Movible{	
	
	override method moverPara(direccion) {    
		 if (nivel.estaHabilitada(direccion.proximaPosicion(posicion)) )
			posicion = direccion.proximaPosicion(posicion)
	}
}
// MODELAMOS LA CLASE PELOTA
class Pelota inherits Movible{
    var property danioProyectil = 1    
    var property direccion
    var property velocidad   
    
    method colisionarCon(capybara){
        capybara.restarVida(danioProyectil)
        particulaNegativa.manifestarse()						
        }

    method asignarMovimiento(tiempo){	
 		self.ubicarPosicion(direccion)
 		self.mostrar()
 		
		game.onTick(velocidad,"pelotaMoving",{=> self.moverPara(direccion)})
		game.schedule(tiempo-100,{=> game.removeVisual(self)} )
		game.schedule(tiempo-100,{=> game.removeTickEvent("pelotaMoving")} )

	}
	method mostrar()                {    game.addVisual(self)            }
	method ubicarPosicion(direccion2){}		
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
const pelotaMontania = new PelotaRugby(posicion = tinchoMontania.position(),aspecto = "pelotaRugby.png", tinchoACargo = tinchoMontania,danioProyectil = 2, direccion= derecha, velocidad=100)
const pelotaCerca = new PelotaRugby(posicion = tinchoCerca.position(), tinchoACargo = tinchoCerca, aspecto = "pelotaRugby.png",danioProyectil = 2, direccion= derecha, velocidad=100 )
const pelotaGolfArriba = new PelotaGolf(posicion = game.at(4,18), aspecto = "pelotaGolf.png",danioProyectil = 1, direccion= abajo, velocidad= 100 )
const pelotaGolfArriba2 = new PelotaGolf(posicion = game.at(4,18), aspecto = "pelotaGolf.png",danioProyectil = 1, direccion= abajo, velocidad = 50 )
const pelotaGolfAbajo = new PelotaGolf(posicion = game.at(13,0),  aspecto = "pelotaGolf.png",danioProyectil = 1, direccion= arriba, velocidad=100 )
const pelotaGolfDerecha = new PelotaGolf(posicion = game.at(18,9), aspecto = "pelotaGolf.png",danioProyectil = 1, direccion= izquierda, velocidad= 100)
const pelotaGolfDerecha2 = new PelotaGolf(posicion = game.at(18,9), aspecto = "pelotaGolf.png",danioProyectil = 1, direccion= izquierda, velocidad= 75)

// MODELAMOS LA CLASE ALIMENTO
class Alimento inherits MovibleDentroDelMargen {
	const aumentoDeVida = 0

	method colisionarCon(capybara){
		nuestroReproductor.reproducir("comer")
		capybara.aumentarVida(aumentoDeVida)
		particulaPositiva.manifestarse()
	}
	
	method configurarAlimento(){
		self.posicion(game.at(coordenadaPosible.alAzar(2,16), coordenadaPosible.alAzar(2,16)))
		game.addVisual(self) 
		game.onTick(100,"alimentoMoving", {self.moverPara(direccionesPosibles.direccionAlAzar())}) 
		game.schedule(3000,{=> game.removeVisual(self)} )
		game.schedule(3000,{=> game.removeTickEvent("alimentoMoving")} )
	}
	

}

object mate inherits Alimento(aspecto="mate.png") {
	
	override method colisionarCon(capybara){		
		nuestroReproductor.reproducir("mate")
		hud.aumentarPuntaje()
	}
	
}

// CREAMOS LOS OBJETOS DE LA CLASE ALIMENTO
const sandia = new Alimento(aspecto = "sandiaLoca.png",aumentoDeVida = 1)

