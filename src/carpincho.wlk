import wollok.game.*
import miscelanea.*
import nivel.*
import colisionables.*
import texto.*

// MODELAMOS NUESTRO PROTAGONISTA (ES UNICO)

object carpincho inherits EnteDentroDelMargen(posicion=game.center(),aspecto="carpincho2.png") {
	var property vida = 3
	override method moverPara(direccion) {		
		super(direccion)
		direccion.cambiarAspecto(self)		//polimorfismo
                                        
    }
    
	method aumentarVida(cuanta) 		{	vida = (vida + cuanta).min(3)	}
	method estaMuerto()					{	return vida == 0				}	
	method cambiarAspecto(nuevoAspecto) {	aspecto = nuevoAspecto			}

	//method hacerEfecto(capy)			{  									}
	method reiniciarValores()			{	self.vida(3) 					}
	method perder(porCausa)				{	nuestroReproductor.reproducir("muerte")
											menuFinal.configurarFin(porCausa)
										}
	
	method restarVida(cuanta) 			{	nuestroReproductor.reproducir("danio")
											vida = (vida - cuanta).max(0)	
											if(self.estaMuerto()){ 
												self.perder(porGolpe)
											}
										}
}
