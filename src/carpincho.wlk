import wollok.game.*
import miscalena.*

object carpincho {
	var vida = 3
	var posicion = game.center()
	var aspecto = "carpincho.png"

	method position() = posicion
	method image() = aspecto
	method vida() = vida
	method moverPara(direccion) {
		posicion = direccion.proximaPosicion(posicion) 
	}
	method posicion(unaPosicion) {
		posicion = unaPosicion
	}
	method restarVida(cuanta) {
		vida = (vida - cuanta).max(0)
	}
	method aumentarVida(cuanta) {
		vida = (vida + cuanta).min(3)
	}
	method cambiarAspecto(aCual){
		aspecto = aCual
	}
	method estaMuerto(){
		return vida == 0
	}
	method comer(comida){
	return true
	}
	method deciTuVida(){
		game.say(self,"Mi vida es de " + vida.toString() + " HP")
	}
}
