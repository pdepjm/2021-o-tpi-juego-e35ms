import wollok.game.*
import carpincho.*
import nivel.*

object coordenadaPosible{
	method alAzarMapa() = (new Range (start = 2, end = 16)).anyOne()
	method alAzarGolf() = (new Range (start = 4, end = 14)).anyOne()
	method coordAlAzarArriba() = game.at(self.alAzarGolf(),18)
	method coordAlAzarAbajo() = game.at(self.alAzarGolf(),0)
	method coordAlAzarDerecha() = game.at(18,self.alAzarGolf())
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


