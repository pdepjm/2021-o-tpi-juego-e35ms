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
		game.addVisual(sandia)
		//game.addVisual(vallas)
		//game.addVisual(texto)
		game.boardGround("Background.png")
		game.onTick(100,"sandiaMoving",{=> sandia.moverPara(direccionesPosibles.direccionAlAzar())})
		game.onCollideDo(carpincho,{comida => comida.efecto()})
		game.onTick(3000,"ConfiguraPelota",{=> self.configuracionPelota(pelotaMontania,3000,derecha)})
		game.onTick(4000,"ConfiguraPelota",{=> self.configuracionPelota(pelotaCerca,4000,derecha)})
		game.onTick(4000,"ConfiguraPelota",{=> self.configuracionPelota(pelotaGolfArriba,4000,abajo)})
		game.onTick(4000,"ConfiguraPelota",{=> self.configuracionPelota(pelotaGolfAbajo,4000,arriba)})
		game.onTick(4000,"ConfiguraPelota",{=> self.configuracionPelota(pelotaGolfDerecha,4000,izquierda)})
		game.onCollideDo(carpincho,{objeto => carpincho.hacerEfecto(objeto)})
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
	
 	method estaHabilitada( posicion ){	// Sirve para restringir limites del mapa
 		return  posicion.x() != 1 && posicion.y() != 0 && posicion.y() != 18 && posicion.x() != 18
 	}
 	
 	method configuracionPelota(unaPelota,tiempo,direccion){ // Faltaria hacer que las pelotas de golf cada vez que se ejecutan tengan unas coordenadas distintas
 		unaPelota.posicion( unaPelota.posicionInicial() )
 		game.addVisual(unaPelota)
		game.onTick(100,"pelotaMoving",{=> unaPelota.moverPara(direccion)})
		game.schedule(tiempo-100,{=> game.removeVisual(unaPelota)} )
		game.schedule(tiempo-100,{=> game.removeTickEvent("pelotaMoving")} )
		
		if(game.hasVisual(unaPelota)){
			game.say(unaPelota.tinchoACargo(), "ahi va la ovalada man")	// Debugging
		}  else{
			game.say(tinchoMontania, "NO esta mi pelota") // Debuggin
		}	
	}
}
	

