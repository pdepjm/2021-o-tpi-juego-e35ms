import wollok.game.*
import direcciones.*
import carpincho.*
import nivel.*
import texto.*

class Ente {
	var posicion = game.center()
	var aspecto = "questionMarkNull.png"

	method position() = posicion
	method image() = aspecto
	method moverPara(direccion) {posicion = direccion.proximaPosicion(posicion)}
	method posicion(unaPosicion) {posicion = unaPosicion}
}

// MODELAMOS LA CLASE TINCHO
class Tincho inherits Ente { 
	const tipoTincho = agresivo // Agresivo o Tranquilo, el cual puede estar en el "Tipo" de cualquier ente que ataque, como por ejemplo en un futuro, un golfista.
	
	method mandarMensaje(){
		game.say(self, tipoTincho.mandarMensaje() )
		
	}
}

object agresivo{
	const mensajes = ["ahi va la ovalada mann"," cuidado NEVERPONY", "NO te gusta marama man?", "el que le da al capy le compro unas frias!"]
	
	method mandarMensaje(){
		return mensajes.anyOne() 
	}
}
object tranquilo{
	const mensajes = ["uy cuidado con el marsupial" , "Ups!" , "abajooo!" , "ojo con la pelota bro" ]
		
	method mandarMensaje(){
		return mensajes.anyOne()
		// agregar un detalle tincho asi no repetimos logica xd 
	}
}
// CREAMOS LOS OBJETOS DE LA CLASE TINCHO
const tinchoMontania = new Tincho(tipoTincho= tranquilo, posicion = game.at(-1,16), aspecto = "tincho_0001.png")
const tinchoCerca = new Tincho(tipoTincho= agresivo,  posicion = game.at(0,4), aspecto = "tincho_0003.png")

// CREAMOS LA CLASE DE PARTICULAS
class Particula {
	const aspecto = null
	method image() = aspecto
	method position() = carpincho.position()
	method aparecer(){
		game.addVisual(self)
		game.schedule(500,{=> game.removeVisual(self)} )
	}
}

// CREAMOS LOS OBJETOS DE LA CLASE PARTICULA
const particulaNegativa = new Particula(aspecto = "hitnegative.png")
const particulaPositiva = new Particula(aspecto = "hitpositive.png")


// CREAMOS EL HUD
object hud {
	var property tiempoReloj = 60
	var property puntaje = 0
	method image() = "hud" + carpincho.vida().toString() + ".png"
	method position() = game.at(10,1)
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