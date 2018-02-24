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
import manager.WorkerManager;
import model.Location;
import model.Order;
import model.Service;
import model.Worker;

public class OrderController extends HttpServlet 
{
	private static final long serialVersionUID = 1L;
    public OrderController() 
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
			Location location = null;
			LocationManager locationM = new LocationManager();
			
			if(request.getParameter("completeorderid")==null)
			{
				String contact = request.getParameter("contact");
				String address = request.getParameter("address");
				String serviceText = request.getParameter("service");
				String locationText = request.getParameter("location");
				String note = request.getParameter("note");
				
				location = locationM.getLocationByArea(locationText);
				service = serviceM.getServiceByName(serviceText);
	
				session.setAttribute("orderService",service.getName());
				session.setAttribute("orderAddress",address);
				session.setAttribute("orderCity",location.getCity());
				session.setAttribute("orderLocation",location.getArea());
				session.setAttribute("orderContact",contact);
			
				if(service==null || location==null )
				{
					
					session.setAttribute("error","Some issue !");
					response.sendRedirect("Logout");
				}
				else if(contact.length()!=10)
				{
					session.removeAttribute("orderContact");
					response.sendRedirect("Home");
				}
				else if(address.length()<4)
				{
					session.removeAttribute("orderAddress");
					response.sendRedirect("Home");
				}
				else
				{
					Order order = new Order();
					OrderManager orderM = new OrderManager();
					
					order.setClientAddress(address);
					order.setClientContact(contact);
					order.setClientLocationID(location.getID());
					order.setServiceID(service.getID());
					order.setNote(note);
					
					if(orderM.createOrder(order)==1)
					{
						session.removeAttribute("orderService");
						session.removeAttribute("orderAddress");
						session.removeAttribute("orderCity");
						session.removeAttribute("orderLocation");
						session.removeAttribute("orderContact");
						
						session.setAttribute("orderConfirm","true");
						session.setAttribute("orderConfirmServiceID",order.getServiceID());
						session.setAttribute("orderConfirmContact",order.getClientContact());
						response.sendRedirect("Home");
					}
					else
					{
						response.sendRedirect("Logout");
					}
				}
			}
			else if(session.getAttribute("admin_id")!=null)
			{
				Order order;
				OrderManager orderM = new OrderManager();
				WorkerManager workerM = new WorkerManager();
				Worker worker;
				String labourcost = request.getParameter("orderlabourcost");
				String materialcost = request.getParameter("ordermaterialcost");
				String visitingcost = request.getParameter("ordervisitingcost");
				String debt = request.getParameter("orderdebt");
				String income = request.getParameter("orderincome");
				
				order = orderM.getOrderByID(Integer.parseInt(request.getParameter("completeorderid")));
				worker = workerM.getWorkerByID(Integer.parseInt(request.getParameter("orderworkerid"))); 
				
				if(order == null || worker ==null)
				{
					response.sendRedirect("Logout");
				}
				else
				{
					order.setWorkerID(worker.getID());
					order.setLabourCost(labourcost);
					order.setMaterialCost(materialcost);
					order.setVisitingCost(visitingcost);
					order.setDebt(debt);
					order.setIncome(income);
					
					if(orderM.removeOrder(order.getID())==1)
					{
						orderM.createOrderInHistory(order);
						session.setAttribute("message","Order Completed and added to History !");
						response.sendRedirect("AdminOrders");
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
			System.out.println("System Error : OrderController : " + e);
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		doGet(request, response);
	}
}
