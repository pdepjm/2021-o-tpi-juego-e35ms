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
		game.addVisual(tinchoMontania)
		game.addVisual(tinchoCerca)
		game.addVisual(hud)
		game.boardGround("Background.png")					
		game.onCollideDo(carpincho,{elemento => elemento.hacerEfecto(carpincho)	})
		self.reiniciarValores()
	}

// TECLAS
	method configurarTeclas(){
		keyboard.left().onPressDo({ carpincho.moverPara(izquierda)})
		keyboard.right().onPressDo({ carpincho.moverPara(derecha) })
		keyboard.up().onPressDo({ carpincho.moverPara(arriba) })
		keyboard.down().onPressDo({ carpincho.moverPara(abajo) })
		keyboard.m().onPressDo({nuestroReproductor.cambiarEstadoSoundtrack()})
	}


// MARGENES DEL MAPA HABILITADOS PARA NUESTRO CARPINCHO/ELEMENTOS	
 	method estaHabilitada( posicion ){ // --> Sirve para restringir bordes del mapa para algunos entes!
 		return  posicion.x() != 1 && posicion.y() != 0 && posicion.y() != 18 && posicion.x() != 18
 	}
 	
// CONFIGURACION DE PELOTAS
 	method configuracionPelota(unaPelota,tiempo,direccion,velocidad){
 	
 		unaPelota.ubicarPosicion(direccion)
 		unaPelota.mostrar()
 		
		game.onTick(velocidad,"pelotaMoving",{=> unaPelota.moverPara(direccion)})
		game.schedule(tiempo-100,{=> game.removeVisual(unaPelota)} )
		game.schedule(tiempo-100,{=> game.removeTickEvent("pelotaMoving")} )
	}

// CONFIGURACION DE ALIMENTO
	method configuracionAlimento(unAlimento){
		unAlimento.posicion(game.at(coordenadaPosible.alAzar(2,16),coordenadaPosible.alAzar(2,16)))
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
		game.schedule(12000,{=> game.onTick(4000,"ConfigurapelotaGolfDerecha2", {=> self.configuracionPelota(pelotaGolfDerecha2,4000,izquierda,75)})} ) 
		game.schedule(16000,{=> game.onTick(4000,"ConfigurapelotaGolfArriba2",	{=> self.configuracionPelota(pelotaGolfArriba2,4000,abajo,50)})} ) 
	}	

// CONFIGURACION DE REINICIAR NIVEL 						
	method reiniciarValores() {
		hud.reiniciarValores()
		carpincho.reiniciarValores()
	}
}

// CONFIGURAR MENU 
object menuFinal {
	method configurarFin(porCausa){
		game.clear() 
		game.addVisual(porCausa)
		game.addVisual(textoFin)
		menu.configurarTeclas()
		keyboard.enter().onPressDo({ game.removeVisual(textoFin)
									game.removeVisual(porCausa) 
		  							menu.configuracionInicial()})
							  
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
		
	}
	method cambiarEstadoSoundtrack() {
		if(reproduciendo){
			self.pausarSoundtrack()	
		}
		else
			self.resumirSoundtrack()			
	}
	method pausarSoundtrack() {
		soundtrack.pause()
		reproduciendo = false
	}
	method resumirSoundtrack() {
		soundtrack.resume()
		reproduciendo = true
	}






