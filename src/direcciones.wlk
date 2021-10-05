import wollok.game.*
import carpincho.*
import nivel.*

object coordenadaPosible{
	method alAzar(inicio,fin) = (new Range (start = inicio, end = fin)).anyOne() // 2 a 16 mapa, 4 a 14 golf
	method coordAlAzarArriba() = game.at(self.alAzar(2,14),18)
	method coordAlAzarAbajo() = game.at(self.alAzar(2,14),0)
	method coordAlAzarDerecha() = game.at(18,self.alAzar(2,14))
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


