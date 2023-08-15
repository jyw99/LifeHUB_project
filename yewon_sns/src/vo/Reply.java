package vo;

import java.sql.Timestamp;

import lombok.Data;

@Data
public class Reply {
	
	private int rno;
	private String uid;
	private String content;
	private Timestamp regDate;
	private int pno;
}
