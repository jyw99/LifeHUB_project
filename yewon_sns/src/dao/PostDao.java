package dao;


import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;

import vo.Post;

public class PostDao {

	//게시글 등록 메소드
	public void registPost(Post post) {
		
		Connection con = null;
		String sql = "";
		PreparedStatement stmt = null;
		
		try {
			con = DBcon.getConnection();
			sql = "insert into post values(null,?,?,?,?,0,now())";
			stmt = con.prepareStatement(sql);
			stmt.setString(1, post.getUid());
			stmt.setString(2, post.getPfImg());
			stmt.setString(3, post.getPostImg());
			stmt.setString(4, post.getPostContent());
			
			stmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}
	
	//개인 게시글 가져오는 메소드
	public ArrayList<Post> getPost(String id){
		ArrayList<Post> plist = new ArrayList<>();
		Connection con = null;
		String sql = "";
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		try {
			con = DBcon.getConnection();
			sql =  "SELECT p.pno, p.uid, p.pfImg, p.postImg, p.postContent, p.likeCnt, p.regDate, r.replyCnt "
				     + "FROM post p "
				     + "LEFT JOIN v_reply r ON p.pno = r.pno "
				     + "WHERE p.uid=?";
			stmt = con.prepareStatement(sql);
			stmt.setString(1, id);
			rs = stmt.executeQuery();
			
			while (rs.next()) {
				int pno = rs.getInt("pno");
				String uid = rs.getString("uid");
				String pfImg = rs.getString("pfimg");
				String postImg = rs.getString("postImg");
				String postContent = rs.getString("postContent");
				int likeCnt = rs.getInt("likeCnt");
				Timestamp regDate = rs.getTimestamp("regDate");
				int replyCnt = rs.getInt("replyCnt");
				
				Post post = new Post();
				post.setPno(pno);
				post.setUid(uid);
				post.setPfImg(pfImg);
				post.setPostImg(postImg);
				post.setPostContent(postContent);
				post.setLikeCnt(likeCnt);
				post.setRegDate(regDate);
				post.setReplyCnt(replyCnt);
				
				plist.add(post);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}	
		return plist;
	}
	
	//팔로우 + 내 게시물 가져오는 .. 메소드임
	public ArrayList<Post> followPost(String id){
		ArrayList<Post> flist = new ArrayList<>();
		
		//int startPage = (p-1)*10;
		//int pageCnt = 10;
		
		Connection con = null;
		String sql = "";
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		try {
			con = DBcon.getConnection();
			//sql = "select * from post where uid in (select followId from follow where uid=?) or uid=? ORDER BY regDate desc limit ?,?";
			//sql = "select * from post where uid in (select followId from follow where uid=?) or uid=? ORDER BY regDate desc";
			//sql = "SELECT * FROM v_post";
			//sql = "SELECT p.pno, p.uid, p.pfImg, p.postImg, p.postContent, p.likeCnt, p.regDate, r.replyCnt"
			//		+ "FROM post p LEFT JOIN v_reply r ON p.pno = r.pno WHERE p.uid IN (SELECT followId FROM follow WHERE uid = ?) OR p.uid = ? ORDER BY p.regDate DESC";
			sql = "SELECT p.pno, p.uid, p.pfImg, p.postImg, p.postContent, p.likeCnt, p.regDate, r.replyCnt "
				      + "FROM post p LEFT JOIN v_reply r ON p.pno = r.pno "
				      + "WHERE p.uid IN (SELECT followId FROM follow WHERE uid = ?) OR p.uid = ? "
				      + "ORDER BY p.regDate DESC";
			
			stmt = con.prepareStatement(sql);
			stmt.setString(1, id);
			stmt.setString(2, id);
			//stmt.setInt(3, startPage);
			//stmt.setInt(4, pageCnt);
			rs = stmt.executeQuery();
			
			while (rs.next()) {
				int pno = rs.getInt("pno");
				String uid = rs.getString("uid");
				String pfimg = rs.getString("pfimg");
				String postimg = rs.getString("postimg");
				String postContent = rs.getString("postcontent");
				int likeCnt = rs.getInt("likecnt");
				Timestamp regDate = rs.getTimestamp("regDate");
				int replyCnt = rs.getInt("replyCnt");
				
				Post post = new Post();
				post.setPno(pno);
				post.setUid(uid);
				post.setPfImg(pfimg);
				post.setPostImg(postimg);
				post.setPostContent(postContent);
				post.setLikeCnt(likeCnt);
				post.setRegDate(regDate);
				post.setReplyCnt(replyCnt);
				
				flist.add(post);						
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}		
		return flist;
	}
	
	public int getCnt() {
		int result = 0;
		
		Connection con = null;
		PreparedStatement stmt = null;
		String sql = null;
		ResultSet rs = null;
		
		try {
			con = DBcon.getConnection();
			sql = "select count(*) from post";
			stmt = con.prepareStatement(sql);
			rs = stmt.executeQuery();
			rs.next();
			result = rs.getInt("count(*)");
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
	//게시글 삭제 메소드
	public void delPost(int pno) {
		Connection con = null;
		String sql = "";
		PreparedStatement stmt = null;
		
		try {
			con = DBcon.getConnection();
			sql = "delete from post where pno=?";
			stmt = con.prepareStatement(sql);
			stmt.setInt(1, pno);
			
			stmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	//개별 게시글 내용 가져오는 메소드
	public Post getMyPost(int pno) {
		
		Connection con = null;
		String sql = "";
		PreparedStatement stmt = null;
		ResultSet rs = null;
		Post post = new Post();
		
		try {
			con = DBcon.getConnection();
			sql = "SELECT p.pno, p.uid, p.pfImg, p.postImg, p.postContent, p.likeCnt, p.regDate, r.replyCnt "
				    + "FROM post p "
				    + "LEFT JOIN v_reply r ON p.pno = r.pno "
				    + "WHERE p.pno=?";
			stmt = con.prepareStatement(sql);
			stmt.setInt(1, pno);
			rs = stmt.executeQuery();
			rs.next();
			
			int ppno = rs.getInt("pno");
			String uid = rs.getString("uid");
			String pfimg = rs.getString("pfimg");
			String postimg = rs.getString("postimg");
			String postContent = rs.getString("postcontent");
			int likeCnt = rs.getInt("likecnt");
			Timestamp regDate = rs.getTimestamp("regDate");
			int replyCnt = rs.getInt("replyCnt");
			
			post.setPno(ppno);
			post.setUid(uid);
			post.setPfImg(pfimg);
			post.setPostImg(postimg);
			post.setPostContent(postContent);
			post.setLikeCnt(likeCnt);
			post.setRegDate(regDate);
			post.setReplyCnt(replyCnt);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return post;
	}
	
	
}
