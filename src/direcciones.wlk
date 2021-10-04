import wollok.game.*
import carpincho.*
import nivel.*

object coordenadaPosible{
	method alAzar() = (new Range (start = 2, end = 16)).anyOne()
	method coordAlAzar() = [game.at(0,self.alAzar()),game.at(self.alAzar(),18),game.at(18,self.alAzar()),game.at(self.alAzar(),0),game.at(self.alAzar(),9)]
}

object direccionesPosibles{
	const direcciones = [izquierda,derecha,arriba,abajo]
	
	method direccionAlAzar() = direcciones.anyOne()
}

object izquierda {
	method proximaPosicion(posicionActual) = posicionActual.left(1) 
}

object derecha {
	method proximaPosicion(posicionActual) = posicionActual.right(1) 
}

object arriba {
	method proximaPosicion(posicionActual) = posicionActual.up(1) 
}

object abajo {
	method proximaPosicion(posicionActual) = posicionActual.down(1) 
}


