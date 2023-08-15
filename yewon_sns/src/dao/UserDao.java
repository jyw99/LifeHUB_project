package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import vo.User;

public class UserDao {

	
	//회원가입 메소드
	public void insertUser(User user) {
		
		Connection con = null;
		String sql = null;
		PreparedStatement stmt = null;
		
		try {
			con = DBcon.getConnection();
			sql = "insert into s_user values(null,?,?,?,?,?,?,?,'nullpfImg.png')";
			stmt = con.prepareStatement(sql);
			stmt.setString(1, user.getUname());
			stmt.setString(2, user.getUid());
			stmt.setString(3, user.getUpw());
			stmt.setString(4, user.getTel());
			stmt.setString(5, user.getGender());
			stmt.setInt(6, user.getAge());
			stmt.setString(7, user.getInfo());
			
			stmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	//회원 탈퇴 메소드
	public void deleteUser(String pw) {
		
		Connection con = null;
		String sql = null;
		PreparedStatement stmt = null;
		
		try {
			con = DBcon.getConnection();
			sql = "delete from s_user where upw=?";
			stmt = con.prepareStatement(sql);
			stmt.setString(1, pw);
			
			stmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	//비밀번호 변경 메소드
	public void updatePw(String id, String pw) {
		
		Connection con = null;
		String sql = null;
		PreparedStatement stmt = null;
		
		try {
			con = DBcon.getConnection();
			sql = "update s_user set upw=? where uid=?";
			stmt = con.prepareStatement(sql);
			stmt.setString(1, pw);
			stmt.setString(2, id);
			
			stmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	
	//id 중복체크 메소드
	public int idCheck(String id) {
		int result = 0;
		Connection con = null;
		String sql = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		try {
			con = DBcon.getConnection();
			sql = "select count(*) from s_user where uid=?";
			stmt = con.prepareStatement(sql);
			stmt.setString(1, id);
			
			rs = stmt.executeQuery();
			rs.next();
			result = rs.getInt("count(*)");
		
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
	//비밀번호 체크 메소드 : 이거 맞나 확인해봐라,,
	public int pwCheck(String id, String pw) {
		int result =0; 
		Connection con = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		String sql = null;
		
		try {
			con = DBcon.getConnection();
			sql = "select pw from s_user where uid=?";
			stmt = con.prepareStatement(sql);
			stmt.setString(1, id);
			rs.next();
			String rspw = rs.getString("upw");
			if (rspw.equals(pw)) {
				result = 1;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}
	
	public int loginCheck(String id, String pw) {
		int result = 0;
		Connection con = null;
		String sql = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		try {
			con = DBcon.getConnection();
			sql = "select count(*) from s_user where uid=? and upw=?";
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
	
	public User getUser(String id){
		User user = new User();
		Connection con = null;
		String sql= "";
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		try {
			con = DBcon.getConnection();
			sql = "select * from s_user where uid=?";
			stmt = con.prepareStatement(sql);
			stmt.setString(1, id);
			rs = stmt.executeQuery();
			rs.next();
			
			user.setUno(rs.getInt("uno"));
			user.setUname(rs.getString("uname"));
			user.setUid(rs.getString("uid"));
			user.setUpw(rs.getString("upw"));
			user.setTel(rs.getString("tel"));
			user.setGender(rs.getString("gender"));
			user.setAge(rs.getInt("age"));
			user.setInfo(rs.getString("info"));
			user.setPfImg(rs.getString("pfImg"));
			
			
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return user;
	}
	
	
	//업데이트 : 패스워드, 전화번호, 나이, 인포, 프로필사진

	//유저 검색 메소드
	public List<User> searchUser(String userid) {
		
		ArrayList<User> user = new ArrayList<>();
		Connection con = null;
		String sql = "";
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		try {
			con = DBcon.getConnection();
			sql = "select * from s_user where uid like '%"+userid+"%'";
			stmt = con.prepareStatement(sql);
			rs = stmt.executeQuery();
			
			while (rs.next()) {
				int uno = rs.getInt("uno");
				String uname = rs.getString("uname");
				String uid = rs.getString("uid");
				String upw = rs.getString("upw");
				String tel = rs.getString("tel");
				String gender = rs.getString("gender");
				int age = rs.getInt("age");
				String info = rs.getString("info");
				String pfImg = rs.getString("pfImg");
				
				User u = new User();
				u.setUno(uno);
				u.setUname(uname);
				u.setUid(uid);
				u.setUpw(upw);
				u.setTel(tel);
				u.setGender(gender);
				u.setAge(age);
				u.setInfo(info);
				u.setPfImg(pfImg);
				
				user.add(u);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return user;
	}
	
	
	
	
	
}
