import wollok.game.*
import carpincho.*
import direcciones.*
import texto.*
import miscelanea.*
import colisionables.*

object menu
{
    method configuracionInicial(){
        game.boardGround("Background.png")
        self.configurarTeclas()
        game.addVisual(texto)
        
    }
    method configurarTeclas(){
        keyboard.space().onPressDo({self.comenzarJuego()})
    }
    method comenzarJuego(){
    	
		game.removeVisual(texto)
        nivel.configuracionInicial()
        nivel.configurarTeclas()
		nivel.configurarTimers()

    }
}

object nivel {
	method configuracionInicial(){
		game.addVisual(carpincho)
//		carpincho.hitboxes().forEach({ hitbox => game.addVisual(hitbox) })
		game.addVisual(tinchoMontania)
		game.addVisual(tinchoCerca)
		game.addVisual(hud)
		game.boardGround("Background.png")
		
//		carpincho.hitboxes().forEach({ hitbox => game.onCollideDo(hitbox, {elemento => elemento.hacerEfecto(carpincho)
//												self.configuracionParticula(particulaNegativa)}) })
		
		game.onCollideDo(carpincho,{elemento => elemento.hacerEfecto(carpincho)	}) // ojo acá la configuración debería estar en hacerEfecto --> Corregido por lean

		
		
	}

// TECLAS
	method configurarTeclas(){
		keyboard.left().onPressDo({ carpincho.moverPara(izquierda)}) // la responsabilidad de cambiar el aspecto es del carpincho.-->Corregido por lean
		keyboard.right().onPressDo({ carpincho.moverPara(derecha) })	// No vale usar if para resolver esto, resuelvan polimórficamente.--> same blda
		
		keyboard.up().onPressDo({ carpincho.moverPara(arriba) })
		keyboard.down().onPressDo({ carpincho.moverPara(abajo) })
		//keyboard.space().onPressDo({}) --> Presionar barra para empezar juego, un menu
	}
	
// MARGENES DEL MAPA HABILITADOS PARA NUESTRO CARPINCHO/ELEMENTOS	
 	method estaHabilitada( posicion ){	// Sirve para restringir limites del mapa
 		return  posicion.x() != 1 && posicion.y() != 0 && posicion.y() != 18 && posicion.x() != 18
 	}
 	
// CONFIGURACION DE PELOTAS
 	method configuracionPelota(unaPelota,tiempo,direccion){
 		//Delegar a las distintas pelotas, tratar polimórficamente
 		if(unaPelota.image() == "pelotaGolf.png"){
 			// no deberían usar if, y DELEGARLO a las direcciones. Tratarlas polimórficamente.
 			// direccion.elegiPosicion(...)...
 			 			
 			if(direccion == arriba)		{unaPelota.posicion(coordenadaPosible.coordAlAzarAbajo())}
			if(direccion == abajo)		{unaPelota.posicion(coordenadaPosible.coordAlAzarArriba())}
			if(direccion == izquierda)	{unaPelota.posicion(coordenadaPosible.coordAlAzarDerecha())}
 		} else {
 			unaPelota.posicion(unaPelota.posicionInicial()) 			
 		}
 		game.addVisual(unaPelota)
		game.onTick(100,"pelotaMoving",{=> unaPelota.moverPara(direccion)})
		game.schedule(tiempo-100,{=> game.removeVisual(unaPelota)} )
		game.schedule(tiempo-100,{=> game.removeTickEvent("pelotaMoving")} )
		
		if(game.hasVisual(unaPelota)){
			game.say(unaPelota.tinchoACargo(), "ahi va la ovalada man")
		}  else{
			game.say(tinchoMontania, "NO esta mi pelota") 
		}	
	}

// CONFIGURACION DE SANDIAS
	method configuracionAlimento(unAlimento){
		unAlimento.posicion(game.at(coordenadaPosible.alAzar(2,16),coordenadaPosible.alAzar(2,16)) )
		game.addVisual(unAlimento) 
		game.onTick(100,"alimentoMoving", {unAlimento.moverPara(direccionesPosibles.direccionAlAzar())}) 
		game.schedule(3000,{=> game.removeVisual(unAlimento)} )
		game.schedule(3000,{=> game.removeTickEvent("alimentoMoving")} )
		}

// CONFIGURACION DE PARTICULAS
	method configuracionParticula(unaParticula){
		game.addVisual(unaParticula)
		game.schedule(500,{=> game.removeVisual(unaParticula)} )
	}
// CONFIGURACION DE LOS onTick
	method configurarTimers(){
		game.onTick(6000,"sandiaAppearing",{=> self.configuracionAlimento(sandia)})
		game.onTick(6000,"mateAppearing"  ,{=> self.configuracionAlimento(mate)})
		game.onTick(3000,"ConfiguraPelota",{=> self.configuracionPelota(pelotaMontania,3000,derecha)})
		game.onTick(4000,"ConfiguraPelota",{=> self.configuracionPelota(pelotaCerca,4000,derecha)})
		game.onTick(4000,"ConfiguraPelota",{=> self.configuracionPelota(pelotaGolfArriba,4000,abajo)})
		game.onTick(4000,"ConfiguraPelota",{=> self.configuracionPelota(pelotaGolfAbajo,4000,arriba)})
		game.onTick(4000,"ConfiguraPelota",{=> self.configuracionPelota(pelotaGolfDerecha,4000,izquierda)})
		game.onTick(1000,"CountSegundos",  {=> contador.pasarUnSegundo()})
	}	
}
	



