
object personaje{
	var vidas = 3
	var property position = game.at(7,4)
    var ultimoMovimiento = "PJ-OW-Down-x4.png" //El objeto aparece mirando hacia abajo
    var direccion = abajo
	var movimientoHabilitado = true
	method image() = ultimoMovimiento

	var property balaDisparada = 0

	method cargarControles(){
		keyboard.up().onPressDo    {self.irArriba()}   // Mueve al jugador hacia arriba
		keyboard.down().onPressDo  {self.irAbajo()}    // Mueve al jugador hacia abajo
		keyboard.left().onPressDo  {self.irIzquierda()}// Mueve al jugador hacia izquierda
		keyboard.right().onPressDo {self.irDerecha()}  // Mueve al jugador hacia derecha

		keyboard.w().onPressDo	   {self.dispararArriba()}
		//keyboard.a().onPressDo	   {self.dispararIzquierda()}
		//keyboard.s().onPressDo	   {self.dispararAbajo()}
		//keyboard.d().onPressDo	   {self.dispararDerecha()}
	}

	method dispararArriba(){
		//crear una bala
        
        game.addVisual(new Bala())
		balaDisparada += 1
		//la bala vaya en direccion arriba

	}
	method perderVida(){
		vidas -= 1
		//nivel.recomenzar()
	}

	method activarTeclasAsignadasDeExploracion(){
		movimientoHabilitado = true
		keyboard.a().onPressDo	   {}
	}

	method desactivarTeclasAsignadasDeExploracion(){
		movimientoHabilitado = false
	}

	// Movimiento
	method irArriba() {
		if(movimientoHabilitado){
			direccion = arriba
			self.avanzar()
        	//ultimoMovimiento = "PJ-OW-Up-x4.png"
		}
		
	}

	method irAbajo() {
		if(movimientoHabilitado){
			direccion = abajo
			self.avanzar()
        	//ultimoMovimiento = "PJ-OW-Down-x4.png"
		}
	}

	method irIzquierda() {
		if(movimientoHabilitado){
			direccion = izquierda
			self.avanzar()
        	//ultimoMovimiento = "PJ-OW-Left-x4.png"
		}
	}

	method irDerecha() {
		if(movimientoHabilitado){
			direccion = derecha
			self.avanzar()
        	//ultimoMovimiento = "PJ-OW-Right-x4.png"
		}
	}
	
	method avanzar(){ position = direccion.siguiente(position)}
	method retrocede(){ position = direccion.opuesto().siguiente(position)}
	method setDireccion(unaDireccion) {direccion = unaDireccion}
}

class Direccion {
	method siguiente(position)
}

object izquierda inherits Direccion { 
	override method siguiente(position) = position.left(1) 
	method opuesto() = derecha
}

object derecha inherits Direccion { 
	override method siguiente(position) = position.right(1) 
	method opuesto() = izquierda
}

object abajo inherits Direccion { 
	override method siguiente(position) = position.down(1) 
	method opuesto() = arriba
}

object arriba inherits Direccion { 
	override method siguiente(position) = position.up(1) 
	method opuesto() = abajo
}

class Bala{
    var property position = game.at(personaje.position().x(),personaje.position().y())
    method image() = "bala.png"
    method initialize(){
        self.comportamiento()
    }
	method comportamiento(){
		game.onTick(500, "disparitoarriba"+personaje.balaDisparada().toString(), {
			if(position.y() <13){
				position = position.up(1)
			}
			else{
				game.removeVisual(self)
				game.removeTickEvent("disparitoarriba"+personaje.balaDisparada())
				}
			})
	}
	
	/*
    method direccion(unaDireccion){
        game.onTick(1000, "disparitoarriba", {self.position().y(+1)})
    }*/
}