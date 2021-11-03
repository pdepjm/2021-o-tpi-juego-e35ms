import wollok.game.*
import carpincho.*
import direcciones.*
import texto.*
import miscelanea.*
import colisionables.*
import soundProducer.*

object menu{
	
    method configuracionInicial(){
    	game.addVisual(menuImagen)
        game.boardGround("Background.png")
        self.configurarTeclas()

        
    }
    method configurarTeclas(){
        keyboard.space().onPressDo({self.comenzarJuego()})
    }
    method comenzarJuego(){
		game.removeVisual(menuImagen)
        nivel.configuracionInicial()
        nivel.configurarTeclas()
		nivel.configurarTimers()
		nuestroReproductor.iniciarSoundtrack()
    }
}

object nivel {
	
	method configuracionInicial(){
		game.addVisual(carpincho)
//		carpincho.hitboxes().forEach({ hitbox => game.addVisual(hitbox) })
//		game.addVisual(contador)
		game.addVisual(tinchoMontania)
		game.addVisual(tinchoCerca)
		game.addVisual(hud)
		game.boardGround("Background.png")		
		self.reiniciarValores()				// reinicia el soundtrack
		
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
		keyboard.m().onPressDo({nuestroReproductor.cambiarEstadoSoundtrack()})	//soundtrack
		
		//keyboard.space().onPressDo({}) --> Presionar barra para empezar juego, un menu
	}


// MARGENES DEL MAPA HABILITADOS PARA NUESTRO CARPINCHO/ELEMENTOS	
 	method estaHabilitada( posicion ){	// Sirve para restringir limites del mapa
 		return  posicion.x() != 1 && posicion.y() != 0 && posicion.y() != 18 && posicion.x() != 18
 	}
 	
// CONFIGURACION DE PELOTAS
 	method configuracionPelota(unaPelota,tiempo,direccion,velocidad){			//direccion indica donde aparece, la velocidad default era 100
 	
 		unaPelota.ubicarPosicion(direccion)
 		unaPelota.mostrar()		//agrega visual y otras cosas dependiendo la pelota
 		
		game.onTick(velocidad,"pelotaMoving",{=> unaPelota.moverPara(direccion)})
		
		game.schedule(tiempo-100,{=> game.removeVisual(unaPelota)} )
		game.schedule(tiempo-100,{=> game.removeTickEvent("pelotaMoving")} )
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
		game.onTick(6000,"sandiaAppearing",				{=> self.configuracionAlimento(sandia)})
		game.onTick(6000,"mateAppearing"  ,				{=> self.configuracionAlimento(mate)})
		game.onTick(3000,"ConfiguraPelotaMontania",		{=> self.configuracionPelota(pelotaMontania,3000,derecha,100)})	
		game.onTick(4000,"ConfiguraPelotaCerca",		{=> self.configuracionPelota(pelotaCerca,4000,derecha,100)})
		game.onTick(4000,"ConfigurapelotaGolfArriba",	{=> self.configuracionPelota(pelotaGolfArriba,4000,abajo,100)})
		game.onTick(4000,"ConfigurapelotaGolfAbajo",	{=> self.configuracionPelota(pelotaGolfAbajo,4000,arriba,100)})
		game.onTick(4000,"ConfigurapelotaGolfDerecha",	{=> self.configuracionPelota(pelotaGolfDerecha,4000,izquierda,100)})
		game.onTick(1000,"CountSegundos",  				{=> hud.pasarUnSegundo()})
		game.schedule(12000,{=> game.onTick(4000,"ConfigurapelotaGolfDerecha2", {=> self.configuracionPelota(pelotaGolfDerecha2,4000,izquierda,75)})} ) // --> Aumentar cantidad de pelotas para aumentar dificultad BETA lean no te enojes
		game.schedule(16000,{=> game.onTick(4000,"ConfigurapelotaGolfArriba2",	{=> self.configuracionPelota(pelotaGolfArriba2,4000,abajo,50)})} ) // --> Aumentar cantidad de pelotas para aumentar dificultad BETA lean no te enojes
	}	

// CONFIGURACION DE REINICIAR NIVEL 						
	method reiniciarValores() {
		hud.reiniciarValores()
		carpincho.reiniciarValores()
		//nuestroReproductor.resumirSoundtrack() // soundtrack
	}
}

// CONFIGURAR MENU 
object menuFinal {
	method configurarFin(porCausa){
		game.clear() 
		game.addVisual(porCausa)		// se puede cambiar agregando otro fondo con addVisual
		game.addVisual(textoFin)
		menu.configurarTeclas()
		keyboard.enter().onPressDo({ game.removeVisual(textoFin)
									game.removeVisual(porCausa) 
		  							menu.configuracionInicial()	})
							  
	}
}

object nuestroReproductor {
	var reproduciendo = true
	const soundtrack = soundProducer.sound("tetrismusica.mp3")
	
	method reproducir(motivo){
		const sonido = soundProducer.sound("ruido" + motivo + ".mp3")
		sonido.initialize()
		sonido.play()
	}
	
		
//SOUNDTRACK
	method iniciarSoundtrack() {
		soundtrack.initialize()
		soundtrack.play()
		soundtrack.shouldLoop(true)
		soundtrack.volume(0.1)			// detalle para que el soundtrack suene bajito
		
	}
	method pausarSoundtrack() {
		soundtrack.pause()
		reproduciendo = false
	}
	method resumirSoundtrack() {
		soundtrack.resume()
		reproduciendo = true
		soundtrack.volume(0.1)		// mismo detalle
	}
	method cambiarEstadoSoundtrack() {
		if(reproduciendo){
			self.pausarSoundtrack()	
		}
		else
			self.resumirSoundtrack()			
		}
	}





