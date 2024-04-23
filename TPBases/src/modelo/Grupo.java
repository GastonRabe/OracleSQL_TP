package modelo;

public class Grupo {

	int n_grupo;
	String domicilio;
	String telefono;
	
	public Grupo(int n_grupo, String domicilio, String telefono) {
		this.n_grupo = n_grupo;
		this.domicilio = domicilio;
		this.telefono = telefono;
	}

	@Override
	public String toString() {
		return "Grupo N°" + n_grupo + ", Domicilio: " + domicilio + ", Telefono: " + telefono;
	}

	
	

}
