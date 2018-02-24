package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import manager.AdminManager;
import manager.OrderManager;
import manager.ServiceManager;
import model.Admin;

public class RemoveService extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public RemoveService() 
    {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		try
		{
			HttpSession session = request.getSession();
			
			int serviceid = Integer.parseInt(request.getParameter("serviceid"));
			
			if(serviceid<1)
			{
				response.sendRedirect("Logout");
			}
			else 
			{
				ServiceManager serviceM = new ServiceManager();
				if(serviceM.deleteServiceByID(serviceid)!=1)
				{
					response.sendRedirect("Logout");
				}
				else
				{
					session.setAttribute("message","Service removed successfully !");
					response.sendRedirect("AdminServices");
				}
			}
		}
		catch(Exception e)
		{
			System.out.println("System Error : RemoveService : " + e);
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
