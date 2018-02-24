package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import manager.AdminManager;
import manager.OrderManager;
import manager.WorkerManager;
import model.Admin;

public class RemoveWorker extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public RemoveWorker() 
    {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		try
		{
			HttpSession session = request.getSession();
			
			int workerid = Integer.parseInt(request.getParameter("workerid"));
			
			if(workerid<1)
			{
				response.sendRedirect("Logout");
			}
			else 
			{
				WorkerManager workerM = new WorkerManager();
				if(workerM.deleteWorkerByID(workerid)!=1)
				{
					response.sendRedirect("Logout");
				}
				else
				{
					session.setAttribute("message","Worker removed successfully !");
					response.sendRedirect("AdminWorkers");
				}
			}
		}
		catch(Exception e)
		{
			System.out.println("System Error : RemoveWorker : " + e);
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
