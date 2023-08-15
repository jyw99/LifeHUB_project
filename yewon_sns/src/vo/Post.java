package vo;


import java.sql.Timestamp;

import lombok.Data;

@Data
public class Post {
	
	private int pno;
	private String uid;
	private String pfImg;
	private String postImg;
	private String postContent;
	private int likeCnt;
	private Timestamp regDate;
	private int replyCnt;
}
