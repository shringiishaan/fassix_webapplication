<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.*,controller.*,manager.*,java.util.*" %>
<%! 
	Admin admin;
	AdminManager adminM = new AdminManager();
	Worker worker;
	WorkerManager workerM = new WorkerManager();
	ArrayList<Worker> workers;
	Iterator<Worker> workersI;
	Order temporder;
	OrderManager orderM = new OrderManager();
	ArrayList<Order> orders;
	Iterator<Order> ordersI;
	LocationManager locationM = new LocationManager();
	Location location;
	ServiceManager serviceM = new ServiceManager();
	Service service,thisService;
	ArrayList<Service> services;
	Iterator<Service> servicesI;
	
%>

<% 

	if(session.getAttribute("admin_id")==null)
	{
		response.sendRedirect("Logout");
	}
	else
	{
		admin = adminM.getAdminByID((int)session.getAttribute("admin_id"));
		
		if(request.getParameter("serviceid")!=null)
		{
			thisService = serviceM.getServiceByID(Integer.parseInt(request.getParameter("serviceid")));
		}
		else thisService = null;
%>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
  <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1.0"/>
  <title>Fassix | Admin Manage Orders</title>
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
						<a href="AdminOrders" style="margin:5px;width:100%;" class="btn waves-effect waves-teal black-text teal">Manage Orders</a>
						<a href="AdminOrdersHistory" style="margin:5px;width:100%;" class="btn waves-effect waves-teal black-text grey lighten-4">Order History</a>
						<a href="AdminWorkers" style="margin:5px;width:100%;" class="btn waves-effect waves-teal black-text grey lighten-4">Workers</a>
						<a href="AdminServices" style="margin:5px;width:100%;" class="btn waves-effect waves-teal black-text grey lighten-4">Services</a>
					</div>
					<div class="col s12 m9 l10">
						<h4>Manage Orders</h4>
						<hr>
						<a href='AdminOrders' class='btn waves-effect waves-teal black-text <%= (thisService==null)?"grey lighten-2":"grey lighten-3" %>'>All</a>
			
			<%  
				services = serviceM.getServices(" name asc ");
				servicesI = services.iterator();
          		while(servicesI.hasNext())
          		{
          			service = servicesI.next();
		   			out.println("<a href='AdminOrders?serviceid="+service.getID()+"' class='btn waves-effect waves-teal black-text "+((thisService!=null && service.getID()==thisService.getID())?"  grey lighten-2 ":" grey lighten-3 ")+" '>"+service.getName()+"</a> ");
				}
            %>
            	<hr>
					<div class="row">
				<%  
				
				if(thisService!=null)
					orders = orderM.getOrders(" serviceid = "+ thisService.getID() + " ");
				else
					orders = orderM.getOrders();
          		
				ordersI = orders.iterator();
          		while(ordersI.hasNext())
          		{
          			temporder = ordersI.next();
          			service = serviceM.getServiceByID(temporder.getServiceID());
          			location = locationM.getLocationByID(temporder.getClientLocationID());
		   			out.println(
		   			"<div class='col s12 m3 card' style='padding:10px;'><h5>" + temporder.getID() + " : " + service.getName() +
				      "</h5><b>Contact</b> : " + temporder.getClientContact() + 
				      "<br><b>Address</b> : " + temporder.getClientAddress() + 
				      "<br><b>Area</b> : " + location.getArea() + 
				      "<br><b>City</b> : " + location.getCity() + 
				      "<br><b>Note</b> : " + temporder.getNote() +
				      "<br><br><a href='#order"+temporder.getID()+"' class='waves-effect waves-light btn green'>Done</a></div>");
				}
            %>
	            	</div>
	            </div>
	     </div>
	</div> 
	</div> 	
 </div>
 	
<%
	ordersI = orders.iterator();
	while(ordersI.hasNext())
	{
		temporder = ordersI.next();
   		%>
			<div id="order<%= temporder.getID() %>" class="modal modal-fixed-footer teal lighten-5">
				<form action="OrderController" method="post">
					<div class="modal-content">
			    		<h4><%= (temporder.getID() + temporder.getClientAddress()) %></h4><br>
				        <div class="input-field col s12">
						    <select name="orderworkerid">
						      <option value="" disabled selected>Choose a Worker</option>
						      <%
						      	workers = workerM.getWorkers(" name asc ");
						      	workersI = workers.iterator();
								while(workersI.hasNext())
								{
									worker = workersI.next();
									out.println("<option value='"+worker.getID()+"'>"+worker.getName()+"</option>");
								}
						      %>
						    </select>
						    <label>Select Worker</label>
						</div>
				        <div class="input-field col s12">
				        	<input hidden="true" name="completeorderid" type="text" value="<%= temporder.getID() %>" />
							<input id="orderlabourcost" name="orderlabourcost" type="text" />
							<label for="orderlabourcost">Labour Cost</label>
				        </div>
				        <div class="input-field col s12">
							<input id="ordermaterialcost" name="ordermaterialcost" type="text" />
							<label for="ordermaterialcost">Material Cost</label>
				        </div>
				        <div class="input-field col s12">
							<input id="ordervisitingcost" name="ordervisitingcost" type="text" />
							<label for="ordervisitingcost">Visiting Cost</label>
				        </div>
				        <div class="input-field col s12">
							<input id="orderincome" name="orderincome" type="text" />
							<label for="orderincome">Income</label>
				        </div>
				        <div class="input-field col s12">
							<input id="orderdebt" name="orderdebt" type="text" />
							<label for="orderdebt">Worker's Debt (+ to take, - to give)</label>
				        </div>
				      	<a href="RemoveOrder?oid=<%= temporder.getID() %>" style="margin-top:100px;" class="waves-effect waves-green btn red white-text">Delete Order</a>
				    </div>
				    <div class="modal-footer teal lighten-3">
				      	<a href="#"  style='margin-left:10px;' class="modal-action modal-close waves-effect btn large white black-text">Back</a>
				      	<input type="submit"  style='margin-left:10px;' class="waves-effect waves-green btn teal" value="Complete" />
				    </div>
				</form>
			 </div>
		<%
   	}
%>
	 
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
	

    $(document).ready(function()
	{
	    $('.modal').modal({startingTop: '0%',
	    	      endingTop: '0%'});
	    $('select').material_select();
	});
	
  </script>
  </body>
  <% } %>
</html>
