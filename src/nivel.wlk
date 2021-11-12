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
        keyboard.p().onPressDo({nuestroReproductor.iniciarSoundtrack()})
    }
    method comenzarJuego(){
		game.removeVisual(menuImagen)
        nivel.configuracionInicial()
        nivel.configurarTeclas()
		nivel.configurarTimers()
    }
}

object nivel {
	
	method configuracionInicial(){
		game.addVisual(carpincho)
		game.addVisual(tinchoMontania)
		game.addVisual(tinchoCerca)
		game.addVisual(hud)
		game.boardGround("Background.png")					
		game.onCollideDo(carpincho, {colisionable => colisionable.colisionarCon(carpincho)	})		//ex hacerEfecto
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

/* aca estaba la conf pelotas
 
 
*/

/* aca estaba configurar alimento 

*/

// CONFIGURACION DE PARTICULAS

/*


*/
	
// CONFIGURACION DE LOS onTick
	method configurarTimers(){					// lean: revisar si se pueden delegar a la calse pelota/alimento
		game.onTick(6000,"sandiaAppearing",				{=> sandia.configurarAlimento()})
		game.onTick(6000,"mateAppearing"  ,				{=> mate.configurarAlimento()})
		game.onTick(3000,"ConfiguraPelotaMontania",		{=> pelotaMontania.configurarPelota(3000,derecha,100)})	
		game.onTick(4000,"ConfiguraPelotaCerca",		{=> pelotaCerca.configurarPelota(4000,derecha,100)})
		game.onTick(4000,"ConfigurapelotaGolfArriba",	{=> pelotaGolfArriba.configurarPelota(4000,abajo,100)})
		game.onTick(4000,"ConfigurapelotaGolfAbajo",	{=> pelotaGolfAbajo.configurarPelota(4000,arriba,100)})
		game.onTick(4000,"ConfigurapelotaGolfDerecha",	{=> pelotaGolfDerecha.configurarPelota(4000,izquierda,100)})
		game.onTick(1000,"CountSegundos",  				{=> hud.pasarUnSegundo()})
		game.schedule(12000,{=> game.onTick(4000,"ConfigurapelotaGolfDerecha2", {=> pelotaGolfDerecha2.configurarPelota(4000,izquierda,75)})} ) 
		game.schedule(16000,{=> game.onTick(4000,"ConfigurapelotaGolfArriba2",	{=> pelotaGolfArriba2.configurarPelota(4000,abajo,50)})} ) 
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
	
}