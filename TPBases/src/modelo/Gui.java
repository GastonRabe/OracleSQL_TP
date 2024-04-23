package modelo;

import java.awt.BorderLayout;
import java.sql.*;
import java.text.SimpleDateFormat;
import java.awt.EventQueue;

import javax.swing.JFrame;
import javax.swing.JPanel;
import javax.swing.border.EmptyBorder;
import javax.swing.JTextField;
import javax.swing.JLabel;
import javax.swing.DefaultListModel;
import javax.swing.JButton;
import java.awt.event.ActionListener;
import java.awt.event.ActionEvent;
import java.awt.event.MouseListener;
import java.awt.event.MouseEvent;
import javax.swing.JRadioButton;
import javax.swing.JList;
import javax.swing.ButtonGroup;
import javax.swing.border.BevelBorder;
import java.awt.Font;
import java.awt.Color;
import javax.swing.JScrollPane;

public class Gui extends JFrame implements ActionListener, MouseListener {

	private JPanel contentPane;
	private JPanel panel;
	private JTextField txtNombre;
	private JLabel lblNombre;
	private JTextField txtDomicilio;
	private JLabel lblDomicilio;
	private JLabel lblTelefono;
	private JTextField txtTelefono;
	private JPanel panel_1;
	private JLabel lblFechaNacddmmaaaa;
	private JTextField txtFechaNac;
	private JPanel panel_3;
	private JPanel panel_2;
	private JLabel lblEmail_1;
	private JTextField txtEmail;
	private JPanel panel_4;
	private JButton btnAgregar;
	private JPanel panel_5;
	private JLabel lblSocio;
	private JButton btnModificar;
	private JButton btnEliminar;
	private JPanel panel_6;
	private JRadioButton rdbtnSi;
	private JRadioButton rdbtnNo;
	private JLabel lblNewLabel;
	private JPanel panel_7;
	private JLabel lblNewLabel_1;
	private JRadioButton rdbtnInfantil;
	private JRadioButton rdbtnMayor;
	private JRadioButton rdbtnVitalicio;
	private JPanel panel_8;
	private JList listaSocios;
	private JList listaGrupos;
	private JPanel panel_9;
	private JLabel lblNewLabel_2;
	private final ButtonGroup buttonGroup = new ButtonGroup();
	private final ButtonGroup buttonGroup_1 = new ButtonGroup();
	private JPanel panel_10;
	private JScrollPane scrollPane;
	private JLabel label;
	private JLabel lblNewLabel_3;
	private JScrollPane scrollPane_1;

	/**
	 * Launch the application.
	 */
	public static void main(String[] args) {
		EventQueue.invokeLater(new Runnable() {
			public void run() {
				try {
					Gui frame = new Gui();
					frame.setVisible(true);
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		});
	}

	/**
	 * Create the frame.
	 */
	public Gui() {
		setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		setBounds(100, 100, 600, 700);
		this.contentPane = new JPanel();
		this.contentPane.setBorder(new EmptyBorder(5, 5, 5, 5));
		this.contentPane.setLayout(new BorderLayout(0, 0));
		setContentPane(this.contentPane);
		setResizable(false);
		
		this.panel = new JPanel();
		this.panel.setBackground(new Color(255, 255, 240));
		this.contentPane.add(this.panel, BorderLayout.CENTER);
		this.panel.setLayout(null);
		
		this.panel_3 = new JPanel();
		this.panel_3.setBackground(Color.PINK);
		this.panel_3.setBorder(new BevelBorder(BevelBorder.LOWERED, null, null, null, null));
		this.panel_3.setBounds(40, 15, 490, 30);
		this.panel.add(this.panel_3);
		this.panel_3.setLayout(null);
		
		this.lblNombre = new JLabel("Nombre");
		this.lblNombre.setFont(new Font("Tahoma", Font.PLAIN, 10));
		this.lblNombre.setBounds(5, 9, 37, 14);
		this.panel_3.add(this.lblNombre);
		
		this.txtNombre = new JTextField();
		this.txtNombre.setFont(new Font("Tahoma", Font.PLAIN, 11));
		this.txtNombre.setBounds(44, 7, 99, 20);
		this.panel_3.add(this.txtNombre);
		this.txtNombre.setColumns(10);
		
		this.lblDomicilio = new JLabel("Domicilio");
		this.lblDomicilio.setFont(new Font("Tahoma", Font.PLAIN, 10));
		this.lblDomicilio.setBounds(153, 9, 40, 14);
		this.panel_3.add(this.lblDomicilio);
		
		this.txtDomicilio = new JTextField();
		this.txtDomicilio.setFont(new Font("Tahoma", Font.PLAIN, 11));
		this.txtDomicilio.setBounds(196, 7, 118, 20);
		this.panel_3.add(this.txtDomicilio);
		this.txtDomicilio.setColumns(10);
		
		this.lblTelefono = new JLabel("Telefono");
		this.lblTelefono.setFont(new Font("Tahoma", Font.PLAIN, 10));
		this.lblTelefono.setBounds(324, 10, 42, 14);
		this.panel_3.add(this.lblTelefono);
		
		this.txtTelefono = new JTextField();
		this.txtTelefono.setFont(new Font("Tahoma", Font.PLAIN, 11));
		this.txtTelefono.setBounds(376, 7, 104, 20);
		this.panel_3.add(this.txtTelefono);
		this.txtTelefono.setColumns(10);
		
		this.panel_2 = new JPanel();
		this.panel_2.setBackground(Color.PINK);
		this.panel_2.setBorder(new BevelBorder(BevelBorder.LOWERED, null, null, null, null));
		this.panel_2.setBounds(57, 56, 161, 30);
		this.panel.add(this.panel_2);
		this.panel_2.setLayout(null);
		
		this.lblEmail_1 = new JLabel("Email");
		this.lblEmail_1.setFont(new Font("Tahoma", Font.PLAIN, 10));
		this.lblEmail_1.setBounds(10, 9, 24, 14);
		this.panel_2.add(this.lblEmail_1);
		
		this.txtEmail = new JTextField();
		this.txtEmail.setBounds(44, 7, 107, 19);
		this.txtEmail.setFont(new Font("Tahoma", Font.PLAIN, 11));
		this.txtEmail.setColumns(10);
		this.panel_2.add(this.txtEmail);
		
		this.panel_1 = new JPanel();
		this.panel_1.setBackground(Color.PINK);
		this.panel_1.setBorder(new BevelBorder(BevelBorder.LOWERED, null, null, null, null));
		this.panel_1.setBounds(239, 56, 277, 30);
		this.panel.add(this.panel_1);
		this.panel_1.setLayout(null);
		
		this.lblFechaNacddmmaaaa = new JLabel("Fecha Nacimiento (MM-DD-AAAA)");
		this.lblFechaNacddmmaaaa.setFont(new Font("Tahoma", Font.PLAIN, 10));
		this.lblFechaNacddmmaaaa.setBounds(10, 7, 161, 14);
		this.panel_1.add(this.lblFechaNacddmmaaaa);
		
		this.txtFechaNac = new JTextField();
		this.txtFechaNac.setFont(new Font("Tahoma", Font.PLAIN, 11));
		this.txtFechaNac.setBounds(168, 4, 99, 20);
		this.txtFechaNac.setColumns(10);
		this.panel_1.add(this.txtFechaNac);
		
		this.scrollPane = new JScrollPane();
		this.scrollPane.setBounds(16, 150, 548, 277);
		this.panel.add(this.scrollPane);
		
		this.panel_8 = new JPanel();
		this.panel_8.setBackground(Color.WHITE);
		this.scrollPane.setViewportView(this.panel_8);
		
		this.listaSocios = new JList();
		this.listaSocios.addMouseListener(this);
		this.panel_8.add(this.listaSocios);
		
		this.panel_6 = new JPanel();
		this.panel_6.setBackground(Color.PINK);
		this.panel_6.setBorder(new BevelBorder(BevelBorder.LOWERED, null, null, null, null));
		this.panel_6.setBounds(345, 92, 161, 33);
		this.panel.add(this.panel_6);
		
		this.lblNewLabel = new JLabel("Titular:");
		this.panel_6.add(this.lblNewLabel);
		
		this.rdbtnSi = new JRadioButton("Si");
		this.rdbtnSi.setBackground(Color.PINK);
		buttonGroup.add(this.rdbtnSi);
		this.panel_6.add(this.rdbtnSi);
		
		this.rdbtnNo = new JRadioButton("No");
		this.rdbtnNo.setBackground(Color.PINK);
		buttonGroup.add(this.rdbtnNo);
		this.panel_6.add(this.rdbtnNo);
		
		
		
		this.panel_7 = new JPanel();
		this.panel_7.setBackground(Color.PINK);
		this.panel_7.setBorder(new BevelBorder(BevelBorder.LOWERED, null, null, null, null));
		this.panel_7.setBounds(57, 92, 278, 33);
		this.panel.add(this.panel_7);
		
		this.lblNewLabel_1 = new JLabel("Categoria:");
		this.panel_7.add(this.lblNewLabel_1);
		
		this.rdbtnInfantil = new JRadioButton("Infantil");
		this.rdbtnInfantil.setBackground(Color.PINK);
		buttonGroup_1.add(this.rdbtnInfantil);
		this.panel_7.add(this.rdbtnInfantil);
		
		this.rdbtnMayor = new JRadioButton("Mayor");
		this.rdbtnMayor.setBackground(Color.PINK);
		buttonGroup_1.add(this.rdbtnMayor);
		this.panel_7.add(this.rdbtnMayor);
		
		this.rdbtnVitalicio = new JRadioButton("Vitalicio");
		this.rdbtnVitalicio.setBackground(Color.PINK);
		buttonGroup_1.add(this.rdbtnVitalicio);
		this.panel_7.add(this.rdbtnVitalicio);
		
		this.label = new JLabel("New label");
		this.panel_7.add(this.label);
		
		this.lblNewLabel_2 = new JLabel("Lista Socios");
		this.lblNewLabel_2.setBounds(250, 136, 85, 14);
		this.panel.add(this.lblNewLabel_2);
		
		this.lblNewLabel_3 = new JLabel("Lista Grupos");
		this.lblNewLabel_3.setBounds(239, 432, 79, 14);
		this.panel.add(this.lblNewLabel_3);
		
		this.scrollPane_1 = new JScrollPane();
		this.scrollPane_1.setBounds(99, 450, 385, 123);
		this.panel.add(this.scrollPane_1);
		
		this.panel_10 = new JPanel();
		this.panel_10.setBackground(Color.WHITE);
		this.scrollPane_1.setViewportView(this.panel_10);
		
		this.listaGrupos = new JList();
		this.listaGrupos.addMouseListener(this);
		this.panel_10.add(this.listaGrupos);
		
		this.panel_5 = new JPanel();
		this.panel_5.setBackground(new Color(255, 228, 225));
		this.panel_5.setForeground(Color.PINK);
		this.contentPane.add(this.panel_5, BorderLayout.NORTH);
		
		this.lblSocio = new JLabel("ABM Socio");
		this.panel_5.add(this.lblSocio);
		this.panel_9 = new JPanel();
		this.panel_9.setBackground(Color.PINK);
		this.contentPane.add(this.panel_9, BorderLayout.SOUTH);
		
		this.panel_4 = new JPanel();
		this.panel_9.add(this.panel_4);
		
		this.btnAgregar = new JButton("Agregar ");
		this.btnAgregar.setBackground(Color.PINK);
		this.btnAgregar.addMouseListener(this);
		this.btnAgregar.addActionListener(this);
		this.panel_4.add(this.btnAgregar);
		
		this.btnModificar = new JButton("Modificar");
		this.btnModificar.setBackground(Color.PINK);
		this.btnModificar.addMouseListener(this);
		this.btnModificar.addActionListener(this);
		this.panel_4.add(this.btnModificar);
		
		this.btnEliminar = new JButton("Eliminar");
		this.btnEliminar.setBackground(Color.PINK);
		this.btnEliminar.addMouseListener(this);
		this.panel_4.add(this.btnEliminar);
		this.actualizaListaSocio();
		this.actualizaListaGrupo();
	}

	public void actionPerformed(ActionEvent e) {
	}
	public void mouseClicked(MouseEvent e) {
		String query = "";
		if(e.getComponent().equals(this.listaSocios)) {
			Socio socio=(Socio)this.listaSocios.getSelectedValue();
			this.txtDomicilio.setText(socio.domicilio);
			this.txtNombre.setText(socio.nombre);
			this.txtEmail.setText(socio.correo_electronico);
			this.txtTelefono.setText(socio.telefono);
			SimpleDateFormat formatter = new SimpleDateFormat("MM-dd-yyyy");  
			String strDate = formatter.format(socio.fecha_nacimiento);  
			this.txtFechaNac.setText(strDate);
		}
		if(e.getComponent().equals(this.btnAgregar)) {        //INSERT INTO
			if (this.rdbtnSi.isSelected()) //AGREGA UN SOCIO TITULAR
			{
				query="INSERT INTO socio (nombre, domicilio, telefono, correo_electronico,fecha_nacimiento, cargo, ID_categoria) VALUES (";
				query+="'"+this.txtNombre.getText()+"','"+this.txtDomicilio.getText()+"','"+this.txtTelefono.getText()+"','"+this.txtEmail.getText()+"',TO_DATE('"+this.txtFechaNac.getText()+"','DD/MM/YY'),'soc_titular',";
			}
			else //AGREGA SOCIO NO TITULAR, DEBE TENER UN NUMERO DE GRUPO
			{
				query="INSERT INTO socio (n_grupo,nombre, domicilio, telefono, correo_electronico,fecha_nacimiento, cargo, ID_categoria) VALUES (";
				Grupo g=(Grupo) this.listaGrupos.getSelectedValue();
				query+=g.n_grupo+",'"+this.txtNombre.getText()+"','"+this.txtDomicilio.getText()+"','"+this.txtTelefono.getText()+"','"+this.txtEmail.getText()+"',TO_DATE('"+this.txtFechaNac.getText()+"','DD/MM/YY'),'soc_notitular',";
			}
			
			if(this.rdbtnInfantil.isSelected())
				query+="1)";
			else if(this.rdbtnMayor.isSelected())
				query+="2)";
			else
				query+="3)";
			System.out.println(query);
			
		}
		else if(e.getComponent().equals(this.btnModificar)) {  //UPDATE
			Socio socio=(Socio)this.listaSocios.getSelectedValue();
			query="UPDATE socio SET nombre ='"+this.txtNombre.getText()+"',domicilio ='"+this.txtDomicilio.getText()+"',correo_electronico ='"+this.txtEmail.getText()+"',fecha_nacimiento =TO_DATE('"+this.txtFechaNac.getText()+"','DD/MM/YY')";
			query+=" WHERE n_grupo="+socio.n_grupo+" AND n_socio="+socio.n_socio;  //ACA DEBERIAMOS TRAER CON UN SELECT LOS SOCIOS EXISTENTE Y SELECCIONAR UNO PARA TENER EL N GRUPO Y EL N SOCIO 
		}
		else if(e.getComponent().equals(btnEliminar)) {     //DELETE
			Socio socio=(Socio)this.listaSocios.getSelectedValue();
			query="DELETE FROM socio WHERE n_grupo ="+socio.n_grupo+" AND n_socio ="+socio.n_socio;
			System.out.println(query);
		}
		if(!query.equals("")) {	
		try {
		
		Class.forName("oracle.jdbc.driver.OracleDriver");
		String url = "jdbc:oracle:thin:@192.168.0.88:1521:XE";
		String user = "SYSTEM";
		String password = "gaston";
		try {
			Connection con = DriverManager.getConnection(url,user,password);
			Statement st = con.createStatement();
			ResultSet rs =st.executeQuery(query);
			con.close();
			System.out.println(query);
		}
		catch(SQLException e1) {
			e1.printStackTrace();
		}
	 }
	 catch(ClassNotFoundException e2 ) {
		e2.printStackTrace();		
	 }
	   this.actualizaListaSocio();
	   this.actualizaListaGrupo();
	}
		
	}
	public void actualizaListaSocio() {
		try {
			
			Class.forName("oracle.jdbc.driver.OracleDriver");
			String url = "jdbc:oracle:thin:@192.168.0.88:1521:XE";
			String user = "SYSTEM";
			String password = "gaston";
			String query = "SELECT * FROM socio";
			try {
				Connection con = DriverManager.getConnection(url,user,password);
				Statement st = con.createStatement();
				ResultSet rs= st.executeQuery(query);
				DefaultListModel<Socio> l1 = new DefaultListModel<>();
			while(rs.next()) {
					Socio socio= new Socio(rs.getInt(1),rs.getInt(2),rs.getString(3),rs.getString(4),rs.getString(5),rs.getString(6),rs.getDate(7),rs.getString(8),rs.getInt(9));
			     	System.out.println(socio);
				    l1.addElement(socio);   
			}
			this.listaSocios.setModel(l1);
				con.close();
			}
			catch(SQLException e1) {
				e1.printStackTrace();
			}
		}
		catch(ClassNotFoundException e2 ) {
			e2.printStackTrace();		
		}
		
	}
	
	public void actualizaListaGrupo() {
		try {
			
			Class.forName("oracle.jdbc.driver.OracleDriver");
			String url = "jdbc:oracle:thin:@192.168.0.88:1521:XE";
			String user = "SYSTEM";
			String password = "gaston";
			String query = "SELECT * FROM grupo_familiar";
			try {
				Connection con = DriverManager.getConnection(url,user,password);
				Statement st = con.createStatement();
				ResultSet rs= st.executeQuery(query);
				DefaultListModel<Grupo> l2 = new DefaultListModel<>(); 
			while(rs.next()) {
					Grupo grupo= new Grupo(rs.getInt(1),rs.getString(2),rs.getString(3));
			     	System.out.println(grupo);
				    l2.addElement(grupo);   
			}
			this.listaGrupos.setModel(l2);
				con.close();
			}
			catch(SQLException e1) {
				e1.printStackTrace();
			}
		}
		catch(ClassNotFoundException e2 ) {
			e2.printStackTrace();		
		}
		
	}
	public void mouseEntered(MouseEvent e) {
	}
	public void mouseExited(MouseEvent e) {
	}
	public void mousePressed(MouseEvent e) {
	}
	public void mouseReleased(MouseEvent e) {
	}
}
