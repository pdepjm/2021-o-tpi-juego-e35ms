import wollok.game.*
import direcciones.*
import carpincho.*
import nivel.*
import texto.*
import colisionables.*

// MODELAMOS LA CLASE TINCHO
class Tincho inherits Visible { 
	const tipoTincho = agresivo 
	
	method mandarMensaje(){
		game.say(self, tipoTincho.mandarMensaje() )
		
	}
}

object agresivo {
	const mensajes = ["ahi va la ovalada mann"," cuidado NEVERPONY", "NO te gusta marama man?", "el que le da al capy le compro unas frias!"]
	
	method mandarMensaje(){
		return mensajes.anyOne() 
	}
}
object tranquilo {
	const mensajes = ["uy cuidado con el marsupial" , "Ups!" , "abajooo!" , "ojo con la pelota bro" ]
		
	method mandarMensaje(){
		return mensajes.anyOne()
		
	}
}
// CREAMOS LOS OBJETOS DE LA CLASE TINCHO
const tinchoMontania = new Tincho(tipoTincho= tranquilo, posicion = game.at(-1,16), aspecto = "tincho_0001.png")
const tinchoCerca = new Tincho(tipoTincho= agresivo,  posicion = game.at(0,4), aspecto = "tincho_0003.png")

// CREAMOS LA CLASE DE PARTICULAS
class Particula inherits Visible {
	override method position() = carpincho.position()
	method manifestarse(){
		game.addVisual(self)
		game.schedule(500,{=> game.removeVisual(self)} )
	}
}

// CREAMOS LOS OBJETOS DE LA CLASE PARTICULA
const particulaNegativa = new Particula(aspecto = "hitnegative.png")
const particulaPositiva = new Particula(aspecto = "hitpositive.png")


// CREAMOS EL HUD
object hud inherits Visible {
	var property tiempoReloj = 60
	var property puntaje = 0
	override method image() = "hud" + carpincho.vida().toString() + ".png"
	override method position() = game.at(10,1)
	method pasarUnSegundo() {
		tiempoReloj -= 1
		if(tiempoReloj == 0){carpincho.perder(porTiempo)}
	}
	method aumentarPuntaje() {
		puntaje += 1
		game.say(self,puntaje.toString())
}
	method hacerEfecto(capybara) {}
	method reiniciarValores() { self.puntaje(0) self.tiempoReloj(60) }
}

object menuImagen {
	method image() = "Menu.png"
	method position() = game.at(0,0)
}