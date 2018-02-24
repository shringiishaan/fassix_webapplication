package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import manager.AdminManager;
import manager.OrderManager;
import model.Admin;

public class RemoveOrder extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public RemoveOrder() 
    {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		try
		{
			HttpSession session = request.getSession();
			
			AdminManager adminM = new AdminManager();
			Admin admin = adminM.getAdminByID((int)session.getAttribute("admin_id"));
			int oid = Integer.parseInt(request.getParameter("oid"));
			
			if(admin==null || oid<0)
			{
				session.setAttribute("error","Please Login as Admin to continue !");
				response.sendRedirect("Logout");
			}
			else 
			{
				OrderManager orderM = new OrderManager();
				if(orderM.removeOrder(oid)!=1)
				{
					session.setAttribute("error","Some Issue !");
					response.sendRedirect("Logout");
				}
				else
				{
					session.setAttribute("message","Order removed successfully !");
					response.sendRedirect("AdminOrders");
				}
			}
		}
		catch(Exception e)
		{
			System.out.println("System Error : RemoveOrder : " + e);
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
