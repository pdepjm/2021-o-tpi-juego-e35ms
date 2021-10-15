import wollok.game.*
import direcciones.*
import carpincho.*
import nivel.*

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


// CREAMOS EL HUD
object hud {
	method image() = "hud" + ((carpincho.vida() + 1).max(1)).toString() + ".png"
	method position() = game.at(10,1)
	method hacerEfecto(capybara){}
}

// CREAMOS LA HITBOX
class Hitbox {
	var posicion = null
	method image() = "hitbox.png"
	method position() = posicion
}

// CREAMOS CONTADOR
object contador {
	var property tiempo = 30
	method position() = game.at(10,10)
	method image() = "empty.png"
	method pasarUnSegundo() {
		tiempo = tiempo - 1
		game.say(self,tiempo.toString())
	}
	method hacerEfecto(capy){}
}

object menu {
	method image() = "Menu.png"
	method position() = game.at(0,0)
}

//const hitbox1 = new Hitbox(posicion = game.at(carpincho.position().x() , carpincho.position().y()+1))
//const hitbox2 = new Hitbox(posicion = game.at(carpincho.position().x()+1 , carpincho.position().y()))
//const hitbox3 = new Hitbox(posicion = game.at(carpincho.position().x()+1 , carpincho.position().y()+1))
//const hitbox4 = new Hitbox(posicion = carpincho.position())
