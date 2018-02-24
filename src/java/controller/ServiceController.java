package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import manager.LocationManager;
import manager.OrderManager;
import manager.ServiceManager;
import model.Location;
import model.Order;
import model.Service;
import model.Task;

public class ServiceController extends HttpServlet 
{
	private static final long serialVersionUID = 1L;
    public ServiceController() 
    {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		try
		{
			HttpSession session = request.getSession();
			
			Service service = new Service();
			ServiceManager serviceM = new ServiceManager();
			
			if(request.getParameter("updateserviceid")!=null)
			{
				int serviceid = Integer.parseInt(request.getParameter("updateserviceid"));
				String name = request.getParameter("servicename");
				String description = request.getParameter("servicedescription");
				
				service.setID(serviceid);
				service.setName(name);
				service.setDescription(description);
				
				if(serviceM.updateServiceByID(service)==1)
				{
					session.setAttribute("message","Task Updated !");
					response.sendRedirect("AdminServices");
				}
				else
				{
					response.sendRedirect("Logout");
				}
			}
			else if(request.getParameter("newservicename")!=null)
			{
				String name = request.getParameter("newservicename");
				String description = request.getParameter("newservicedescription");
				
				service.setName(name);
				service.setDescription(description);
				
				if(serviceM.createService(service)==1)
				{
					session.setAttribute("message","New Service created !");
					response.sendRedirect("AdminServices");
				}
				else
				{
					response.sendRedirect("Logout");
				}
			}
			else
			{
				response.sendRedirect("Logout");
			}
		}
		catch(Exception e)
		{
			System.out.println("System Error : ServiceController : " + e);
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		doGet(request, response);
	}
}
