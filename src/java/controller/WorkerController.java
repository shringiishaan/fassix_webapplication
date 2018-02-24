package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import manager.LocationManager;
import manager.OrderManager;
import manager.WorkerManager;
import model.Location;
import model.Order;
import model.Worker;
import model.Task;

public class WorkerController extends HttpServlet 
{
	private static final long serialVersionUID = 1L;
    public WorkerController() 
    {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		try
		{
			HttpSession session = request.getSession();
			
			Worker worker = new Worker();
			WorkerManager workerM = new WorkerManager();
			
			if(request.getParameter("updateworkerid")!=null)
			{
				int workerid = Integer.parseInt(request.getParameter("updateworkerid"));
				String name = request.getParameter("workername");
				String contact = request.getParameter("workercontact");
				
				worker.setID(workerid);
				worker.setName(name);
				worker.setContact(contact);
				
				if(workerM.updateWorkerByID(worker)==1)
				{
					session.setAttribute("message","Worker Updated !");
					response.sendRedirect("AdminWorkers");
				}
				else
				{
					response.sendRedirect("Logout");
				}
			}
			else if(request.getParameter("newworkername")!=null)
			{
				String name = request.getParameter("newworkername");
				String contact = request.getParameter("newworkercontact");
				
				worker.setName(name);
				worker.setContact(contact);
				
				if(workerM.createWorker(worker)==1)
				{
					session.setAttribute("message","New Worker created !");
					response.sendRedirect("AdminWorkers");
				}
				else
				{
					response.sendRedirect("Logout");
				}
			}
			else if(request.getParameter("clwkid")!=null)
			{
				int id = Integer.parseInt(request.getParameter("clwkid"));
				workerM.clearWorkerDebtByID(id);
				session.setAttribute("message","Worker's Debt Cleared !");
				response.sendRedirect("AdminPanel");
			}
			else
			{
				response.sendRedirect("Logout");
			}
		}
		catch(Exception e)
		{
			System.out.println("System Error : WorkerController : " + e);
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		doGet(request, response);
	}
}
