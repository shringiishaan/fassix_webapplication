package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import manager.AdminManager;
import model.Admin;

public class LoginController extends HttpServlet 
{
	private static final long serialVersionUID = 1L;
    public LoginController() 
    {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		try
		{
			HttpSession session = request.getSession();
			
			Admin admin;
			AdminManager adminM = new AdminManager();
			
			String email = request.getParameter("email");
			String password = request.getParameter("password");
			
			if(!adminM.validateAdmin(email, password))
			{
				session.setAttribute("error","Some issue !");
				response.sendRedirect("Logout");
			}
			else
			{
				admin = adminM.getAdminByEmail(email);
				if(admin!=null)
				{
					session.setAttribute("message","Welcome "+admin.getName()+" as Admin !");
					session.setAttribute("admin_id",admin.getID());
					response.sendRedirect("AdminPanel");
				}
			}
		}
		catch(Exception e)
		{
			System.out.println("System Error : LoginController : " + e);
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		doGet(request, response);
	}
}
