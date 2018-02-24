<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.*,controller.*,manager.*,java.util.*" %>
<%! 
	Admin admin;
	AdminManager adminM = new AdminManager();
	ServiceManager serviceM = new ServiceManager();
	Service service;
	ArrayList<Service> services;
	Iterator<Service> serviceI;
	OrderManager orderM = new OrderManager();
	Location location;
	LocationManager locationM = new LocationManager();
	ArrayList<Location> locations;
	Iterator<Location> locationsI;
	WorkerManager workerM = new WorkerManager();
	ArrayList<Worker> workers;
	Iterator<Worker> workersI;
	Worker worker;
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
  <title>Fassix | Admin Panel</title>
  <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
  <link href="css/materialize.css" type="text/css" rel="stylesheet" media="screen,projection"/>
  <link href="css/style.css" type="text/css" rel="stylesheet" media="screen,projection"/>
  <link rel="icon" type="image/x-icon" href="images/icon.ico" />
</head>
<body>
<div>
  <div class="main teal lighten-5">
		<div class="container" style="width:100%;margin:0px;padding:10px;">
	    	<div class="section">
	    		<div class='row'>
					<img id="mainicon" src="images/mainicon.png" class="responsive-img" />
				</div>
				<div class="row">
					<div class="col s12 m3 l2" style="padding-top:70px;">
						<a href="AdminPanel" style="margin:5px;width:100%;" class="btn waves-effect waves-teal black-text teal">DashBoard</a>
						<a href="AdminOrders" style="margin:5px;width:100%;" class="btn waves-effect waves-teal black-text grey lighten-4">Manage Orders</a>
						<a href="AdminOrdersHistory" style="margin:5px;width:100%;" class="btn waves-effect waves-teal black-text grey lighten-4">Order History</a>
						<a href="AdminWorkers" style="margin:5px;width:100%;" class="btn waves-effect waves-teal black-text grey lighten-4">Workers</a>
						<a href="AdminServices" style="margin:5px;width:100%;" class="btn waves-effect waves-teal black-text grey lighten-4">Services</a>
					</div>
					<div class="col s12 m9 l10">
						<h4>DashBoard</h4>
						<hr>
						<p><b>Home Page Hits : </b><%= (new AdminManager()).getHomePageCount() %></p>
						
						<table class="responsive-table">
							<thead>
								<tr>
									<th>Name</th>
									<th>Debt</th>
									<th>Orders Completed</th>
									<th></th>
								</tr>
							</thead>
							<tbody>
							<%
								workersI = workerM.getWorkers(" name asc ").iterator();
								while(workersI.hasNext())
								{
									worker = workersI.next();
									
									out.println("<tr><td>"+worker.getName()+"</td>"
													+"<td>" + workerM.getDebtByID(worker.getID()) + "</td>"
													+"<td>" + workerM.getOrdersCountByWorkerID(worker.getID())
													+"</td><td><a href='WorkerController?clwkid="+worker.getID()+"'>Clear Debt</a></td></tr>");
								}
							%>
							</tbody>
						</table>
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
