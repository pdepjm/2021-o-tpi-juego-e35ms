import wollok.game.*
import miscelanea.*
import nivel.*
import colisionables.*


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
	method perder()						{	menuFinal.configurarFin()		}
	
	method restarVida(cuanta) 			{	vida = (vida - cuanta).max(0)	
											if(vida == 0){ 
												self.perder()
											}
	}
}
