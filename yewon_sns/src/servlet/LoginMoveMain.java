package servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.AdminDao;
import dao.UserDao;
import vo.Admin;

@WebServlet("/movemain")
public class LoginMoveMain extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		String id = request.getParameter("id");
		String pw = request.getParameter("pw");

		if (id.contains("admin")) {
			HttpSession session = request.getSession();
			session.setAttribute("id", id);
			response.sendRedirect("adminMain.jsp");
		}else {
			HttpSession session = request.getSession();
			//로그인 성공해서 request로 보내는거임.. 
			session.setAttribute("id", id);
			session.setAttribute("pw", pw);
			response.sendRedirect("postlist");

		}
	}

}
