import wollok.game.*
import miscelanea.*
import nivel.*

// MODELAMOS NUESTRO PROTAGONISTA (ES UNICO)

object carpincho inherits Ente(posicion=game.center(),aspecto="carpincho.png") {
	var vida = 3
	method vida() = vida
	override method moverPara(direccion) {     if ( nivel.estaHabilitada(direccion.proximaPosicion(posicion)) )
                                        posicion = direccion.proximaPosicion(posicion)
    }
	method restarVida(cuanta) 	{	vida = (vida - cuanta).max(0)	}
	method aumentarVida(cuanta) {	vida = (vida + cuanta).min(3)	}
	method estaMuerto()			{	return vida == 0				}	
	method cambiarAspecto(nuevoAspecto) {	aspecto = nuevoAspecto	}
}
