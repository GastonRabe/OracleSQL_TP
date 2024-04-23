package modelo;

import java.sql.*;

public class main {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			String url = "jdbc:oracle:thin:@localhost:1521:xe";
			String user = "SYSTEM";
			String password = "1234567";
			String query = "INSERT INTO socio VALUES (11,'Soria')";
			try {
				Connection con = DriverManager.getConnection(url,user,password);
				Statement st = con.createStatement();
				ResultSet rs =st.executeQuery(query);
			    query = "INSERT INTO socio VALUES (12,'Dalesandro')";
				rs= st.executeQuery(query);
/*			while(rs.next()) {
					System.out.println("ID: "+rs.getInt(1)+" NOMBRE: "+rs.getString(2));
				}*/
				con.close();
			}
			catch(SQLException e) {
				e.printStackTrace();
			}
		}
		catch(ClassNotFoundException e ) {
			e.printStackTrace();		
		}
	//	JPanel ventana = new Gui();
	}

}
