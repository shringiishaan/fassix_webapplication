<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.*,controller.*,manager.*,java.util.*" %>
<%! 
	Admin admin;
	AdminManager adminM = new AdminManager();
	Worker worker;
	WorkerManager workerM = new WorkerManager();
	Order order;
	OrderManager orderM = new OrderManager();
	ArrayList<Order> orders;
	Iterator<Order> ordersI;
	LocationManager locationM = new LocationManager();
	Location location;
	ServiceManager serviceM = new ServiceManager();
	Service service;
	
%>

<% 

	if(session.getAttribute("admin_id")==null)
	{
		response.sendRedirect("Logout");
	}
	else
	{
		admin = adminM.getAdminByID((int)session.getAttribute("admin_id"));
%>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
  <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1.0"/>
  <title>Fassix | Admin Orders History</title>
  <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
  <link href="css/materialize.css" type="text/css" rel="stylesheet" media="screen,projection"/>
  <link href="css/style.css" type="text/css" rel="stylesheet" media="screen,projection"/>
  <link rel="icon" type="image/x-icon" href="images/icon.ico" />
</head>
<body>
  <div class="main teal lighten-5">
		<div class="container" style="width:100%;margin:0px;padding:10px;">
	    	<div class="section">
	    		<div class='row'>
					<img id="mainicon" src="images/mainicon.png" class="responsive-img" />
				</div>
				<div class="row">
					<div class="col s12 m3 l2" style="padding-top:70px;">
						<a href="AdminPanel" style="margin:5px;width:100%;" class="btn waves-effect waves-teal black-text grey lighten-4">DashBoard</a>
						<a href="AdminOrders" style="margin:5px;width:100%;" class="btn waves-effect waves-teal black-text grey lighten-4">Manage Orders</a>
						<a href="AdminOrdersHistory" style="margin:5px;width:100%;" class="btn waves-effect waves-teal black-text teal">Order History</a>
						<a href="AdminWorkers" style="margin:5px;width:100%;" class="btn waves-effect waves-teal black-text grey lighten-4">Workers</a>
						<a href="AdminServices" style="margin:5px;width:100%;" class="btn waves-effect waves-teal black-text grey lighten-4">Services</a>
					</div>
					<div class="col s12 m9 l10">
						<h4>Orders History</h4>
						<hr>
				<%  
				
				orders = orderM.getOrdersHistory();
				ordersI = orders.iterator();
          		while(ordersI.hasNext())
          		{
          			order = ordersI.next();
          			service = serviceM.getServiceByID(order.getServiceID());
          			location = locationM.getLocationByID(order.getClientLocationID());
		   			out.println(
		   			"<div class='card' style='padding:5px;'><b>" + service.getName() +
				      "</b><b> | Contact</b> : " + order.getClientContact() + 
				      "<b> | Address</b> : " + order.getClientAddress() + 
				      "<b> | Area</b> : " + location.getArea() + 
				      "<b> | City</b> : " + location.getCity() + 
				      "<b> | Note</b> : " + order.getNote() +  
				      "<b> | Worker</b> : " + workerM.getWorkerByID(order.getWorkerID()).getName() +
				      "<b> | Material Cost</b> : " + order.getMaterialCost() + 
				      "<b> | Visiting Cost</b> : " + order.getVisitingCost() + 
				      "<b> | Labour Cost</b> : " + order.getLabourCost() + 
				      "<b> | Income</b> : " + order.getIncome() + 
				      "<b> | Debt</b> : " + order.getDebt() +
				      "<br><a class='red' href='RemoveOrderRecord?oid="+order.getID()+"'>(delete)</a></div>");
				}
            %>
	            	</div>
	            </div>
	     </div>
	</div> 
	</div> 	
 </div>
 		 
  <script src="https://code.jquery.com/jquery-2.1.1.min.js"></script>
  <script src="js/materialize.js"></script>
  <script src="js/init.js"></script>
  <script>
  
  	<% 
	
		if(session.getAttribute("error")!=null)
		{
			out.println("Materialize.toast('" + session.getAttribute("error")+ "', 4000); ");
			session.removeAttribute("error");
		}
		if(session.getAttribute("message")!=null)
		{
			out.println("Materialize.toast('" + session.getAttribute("message")+ "', 4000); ");
			session.removeAttribute("message");
		}
	%>

	
  </script>
  </body>
  <% } %>
</html>
