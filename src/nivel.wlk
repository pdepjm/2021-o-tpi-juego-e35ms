import wollok.game.*
import carpincho.*
import direcciones.*
import texto.*
import miscelanea.*

object nivel {
	method configuracionInicial(){
		game.addVisual(carpincho)
		game.addVisual(tinchoMontania)
		game.addVisual(tinchoCerca)
		//game.addVisual(pelotaMontania)
		game.addVisual(pelotaCerca)
		game.addVisual(sandia)
		//game.addVisual(vallas)
		//game.addVisual(texto)
		game.boardGround("Background.png")
		//game.onTick(2000,"tinchoMoving",{=> tincho1.moverPara(direccionesPosibles.direccionAlAzar())})
		game.onTick(500,"sandiaMoving",{=> sandia.moverPara(direccionesPosibles.direccionAlAzar())})
		//game.onTick(250,"pelotaMontaniaMoving",{=> pelotaMontania.moverPara(derecha)})
		game.onTick(250,"pelotaCercaMoving",{=> pelotaCerca.moverPara(derecha)})
		game.onCollideDo(carpincho,{comida => comida.efecto()})
		//game.onCollideDo(carpincho,{vallas => carpincho.restarVida(1)})
		
		game.onTick(6000,"ConfiguraPelota",{=> self.configuracionPelota(pelotaMontania)}) //Hay que calcular los tiempos porque en caso de que quieran salir dos pelotas al mismo tiempo nos dira "pelota ya esta en el juego"

		self.configurarTeclas()
	}
	
	method configurarTeclas(){
		keyboard.left().onPressDo({ carpincho.moverPara(izquierda)
			carpincho.cambiarAspecto("carpincho_left.png")})
		keyboard.right().onPressDo({ carpincho.moverPara(derecha)
			carpincho.cambiarAspecto("carpincho.png")})
		keyboard.up().onPressDo({ carpincho.moverPara(arriba) })
		keyboard.down().onPressDo({ carpincho.moverPara(abajo) })
		keyboard.a().onPressDo({carpincho.deciTuVida()})
	}
	
 	method estaHabilitada( posicion ){				// sirve para restringir limites del mapa
 		return  posicion.x() != 1 && posicion.y() != 0 && posicion.y() != 18 && posicion.x() != 18
 	}
 	
 	method configuracionPelota(unaPelota){ 
 		unaPelota.posicion( unaPelota.posicionInicial() )
 		game.addVisual(unaPelota)
 		
		game.onTick(250,"pelotaMoving",{=> unaPelota.moverPara(derecha)})
		game.schedule(6000,{=> game.removeVisual(unaPelota)} )
		game.schedule(6000,{=> game.removeTickEvent("pelotaMoving")} )
		
		if(game.hasVisual(unaPelota)){
			game.say(tinchoMontania, "esta mi pelota")	// debugging
		}  else{
			game.say(tinchoMontania, "NO esta mi pelota") // debuggin
		}	
	}
}
	

