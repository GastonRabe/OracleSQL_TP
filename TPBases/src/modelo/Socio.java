package modelo;

import java.util.Date;

public class Socio {

int n_grupo;
int n_socio;
String nombre;
String domicilio;
String telefono;
String correo_electronico;
Date fecha_nacimiento;
String cargo;
int id_categoria;




public Socio(int n_grupo, int n_socio, String nombre, String domicilio, String telefono, String email, Date fechaNac,
		String cargo, int categoria) {
	super();
	this.n_grupo = n_grupo;
	this.n_socio = n_socio;
	this.nombre = nombre;
	this.domicilio = domicilio;
	this.telefono = telefono;
	this.correo_electronico = email;
	this.fecha_nacimiento = fechaNac;
	this.cargo = cargo;
	this.id_categoria = categoria;
}
public Socio(int n_grupo) {
	this.n_grupo = n_grupo;
}



@Override
public String toString() {
	String aux1, aux2;
	if (id_categoria==1)
		aux1="Infantil";
	else if (id_categoria==2)
		aux1="Mayor";
	else
		aux1="Vitalicio";
	if (cargo.equals("soc_titular"))
		aux2="titular";
	else
		aux2="no titular";
	
	return "Socio N°" + n_grupo + "/" + n_socio + ", " + nombre + ", Domicilio: " + domicilio+ ", "+aux1+" "+aux2;
}


}