import wollok.game.*
import carpincho.*
import nivel.*

object coordenadaPosible{
	method alAzar(inicio,fin) = (new Range (start = inicio, end = fin)).anyOne() // 2 a 16 mapa, 4 a 14 golf
	//method coordAlAzar(direccion){
	//	return direccion.AlAzar()
	//}
	/* method coordAlAzarArriba() = game.at(self.alAzar(2,14),18)
	 * method coordAlAzarAbajo() = game.at(self.alAzar(2,14),0)
	 * method coordAlAzarDerecha() = game.at(18,self.alAzar(2,14))
	 * 
	 */
}

object direccionesPosibles{
	const direcciones = [izquierda,derecha,arriba,abajo]
	
	method direccionAlAzar() = direcciones.anyOne()
}


// capaz se podria usar clases en esto ya que aspecto arriba y abajo no hace nada ;(

object izquierda {
	method proximaPosicion(posicionActual) = posicionActual.left(1) 
	method cambiarAspecto(capybara) {	capybara.cambiarAspecto("carpincho2.png")	}	
	method alAzar(){ 
		return game.at(18,coordenadaPosible.alAzar(2,14))
	}

}	

object derecha {
	method proximaPosicion(posicionActual) = posicionActual.right(1) 
	method cambiarAspecto(capybara) {	capybara.cambiarAspecto("carpincholeft2.png")	}	
	method alAzar(){ 
		return game.at(0,coordenadaPosible.alAzar(2,14))	
	}
}

object arriba {
	method proximaPosicion(posicionActual) = posicionActual.up(1) 
	method cambiarAspecto(capybara){}	
	method alAzar(){ 
		return game.at(coordenadaPosible.alAzar(2,14),0)	
	}

}

object abajo {
	method proximaPosicion(posicionActual) = posicionActual.down(1) 
	method cambiarAspecto(capybara){}
	method alAzar(){ 
		return game.at(coordenadaPosible.alAzar(2,14),18)
	}

}


