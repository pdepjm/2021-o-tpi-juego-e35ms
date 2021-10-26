import wollok.game.*
import direcciones.*
import carpincho.*
import nivel.*
import texto.*

class Ente {
	var posicion = game.center()		// esto se puede cambiar por property ?? 
	var aspecto = "questionMarkNull.png"

	method position() = posicion
	method image() = aspecto
	method moverPara(direccion) {posicion = direccion.proximaPosicion(posicion)}
	method posicion(unaPosicion) {posicion = unaPosicion}
}

// MODELAMOS LA CLASE TINCHO
class Tincho inherits Ente {
	var mensajes =["ahi va la ovalada mann", "ojo con la pelota bro" , " cuidado NEVERPONY", "te gusta marama man?"]		// se pueden agregar mas mensajes
	
	method mandarMensaje(){
		game.say(self, mensajes.anyOne() )
		
	}
}

// CREAMOS LOS OBJETOS DE LA CLASE TINCHO
const tinchoMontania = new Tincho(posicion = game.at(-1,16), aspecto = "tincho_0001.png")
const tinchoCerca = new Tincho(posicion = game.at(0,4), aspecto = "tincho_0003.png")

// CREAMOS LA CLASE DE PARTICULAS
class Particula {
	const aspecto = null
	method image() = aspecto
	method position() = carpincho.position()
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
		//game.say(self,tiempo.toString())
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

//const hitbox1 = new Hitbox(posicion = game.at(carpincho.position().x() , carpincho.position().y()+1))
//const hitbox2 = new Hitbox(posicion = game.at(carpincho.position().x()+1 , carpincho.position().y()))
//const hitbox3 = new Hitbox(posicion = game.at(carpincho.position().x()+1 , carpincho.position().y()+1))
//const hitbox4 = new Hitbox(posicion = carpincho.position())
