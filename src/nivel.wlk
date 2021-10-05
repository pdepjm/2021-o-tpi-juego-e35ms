import wollok.game.*
import carpincho.*
import direcciones.*
import texto.*
import miscelanea.*
import proyectiles.*

object nivel {
	method configuracionInicial(){
		game.addVisual(carpincho)
		game.addVisual(tinchoMontania)
		game.addVisual(tinchoCerca)
		//game.addVisual(texto) -> En un futuro!
		game.boardGround("Background.png")
		game.onCollideDo(carpincho,{elemento => elemento.hacerEfecto(carpincho)
									carpincho.deciTuVida()
									self.configuracionParticula(particula)})
		game.onTick(6000, "sandiaAppearing", {=>self.configuracionSandia(sandia)})
		game.onTick(3000,"ConfiguraPelota",{=> self.configuracionPelota(pelotaMontania,3000,derecha)})
		game.onTick(4000,"ConfiguraPelota",{=> self.configuracionPelota(pelotaCerca,4000,derecha)})
		game.onTick(4000,"ConfiguraPelota",{=> self.configuracionPelota(pelotaGolfArriba,4000,abajo)})
		game.onTick(4000,"ConfiguraPelota",{=> self.configuracionPelota(pelotaGolfAbajo,4000,arriba)})
		game.onTick(4000,"ConfiguraPelota",{=> self.configuracionPelota(pelotaGolfDerecha,4000,izquierda)})
		self.configurarTeclas()
	}

// TECLAS

	method configurarTeclas(){
		keyboard.left().onPressDo({ carpincho.moverPara(izquierda)
			carpincho.cambiarAspecto("carpincho_left.png")})
		keyboard.right().onPressDo({ carpincho.moverPara(derecha)
			carpincho.cambiarAspecto("carpincho.png")})
		keyboard.up().onPressDo({ carpincho.moverPara(arriba) })
		keyboard.down().onPressDo({ carpincho.moverPara(abajo) })
		keyboard.a().onPressDo({carpincho.deciTuVida()})
	}
	
// MARGENES DEL MAPA HABILITADOS PARA NUESTRO CARPINCHO/ELEMENTOS	
	
 	method estaHabilitada( posicion ){	// Sirve para restringir limites del mapa
 		return  posicion.x() != 1 && posicion.y() != 0 && posicion.y() != 18 && posicion.x() != 18
 	}
 	
// CONFIGURACION DE PELOTAS
 	
 	method configuracionPelota(unaPelota,tiempo,direccion){
 //		if(unaPelota.image() == "pelotaGolf.png"){
 //			if(direccion == arriba)		{unaPelota.posicion(coordenadaPosible.coordAlAzarAbajo())}
//			if(direccion == abajo)		{unaPelota.posicion(coordenadaPosible.coordAlAzarArriba())}
//			if(direccion == izquierda)	{unaPelota.posicion(coordenadaPosible.coordAlAzarDerecha())}
// 		}
// 		else
 			unaPelota.posicion(unaPelota.posicionInicial())
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
	
	method configuracionSandia(unaSandia){
		unaSandia.posicion(game.at(coordenadaPosible.alAzar(2,16),coordenadaPosible.alAzar(2,16)) )
		game.addVisual(unaSandia) 
		game.onTick(100,"sandiaMoving", {unaSandia.moverPara(direccionesPosibles.direccionAlAzar())}) 
		game.schedule(3000,{=> game.removeVisual(unaSandia)} )
		game.schedule(3000,{=> game.removeTickEvent("sandiaMoving")} )
		}

// CONFIGURACION DE PARTICULAS
		
	method configuracionParticula(unaParticula){
		game.addVisual(unaParticula)
		game.schedule(500,{=> game.removeVisual(unaParticula)} )
	}	
}
	



