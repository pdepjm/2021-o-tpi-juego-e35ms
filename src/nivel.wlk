import wollok.game.*
import carpincho.*
import direcciones.*
import texto.*
import miscalena.*

object nivel {
	method configuracionInicial(){
		game.addVisual(carpincho)
		game.addVisual(tincho)
		game.addVisual(pelotaTincho)
		game.addVisual(sandia)
		//game.addVisual(vallas)
		//game.addVisual(texto)
		game.boardGround("Background.png")
		game.onTick(2000,"tinchoMoving",{=> tincho.moverPara(direccionesPosibles.direccionAlAzar())})
		game.onTick(500,"sandiaMoving",{=> sandia.moverPara(direccionesPosibles.direccionAlAzar())})
		game.onCollideDo(carpincho,{comida => comida.efecto()})
		//game.onCollideDo(carpincho,{vallas => carpincho.restarVida(1)})
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
	
}
