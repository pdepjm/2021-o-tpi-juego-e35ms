import wollok.game.*
import miscelanea.*
import nivel.*
import colisionables.*
import texto.*

// MODELAMOS NUESTRO PROTAGONISTA (ES UNICO)

object carpincho inherits EnteDentroDelMargen(posicion=game.center(),aspecto="carpincho2.png") {
	var property vida = 3
	var property puntaje = 0
	override method moverPara(direccion) {		
		super(direccion)
		direccion.cambiarAspecto(self)		//polimorfismo
                                        
    }
    
	method aumentarVida(cuanta) 		{	vida = (vida + cuanta).min(3)	}
	method estaMuerto()					{	return vida == 0				}	
	method cambiarAspecto(nuevoAspecto) {	aspecto = nuevoAspecto			}

	//method hacerEfecto(capy)			{  									}
	method sumarPuntaje() 				{   hud.aumentarPuntaje() 			}
	method reiniciarValores()			{	self.vida(3) 					}
	method perderPor(causa)				{	menuFinal.configurarFin(causa)}
	
	method restarVida(cuanta) 			{	vida = (vida - cuanta).max(0)	
											if(self.estaMuerto()){ 
												self.perderPor(golpe)
											}
	}
}
