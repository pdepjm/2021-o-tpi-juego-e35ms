import wollok.game.*
import direcciones.*
import carpincho.*
import nivel.*

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
	var mensajes =["ahi va la ovalada mann", "ojo con la pelota bro" , " cuidado NEVERPONY", "como que no te gusta marama man?"]		// se pueden agregar mas mensajes
	
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
	var property tiempo = 60
	method position() = game.at(0,10)
	method image() = "relojArena.png"
	method pasarUnSegundo() {
		tiempo = tiempo - 1
		game.say(self,tiempo.toString())
	}
	method hacerEfecto(capy){}
}

object menuImagen {
	method image() = "Menu.png"
	method position() = game.at(0,0)
}

// lo agrego lean ! 
object textoFin {
	method position() = game.center()

	method text() =  "Su puntaje fue " + carpincho.puntaje() + "¡Presiona espacio para comenzar!"

}
//const hitbox1 = new Hitbox(posicion = game.at(carpincho.position().x() , carpincho.position().y()+1))
//const hitbox2 = new Hitbox(posicion = game.at(carpincho.position().x()+1 , carpincho.position().y()))
//const hitbox3 = new Hitbox(posicion = game.at(carpincho.position().x()+1 , carpincho.position().y()+1))
//const hitbox4 = new Hitbox(posicion = carpincho.position())
