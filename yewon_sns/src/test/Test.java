package test;

import java.util.List;

import dao.UserDao;
import vo.User;

public class Test {

	
	public static void main(String[] args) {
		
		UserDao dao = new UserDao();
		List<User> list = dao.searchUser("w");
		System.out.println(list);
	}
}
