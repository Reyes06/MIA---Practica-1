package com.digital.cards.api;


import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("api/v1/tarjeta")
public class TarjetaAPI {
	
	@PostMapping
	public void crearTarjeta() {
		System.out.println("Crear tarjeta");
	}
	
	@GetMapping
	public void obtenerTarjetas() {
		System.out.println("Obtener tarjeta");
	}
	
	@PutMapping
	public void actualizarTarjeta() {
		System.out.println("Actualizar tarjeta");
	}
	
	@DeleteMapping
	public void elimintarTarjeta() {
		System.out.println("Eliminar tarjeta");
	}
}
