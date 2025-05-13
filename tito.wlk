object tito {
    var cantidad = 0
    var bebida = cianuro
    method peso() = 70
    method inerciaBase() = 490
    method consumir(unaCantidad,unaBebida) {
        bebida = unaBebida
        cantidad = unaCantidad
    }
    method bebida() = bebida

    method velocidad() {
        return bebida.rendimiento(cantidad)
        * self.inerciaBase() / self.peso()
    }
}

object wisky {
    method rendimiento(cantidad) = 0.9 ** cantidad
}
object cianuro {
    method rendimiento(cantidad) = 0
}

object terere {
    method rendimiento(cantidad) {
        return 1.max(cantidad * 0.1)
        //tambien (cantidad * 0.1).max(1)
    }
}

object licuadoDeFrutas {
    var nutrientes = 0
    method agregarNutrientes(valor) {
        nutrientes += valor
    }
    method rendimiento(cantidad) = (cantidad / 1000) * nutrientes
}
object aguaSaborizada {
    var bebidaSabor = null

    method saborizar(unaBebida) {
        bebidaSabor = unaBebida
    }
    method rendimiento(cantidad) {
        var parteAgua = cantidad * 0.75
        var parteSabor = cantidad * 0.25
        return parteAgua/1000 + bebidaSabor.rendimiento(parteSabor)
    }
}
object coctel {
    const bebidas = []
    method agregarBebida(unaBebida) {
        bebidas.add(unaBebida)
    }
    method rendimiento(cantidad) {
        if (bebidas.isEmpty()){
            return 0
        }
        var rendimientoPorBebida = {
            unaBebida => unaBebida.rendimiento(cantidad / bebidas.size())
        }

        return bebidas.fold(1, { acum, bebida => acum * rendimientoPorBebida.apply(bebida) })
    }
}
object coctelSuave {
    const bebidas = []
    method agregarBebida(unaBebida) {
        bebidas.add(unaBebida)
    }
    method rendimiento(cantidad) {
        if (bebidas.isEmpty()) {
            return 0
        }
        
        var rendimientoPorBebida = { unaBebida => 
            val rend = unaBebida.rendimiento(cantidad / bebidas.size())
            if (rend > 0.5) rend else 0
        }
        
        return bebidas.sum(rendimientoPorBebida)
    }    
}