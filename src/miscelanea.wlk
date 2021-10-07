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
