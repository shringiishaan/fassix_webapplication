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
	Task task;
	ArrayList<Task> tasks;
	Iterator<Task> tasksI;
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
  <title>Fassix | Admin Manage Services</title>
  <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
  <link href="css/materialize.css" type="text/css" rel="stylesheet" media="screen,projection"/>
  <link href="css/style.css" type="text/css" rel="stylesheet" media="screen,projection"/>
  <link rel="icon" type="image/x-icon" href="images/icon.ico" />
</head>
<body>
<div>
  <div class="main teal lighten-5">
		<div class="container" style="padding:10px;margin:0px;width:100%;">
	    	<div class="section">
	    		<div class='row'>
					<img id="mainicon" src="images/mainicon.png" class="responsive-img" />
				</div>
				<div class="row">
					<div class="col s12 m3 l2" style="padding-top:70px;">
						<a href="AdminPanel" style="margin:5px;width:100%;" class="btn waves-effect waves-teal black-text grey lighten-4">DashBoard</a>
						<a href="AdminOrders" style="margin:5px;width:100%;" class="btn waves-effect waves-teal black-text grey lighten-4">Manage Orders</a>
						<a href="AdminOrdersHistory" style="margin:5px;width:100%;" class="btn waves-effect waves-teal black-text grey lighten-4">Order History</a>
						<a href="AdminWorkers" style="margin:5px;width:100%;" class="btn waves-effect waves-teal black-text grey lighten-4">Workers</a>
						<a href="AdminServices" style="margin:5px;width:100%;" class="btn waves-effect waves-teal black-text teal">Services</a>
					</div>
					<div class="col s12 m9 l10">
						<h4>Manage Services</h4>
						<hr>
				<%  
					services = serviceM.getServices(" name asc ");
	          		serviceI = services.iterator();
	          		while(serviceI.hasNext())
	          		{
	          			service = serviceI.next();
	          			tasks = serviceM.getServiceTasks(service.getID());
	          			tasksI = tasks.iterator();
	          			out.println("<a href=\"#service"+service.getID()+"\" class=\"btn waves-effect waves-teal grey lighten-3 black-text\"> " + service.getName() + "</a> ");
	          			while(tasksI.hasNext())
						{
	          				task = tasksI.next();
	          				out.println("<a href=\"#task"+task.getID()+"\" class=\"btn waves-effect waves-teal black-text grey lighten-4\"> " + task.getTask() + " | "+ task.getCost() +" </a> ");
						}
	          			
	          			out.println("<hr>");
					}
	            %> 
	            	<a href="#newservice" class="btn waves-effect waves-teal black-text green small"> New Service </a><br><br>
	            	<a href="#newtask" class="btn waves-effect waves-teal black-text green small"> New Task </a>
	            	</div>
	            </div>
	     </div>
	</div> 
	</div> 	
 </div>
 
 	
<%  
	services = serviceM.getServices(" name asc ");
	serviceI = services.iterator();
	while(serviceI.hasNext())
	{
		service = serviceI.next();
		%>
		<div id="service<%= service.getID() %>" class="modal modal-fixed-footer teal lighten-5">
			<form action="ServiceController" method="post">
				<div class="modal-content">
		    		<h4><%= service.getName() %></h4><br>
			        <div class="input-field col s12">
						<input name="updateserviceid" type="text" hidden="true" value="<%= service.getID() %>" />
						<input id="servicename" name="servicename" type="text" value="<%= service.getName() %>" />
						<label for="servicename">Service Name</label>
			        </div>
			        <div class="input-field col s12">
						<textarea class="materialize-textarea" id="servicedescription" name="servicedescription"><%= service.getDescription() %></textarea>
						<label for="servicedescription">Service Description</label>
			        </div>
			      	<a href="RemoveService?serviceid=<%= service.getID() %>" style="margin-top:100px;"  class="waves-effect waves-green btn red white-text">Delete Service</a>
			    </div>
			    <div class="modal-footer teal lighten-3">
			      	<a href="#"  style='margin-left:10px;' class="modal-action modal-close waves-effect btn large white black-text">Back</a>
			      	<input type="submit"  style='margin-left:10px;' class="waves-effect waves-green btn teal" value="Update" />
			    </div>
			</form>
		 </div>
		<%
	}

	tasks = serviceM.getAllTasks();
   	tasksI = tasks.iterator();
	while(tasksI.hasNext())
	{
   		task = tasksI.next();
   		%>
			<div id="task<%= task.getID() %>" class="modal modal-fixed-footer teal lighten-5">
				<form action="TaskController" method="post">
					<div class="modal-content">
			    		<h4><%= task.getTask() %></h4><br>
				        <div class="input-field col s12">
				        	<input hidden="true" name="updatetaskid" type="text" value="<%= task.getID() %>" />
							<input id="taskname" name="taskname" type="text" value="<%= task.getTask() %>" />
							<label for="taskname">Task Name</label>
				        </div>
				        <div class="input-field col s12">
							<input id="taskcost" name="taskcost" type="text" value="<%= task.getCost() %>" />
							<label for="taskcost">Cost</label>
				        </div>
				      	<a href="RemoveTask?taskid=<%= task.getID() %>" style="margin-top:100px;" class="waves-effect waves-green btn red white-text">Delete Task</a>
				    </div>
				    <div class="modal-footer teal lighten-3">
				      	<a href="#"  style='margin-left:10px;' class="modal-action modal-close waves-effect btn large white black-text">Back</a>
				      	<input type="submit"  style='margin-left:10px;' class="waves-effect waves-green btn teal" value="Update" />
				    </div>
				</form>
			 </div>
		<%
   	}
%>
	 
	 
	<div id="newservice" class="modal modal-fixed-footer teal lighten-5">
		<form action="ServiceController" method="post">
			<div class="modal-content">
	    		<h4>New Service Form</h4><br>
		        <div class="input-field col s12">
					<input id="newservicename" name="newservicename" type="text" placeholder="Service Name" />
					<label for="newservicename">Service Name</label>
		        </div>
		        <div class="input-field col s12">
					<textarea class="materialize-textarea" id="newservicedescription" name="newservicedescription"></textarea>
					<label for="newservicedescription">Description</label>
		        </div>
		    </div>
		    <div class="modal-footer teal lighten-3">
		      	<a href="#"  style='margin-left:10px;' class="modal-action modal-close waves-effect btn large white black-text">Back</a>
		      	<input type="submit"  style='margin-left:10px;' class="waves-effect waves-green btn teal" value="Create" />
		    </div>
		</form>
	 </div>
	 
	 
	<div id="newtask" class="modal modal-fixed-footer teal lighten-5">
		<form action="TaskController" method="post">
			<div class="modal-content">
	    		<h4>New Task Form</h4><br>
		        <div class="input-field col s12">
				    <select name="newtaskserviceid">
				      <option value="" disabled selected>Choose a Service</option>
				      <%
				      	serviceI = services.iterator();
						while(serviceI.hasNext())
						{
							service = serviceI.next();
							out.println("<option value='"+service.getID()+"'>"+service.getName()+"</option>");
						}
				      %>
				    </select>
				    <label>Select Service</label>
				</div><br>
		        <div class="input-field col s12">
					<input id="newtaskname" name="newtaskname" type="text" placeholder="Task Name" />
					<label for="newtaskname">Task Name</label>
		        </div>
		        <div class="input-field col s12">
					<input id="newtaskcost" name="newtaskcost" type="text" placeholder="Task Cost" />
					<label for="newtaskcost">Cost (0 if not fixed)</label>
		        </div>
		    </div>
		    <div class="modal-footer teal lighten-3">
		      	<a href="#"  style='margin-left:10px;' class="modal-action modal-close waves-effect btn large white black-text">Back</a>
		      	<input type="submit"  style='margin-left:10px;' class="waves-effect waves-green btn teal" value="Create" />
		    </div>
		</form>
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
