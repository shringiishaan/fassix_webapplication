<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="manager.AdminManager" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
  <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1.0"/>
  <title>HomeSolutions | Admin</title>
  <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
  <link href="css/materialize.css" type="text/css" rel="stylesheet" media="screen,projection"/>
  <link href="css/style.css" type="text/css" rel="stylesheet" media="screen,projection"/>
</head>
<body>  
	<div class="navbar-fixed">
		<nav class="cyan">
			<a href="#" data-activates="slide-out" style="display:block;" class="button-collapse"><i class="material-icons">menu</i></a>
			<ul id="nav-mobile" class="right hide-on-med-and-down">
				<li><a href="Home.jsp">Our Services</a></li>
				<li><a href="About.jsp">About</a></li>
			</ul>
		</nav>
	</div>
	<ul id="slide-out" class="side-nav">
		<li><a class="waves-effect" href="Home.jsp"><i class="material-icons">dashboard</i>Home</a></li>
		<li>
	    	<ul class="collapsible collapsible-accordion">
	        	<li>
	            	<a class="collapsible-header waves-effect">
	            		<i class="material-icons">business</i>Our Services<i class="material-icons right">arrow_drop_down</i></a>
	            	<div class="collapsible-body">
	              		<ul>
	                		<li><a href="Home.jsp">Electrician Services</a></li>
	                		<li><a href="Home.jsp">Plumber Services</a></li>
	                		<li><a href="Home.jsp">Carpenter Services</a></li>
	                		<li><a href="Home.jsp">Car Services</a></li>
	                		<li><a href="Home.jsp">Cleaning Services</a></li>
	                		<li><a href="Home.jsp">Air Conditioner Services</a></li>
	                		<li><a href="Home.jsp">Washing Machine Services</a></li>
	                		<li><a href="Home.jsp">Water Purifier Services</a></li>
	                		<li><a href="Home.jsp">Refrigerator Services</a></li>
	                		<li><a href="Home.jsp">Television Services</a></li>
	                		<li><a href="Home.jsp">Geyser Services</a></li>
	                		<li><a href="Home.jsp">Pest Control</a></li>
	              		</ul>
	            	</div>
	          	</li>
        	</ul>
	    </li>
		<li><a class="waves-effect" href="Home.jsp"><i class="material-icons">language</i>Explore</a></li>
		<li><div class="divider"></div></li>
		<li><a class="waves-effect" href="Login.jsp"><i class="material-icons">perm_identity</i>Login</a></li>
		<li><a class="waves-effect" href="NewRegistration.jsp"><i class="material-icons">input</i>Register</a></li>
		<li><a class="waves-effect" href="Home.jsp"><i class="material-icons">info_outline</i>About Us</a></li>
		<li><a class="waves-effect" href="Home.jsp"><i class="material-icons">call</i>Contact</a></li>
	</ul>
	
	<div class="container">
    	<div class="row">
        	<form method="post" action="LoginController" class="col s10 offset-s1 m6 offset-m3 l4 offset-l4">
    			<div class="row">
    			<br>
    				Home Page Hit Counter : <%= (new AdminManager()).getHomePageCount() %><br> 
    				<h4>Login</h4>
    				<br>
			<% 
				if(session.getAttribute("error")!=null)
				{
					out.println("Error : " + session.getAttribute("error"));
					session.removeAttribute("error");
				}
				if(session.getAttribute("message")!=null)
				{
					out.println("Message : " + session.getAttribute("message"));
					session.removeAttribute("message");
				}
			%>
        			<div class="input-field">
          				<input name="email" id="email" type="email" class="validate" />
          				<label for="email" data-error="wrong" data-success="right">Email</label>
        			</div>
        			<div class="input-field">
          				<input name="password" id="password" type="password" class="validate" />
          				<label for="password" data-error="wrong" data-success="right">Password</label>
        			</div>
          			<input name="a" value="1" hidden="true" />
        			<div class="input-field">          				
						<button class="btn waves-effect waves-light" type="submit" name="action">Login
					    	<i class="material-icons right">send</i>
					  	</button>
        			</div>
      			</div>
    		</form>	
	    </div>
	</div>

  <footer class="page-footer orange">
    <div class="container">
      <div class="row">
        <div class="col l6 s12">
          <h5 class="white-text">Company Bio</h5>
          <p class="grey-text text-lighten-4">We are a team of college students working on this project like it's our full time job. Any amount would help support and continue development on this project and is greatly appreciated.</p>


        </div>
        <div class="col l3 s12">
          <h5 class="white-text">Settings</h5>
          <ul>
            <li><a class="white-text" href="#!">Link 1</a></li>
            <li><a class="white-text" href="#!">Link 2</a></li>
            <li><a class="white-text" href="#!">Link 3</a></li>
            <li><a class="white-text" href="#!">Link 4</a></li>
          </ul>
        </div>
        <div class="col l3 s12">
          <h5 class="white-text">Connect</h5>
          <ul>
            <li><a class="white-text" href="#!">Link 1</a></li>
            <li><a class="white-text" href="#!">Link 2</a></li>
            <li><a class="white-text" href="#!">Link 3</a></li>
            <li><a class="white-text" href="#!">Link 4</a></li>
          </ul>
        </div>
      </div>
    </div>
    <div class="footer-copyright">
      <div class="container">
      Made by <a class="orange-text text-lighten-3" href="http://materializecss.com">Materialize</a>
      </div>
    </div>
  </footer>


  <!--  Scripts-->
  <script src="https://code.jquery.com/jquery-2.1.1.min.js"></script>
  <script src="js/materialize.js"></script>
  <script src="js/init.js"></script>

  </body>
</html>