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

public class TaskController extends HttpServlet 
{
	private static final long serialVersionUID = 1L;
    public TaskController() 
    {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		try
		{
			HttpSession session = request.getSession();
			
			Service service = null;
			ServiceManager serviceM = new ServiceManager();
			
			if(request.getParameter("updatetaskid")!=null)
			{
				int taskid = Integer.parseInt(request.getParameter("updatetaskid"));
				String name = request.getParameter("taskname");
				int cost = Integer.parseInt(request.getParameter("taskcost"));
				
				Task task = new Task();
				task.setID(taskid);
				task.setTask(name);
				task.setCost(cost);
				
				if(serviceM.updateTaskByID(task)==1)
				{
					session.setAttribute("message","Task Updated !");
					response.sendRedirect("AdminServices");
				}
				else
				{
					response.sendRedirect("Logout");
				}
			}
			else if(request.getParameter("newtaskserviceid")!=null)
			{
				String newtaskserviceid = request.getParameter("newtaskserviceid");
				String newtaskname = request.getParameter("newtaskname");
				String newtaskcost = request.getParameter("newtaskcost");
				
				service = serviceM.getServiceByID(Integer.parseInt(newtaskserviceid));
	
				if(service==null)
				{
					session.setAttribute("error","Some issue !");
					response.sendRedirect("Logout");
				}
				else
				{
					Task task = new Task();
					task.setServiceID(service.getID());
					task.setTask(newtaskname);
					task.setCost(Integer.parseInt(newtaskcost));
					if(serviceM.createTask(task)==1)
					{
						session.setAttribute("message","New Task created !");
						response.sendRedirect("AdminServices");
					}
					else
					{
						response.sendRedirect("Logout");
					}
				}
			}
			else
			{
				response.sendRedirect("Logout");
			}
		}
		catch(Exception e)
		{
			System.out.println("System Error : TaskController : " + e);
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		doGet(request, response);
	}
}
