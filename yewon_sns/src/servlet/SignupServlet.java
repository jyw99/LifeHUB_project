package servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.UserDao;
import vo.User;

@WebServlet("/signup")
public class SignupServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String name = request.getParameter("name");
		String id = request.getParameter("id");
		String pw = request.getParameter("pw");
		String tel = request.getParameter("tel");
		String gender = request.getParameter("gender");
		String age_ = request.getParameter("age");
		String info = request.getParameter("info");
		int age = Integer.parseInt(age_);
		
		
		User user = new User();
		user.setUname(name);
		user.setUid(id);
		user.setUpw(pw);
		user.setTel(tel);
		user.setGender(gender);
		user.setAge(age);
		user.setInfo(info);
		
		UserDao dao = new UserDao();
		dao.insertUser(user);
		
		
		response.sendRedirect("login.jsp");
		
	}

}
