package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;

import vo.Reply;

public class ReplyDao {

	//댓글 다는 메소드
	public void regReply(Reply rp) {
		Connection con = null;
		String sql = "";
		PreparedStatement stmt = null;
		
		try {
			con = DBcon.getConnection();
			sql = "insert into reply values(null,?,?,now(),?)";
			stmt = con.prepareStatement(sql);
			stmt.setString(1, rp.getUid());
			stmt.setString(2, rp.getContent());
			stmt.setInt(3, rp.getPno());
			
			stmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	
	//댓글 지우는 메소드
	public void delReply(int rno) {
		Connection con = null;
		String sql = "";
		PreparedStatement stmt = null;
		
		try {
			con = DBcon.getConnection();
			sql = "delete from reply where rno=?";
			stmt = con.prepareStatement(sql);
			stmt.setInt(1, rno);
			
			stmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	//글번호를 받아와서 거기에 있는 댓글을 가져온다
	public ArrayList<Reply> getReply(int pno){
		ArrayList<Reply> rlist = new ArrayList<>();
		
		Connection con = null;
		String sql ="";
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		try {
			con = DBcon.getConnection();
			sql = "select * from reply where pno=?";
			stmt = con.prepareStatement(sql);
			stmt.setInt(1, pno);
			rs = stmt.executeQuery();
			while (rs.next()) {
				int rno = rs.getInt("rno");
				String uid = rs.getString("uid");
				String content = rs.getString("content");
				Timestamp regDate = rs.getTimestamp("regDate");
				int rpno = rs.getInt("pno");
				
				Reply rp = new Reply();
				rp.setRno(rno);
				rp.setUid(uid);
				rp.setContent(content);
				rp.setRegDate(regDate);
				rp.setPno(rpno);
				
				rlist.add(rp);
				
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return rlist;
	}
	
	//댓글 몇개인지 알려주는 메소드
	public int reCnt(int pno) {
		Connection con = null;
		String sql = "";
		PreparedStatement stmt = null;
		ResultSet rs = null;
		int result = 0;
		
		try {
			con = DBcon.getConnection();
			sql = "select count(*) from reply where pno=?";
			stmt = con.prepareStatement(sql);
			stmt.setInt(1, pno);
			rs = stmt.executeQuery();
			rs.next();
			
			result = rs.getInt("count(*)");
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}
}



