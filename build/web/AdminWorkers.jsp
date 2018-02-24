<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.*,controller.*,manager.*,java.util.*" %>
<%! 
	Admin admin;
	AdminManager adminM = new AdminManager();
	Worker worker;
	WorkerManager workerM = new WorkerManager();
	ArrayList<Worker> workers;
	Iterator<Worker> workersI;
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
  <title>Fassix | Admin Manage Workers</title>
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
						<a href="AdminWorkers" style="margin:5px;width:100%;" class="btn waves-effect waves-teal black-text teal">Workers</a>
						<a href="AdminServices" style="margin:5px;width:100%;" class="btn waves-effect waves-teal black-text grey lighten-4">Services</a>
					</div>
					<div class="col s12 m9 l10">
						<h4>Manage Workers</h4>
						<hr>
				<%  
					workers = workerM.getWorkers(" name asc ");
	          		workersI = workers.iterator();
	          		while(workersI.hasNext())
	          		{
	          			worker = workersI.next();
	          			out.println("<a href=\"#worker"+worker.getID()+"\" class=\"btn waves-effect waves-teal grey lighten-3 black-text\"> " + worker.getName() + "</a> <br><br> ");
					}
	            %> 
	            	<a href="#newworker" class="btn waves-effect waves-teal black-text green small"> New Worker </a>
	            	
	            	</div>
	            </div>
	     </div>
	</div> 
	</div> 	
 </div>
 
 	
<%  
	workers = workerM.getWorkers(" name asc ");
	workersI = workers.iterator();
	while(workersI.hasNext())
	{
		worker = workersI.next();
		%>
		<div id="worker<%= worker.getID() %>" class="modal modal-fixed-footer teal lighten-5">
			<form action="WorkerController" method="post">
				<div class="modal-content">
		    		<h4><%= worker.getName() %></h4><br>
			        <div class="input-field col s12">
						<input name="updateworkerid" type="text" hidden="true" value="<%= worker.getID() %>" />
						<input id="workername" name="workername" type="text" value="<%= worker.getName() %>" />
						<label for="workername">Worker Name</label>
			        </div>
			        <div class="input-field col s12">
						<input id="workercontact" name="workercontact" type="text" value="<%= worker.getContact() %>" />
						<label for="workercontact">Worker Contact</label>
			        </div>
			      	<a href="RemoveWorker?workerid=<%= worker.getID() %>" style="margin-top:100px;"  class="waves-effect waves-green btn red white-text">Delete Worker</a>
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
	 
	 
	<div id="newworker" class="modal modal-fixed-footer teal lighten-5">
		<form action="WorkerController" method="post">
			<div class="modal-content">
	    		<h4>New Worker Form</h4><br>
		        <div class="input-field col s12">
					<input id="newworkername" name="newworkername" type="text" placeholder="Worker Name" />
					<label for="newworkername">Worker Name</label>
		        </div>
		        <div class="input-field col s12">
					<input id="newworkercontact" name="newworkercontact" type="text" placeholder="9999999999" />
					<label for="newworkercontact">Worker Contact</label>
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
