package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class AdminDao {

	public int loginChk(String id, String pw) {
		
		int result = 0;
		Connection con = null;
		String sql = "";
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		try {
			con = DBcon.getConnection();
			sql = "select count(*) from admin where adminId=? and adminPw=?";
			stmt = con.prepareStatement(sql);
			stmt.setString(1, id);
			stmt.setString(2, pw);
			
			rs = stmt.executeQuery();
			rs.next();
			result = rs.getInt("count(*)");
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
}
