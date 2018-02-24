<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.*,controller.*,manager.*,java.util.*" %>
<%! 
	Boolean isAdmin=false;
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
%>

<% 

	adminM.homePageCountIncrement();
	
	if(session.getAttribute("admin_id")!=null)
	{
		admin = adminM.getAdminByID((int)session.getAttribute("admin_id"));
		if(admin!=null) isAdmin = true;
	}
	else
	{
		isAdmin = false;
	}
%>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
  <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1.0"/>
  <title>Fassix | Home</title>
  <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
  <link href="css/materialize.css" type="text/css" rel="stylesheet" media="screen,projection"/>
  <link href="css/style.css" type="text/css" rel="stylesheet" media="screen,projection"/>
  <link rel="icon" type="image/x-icon" href="images/icon.ico" />
</head>
<body>
		<div id="iloader" style="width:100%;height:100%;max-height:100%;z-index:1500;position:fixed;" class="teal lighten-5">
		  <div class="preloader-wrapper small active" style="left:50%;top:50%;">
		    <div class="spinner-layer spinner-teal-only">
		      <div class="circle-clipper left">
		        <div class="circle"></div>
		      </div><div class="gap-patch">
		        <div class="circle"></div>
		      </div><div class="circle-clipper right">
		        <div class="circle"></div>
		      </div>
		    </div>
		  </div>
		</div>
<div id="pagedata">
  <div class="main teal lighten-5">
		<div class="container">
	    	<div class="section">
	    		<div class='row'>
					<img id="mainicon" src="images/mainicon.png" class="responsive-img" />
				</div>
	    		<div class='row'>
	    			<div style="text-align:center;" class='col s10 offset-s1 m6 offset-m3 l4 offset-l4 card  grey lighten-4'>
					  <a style="margin:10px 0px 10px 0px;padding:0px 10px 0px 10px;min-width:210px;" class='dropdown-button btn' href='#' data-activates='citydropdown'>Select your City&nbsp;<i class="right material-icons prefix">person_pin</i></a>
						<ul id='citydropdown' class='dropdown-content'>
						    <li><a href="#" onclick="setBookingCity('kota')">Kota</a></li>
							<li><a href="#" onclick="setBookingCity('surat')">Surat</a></li>
						</ul>
				  	</div>
				</div>
				<div class="row" style="padding:10px;">
					<h4>Our Services</h4>
					<p class="font15-5">Choose from a wide range of housing services provided by us and you will receive a call from us shortly or call on +91-7023038492 to directly fix a schedule</p>
					<br>
					
				<%  
					int i = 0;
					services = serviceM.getServices(" name asc ");
	          		serviceI = services.iterator();
	          		while(serviceI.hasNext())
	          		{
	          			i++;
	          			service = serviceI.next();
			   			out.println((i==4?"</div><div class='row center'>":"")+
				          	"<div class='col s12 m6 l4"+(i==4?" offset-l2 ":"")+"'>"+
			   					"<div class='card grey lighten-4 maincard'>" +
				            		"<div class='card-content row'>" +
							   			"<div>" +
							            	"<img src=\"images/"+service.getID()+".png\" alt=\"\" class=\"grey lighten-4 responsive-img mainserviceicon\">" +
							          	"</div>" +
							          	"<div>" +
							            	"<span class='card-title mainservicetitle'>" +
							            		   service.getName()+
							              	"</span>" + 
							        	"</div>" +
							            "<p class='mainservicedescription font15-5'>"+ service.getDescription() +"</p><br>" +
										"<a href='#' onclick=\"setBookingService('"+service.getName()+"')\" class='waves-effect dropdown-button waves-light btn grey lighten-2 black-text'>Book<i class='material-icons right'>play_arrow</i></a>" +
									"</div>"+
					       		"</div>"+
							"</div>");
					}
	            %>   
	            	
	            </div>
				<div class="row">
					<h4>Why choose us ?</h4>
					<p class="font15-5">Choose from a wide range of housing services provided by us and you will receive a call from us shortly</p>
					<br>
					<div class='col s12 m3 offset-m2'>
						<div class='maincard'>
				            <div class='card-content row'>
							   	<div>
							        <img src="images/verified.png" alt="" class="responsive-img mainserviceicon">
							    </div>
							    <div>
							        <span class='card-title mainservicetitle'>Verified Professionals</span> 
							    </div>
							    <p class='mainservicedescription font15-5'>We only hire experienced professionals to do your job who strive to complete it in minimum time</p>
							</div>
					    </div>
					</div>
					<div class='col s12 m3 offset-m2'>
						<div class='maincard'>
				            <div class='card-content row'>
							   	<div>
							        <img src="images/reliable.png" alt="" class="responsive-img mainserviceicon">
							    </div>
							    <div>
							        <span class='card-title mainservicetitle'>Reliable Service</span> 
							    </div>
							    <p class='mainservicedescription font15-5'>To ensure high quality services, we guarantee our work, so that you can rely on us 100%</p>
							</div>
					    </div>
					</div>
	            </div>
	            
	     </div>
	</div> 
	</div> 	
   <footer class="page-footer teal lighten-1">
   <div class="container">
      <div class="row">
        <div class="col l6 s12">
          <h5 class="white-text">About Us</h5>
          <p class="grey-text text-lighten-4">We are a team of college students working on this start-up to help make cities smarter</p>
        </div>
        <div class="col l3 offset-l3 s12">
          <h5 class="white-text">Our Team</h5>
          <ul>
            <li><a class="white-text" href="">Ishaan Shringi</a></li>
            <li><a class="white-text" href="">Shivam Shringi</a></li>
          </ul>
        </div>
      </div>
    </div>
    <div class="footer-copyright">
      <div class="container">
      Made by <a class="orange-text text-lighten-3" href="">Ishaan</a>
      </div>
    </div>
  </footer>
	<a class='fixedbutton btn waves-effect' href='#' onclick='bookClient()'>Quick Book &nbsp;<i class="material-icons">fast_forward</i></a>
	
	<div id="bookingCityModal" class="modal modal-fixed-footer teal lighten-5">
		<div class="modal-content">
    		<h4>Choose Your City</h4>
    		<br>
    		<div class="row center">
    			<div class="col s12">
		      		<a href="#" style="margin:5px;"  onclick="setBookingCity('kota')" class="btn waves-effect waves-teal black-text grey lighten-4">Kota</a>
		      	</div>
    			<div class="col s12">
		      		<a href="#" style="margin:5px;"  onclick="setBookingCity('surat')" class="btn waves-effect waves-teal black-text grey lighten-4">Surat</a>
		      	</div>
		    </div>
	    </div>
	    <div class="modal-footer teal lighten-3">
	      	<a href="#" style='margin-right:10px;' class="modal-action modal-close waves-effect btn large white black-text">Back</a>
	    </div>
	</div>
	
	<div id="bookingServiceModal" class="modal modal-fixed-footer teal lighten-5">
		<div class="modal-content">
    		<h4>Choose a Service</h4>
    		<br>
    		<div class="row">
         	<%  
          		serviceI = services.iterator();
          		while(serviceI.hasNext())
          		{
          			service = serviceI.next();
		   			out.println(
			          		"<div class='col s12 m6 l3' onclick='setBookingService(\""+service.getName()+"\")'><div class='card grey lighten-4 maincard hoverable'>" +
			            		"<div class='card-content row'>" +
						   			"<div>" +
						            	"<img src=\"images/"+service.getID()+".png\" alt=\"\" class=\"grey lighten-4 responsive-img mainserviceicon\">" +
						          	"</div>" +
						          	"<div>" +
						            	"<span class='card-title mainservicetitle'>" +
						            		   service.getName()+
						              	"</span>" + 
						        	"</div>" +
								"</div>"+
				       		"</div></div>");
          		}
            %>
            </div>
	    </div>
	    <div class="modal-footer teal lighten-3">
	      	<a href="#" style='margin-right:10px;' class="modal-action modal-close waves-effect btn large white black-text">Back</a>
	    </div>
	 </div>
	<div id="bookingAddressModal" class="modal modal-fixed-footer teal lighten-5">
		<div class="modal-content">
    		<h4>Enter your Address</h4><br>
	        <div class="input-field col s12">
				<input id="bookingAddressInput" min="4" type="text" class="validate" />
				<label for="bookingAddressInput" data-error="Enter Valid Address">House Number, Society</label>
	        </div>
	        <p>our professional will visit you at this location in your select area</p>
	    </div>
	    <div class="modal-footer teal lighten-3">
	      	<a href="#"  style='margin-left:10px;' class="modal-action modal-close waves-effect btn large white black-text">Back</a>
	      	<a href="#" onclick="setBookingAddress()" class="waves-effect waves-green btn large teal">Next</a>
	    </div>
	 </div>
	<div id="bookingContactModal" class="modal modal-fixed-footer teal lighten-5">
		<div class="modal-content">
    		<h4>Enter Your Contact</h4><br>
	        <div class="input-field col s12">
				<input id="bookingContactInput" data-length="10" type="text" class="validate" placeholder="9999999999" />
				<label for="bookingContactInput" data-error="Enter Valid Mobile Number">Phone Number</label>
	        </div>
	        <p>you will receive a call by us, soon on this number as soon as you book a service</p>
	    </div>
	    <div class="modal-footer teal lighten-3">
	      	<a href="#"  style='margin-left:10px;' class="modal-action modal-close waves-effect white black-text btn large">Back</a>
	      	<a href="#" onclick="setBookingContact()" class="waves-effect waves-green btn large teal">Next</a>
	    </div>
	 </div>
	<div id="bookingLocationModal" class="modal modal-fixed-footer teal lighten-5">
		<div class="modal-content">
    		<h4>Choose Your Area</h4><br>
	        <div id="locationContent" class="input-field col s12"></div><br>
	    </div>
	    <div class="modal-footer teal lighten-3">
	      	<a href="#" style='margin-right:10px;' class="modal-action modal-close waves-effect white black-text btn large">Back</a>
	    </div>
	 </div>
	<div id="bookingConfirmModal" class="modal modal-fixed-footer teal lighten-5">
		<div class="modal-content">
    		<h4>Confirm Your Booking</h4><br>
	        <div class="col s12">
	        	<b><i>Service : </i></b><span id="bookingServiceFinal"></span> <small><i><a href="#" onclick='removeService()'>(edit)</a></i></small>
	        	<br><b><i>Contact : </i></b><span id="bookingContactFinal"></span> <small><i><a href="#" onclick='removeContact()'>(edit)</a></i></small>
	        	<br><b><i>Address : </i></b><span id="bookingAddressFinal"></span> <small><i><a href="#" onclick='removeAddress()'>(edit)</a></i></small>
	        	<br><b><i>City : </i></b><span id="bookingCityFinal"></span> <small><i><a href="#" onclick='removeCity()'>(edit)</a></i></small>
	        	<br><b><i>Location : </i></b><span id="bookingLocationFinal"></span> <small><i><a href="#" onclick='removeLocation()'>(edit)</a></i></small>
	        </div>  
	        <br>
	        <div class="col s12 input-field">
				<textarea class="materialize-textarea" id="bookingNoteTextArea" ></textarea>
				<label for="bookingNoteTextArea">Any additional note for us ? (optional)</label>
	        </div>   
	        <div class="col s12">
	        </div>
	    </div>
	    <div class="modal-footer teal lighten-3">
	      	<a href="#" style='margin-left:10px;' class="modal-action modal-close waves-effect orange waves-green btn large white black-text">Back</a>
	      	<a href="#" onclick="bookClientConfirm()" class="waves-effect waves-green btn large teal">Confirm</a>
	    </div>
	</div>
	<div id="orderCompletedModal" class="modal modal-fixed-footer teal lighten-5">
		<div class="modal-content">
    		<h4>Order Submitted</h4><br>
			<p>We have confirmed your order for <% 
				if(session.getAttribute("orderConfirm")=="true") 
				{
					out.println("'<b>" +serviceM.getServiceByID((int)session.getAttribute("orderConfirmServiceID")).getName() +"</b>', you will receive a call on <b>"+session.getAttribute("orderConfirmContact")+"</b> soon") ; 
				}
				%></p>
	    </div>
	    <div class="modal-footer teal lighten-3">
	      	<a href="#" style='margin-right:10px;' class="modal-action modal-close waves-effect teal btn large">Go Home</a>
	    </div>
	 </div>
	
 </div>
  <script src="https://code.jquery.com/jquery-2.1.1.min.js"></script>
  <script src="js/materialize.js"></script>
  <script src="js/init.js"></script>
  <script>
  
  	var bookingCity = <% if(session.getAttribute("orderCity")!=null) out.println("'" + session.getAttribute("orderCity") + "'"); else out.println("null"); %> ;
  	var bookingAddress = <% if(session.getAttribute("orderAddress")!=null) out.println("'" + session.getAttribute("orderAddress") + "'"); else out.println("null"); %> ;
  	var bookingService = <% if(session.getAttribute("orderService")!=null) out.println("'" + session.getAttribute("orderService") + "'"); else out.println("null"); %> ;
  	var bookingContact = <% if(session.getAttribute("orderContact")!=null) out.println("'" + session.getAttribute("orderContact") + "'"); else out.println("null"); %> ;
  	var bookingLocation = <% if(session.getAttribute("orderLocation")!=null) out.println("'" + session.getAttribute("orderLocation") + "'"); else out.println("null"); %> ;
  	
    $(document).ready(function()
	{
      	$('.slider').slider({height:270});
        $('.carousel.carousel-slider').carousel({fullWidth: true,indicators:true});
	    $('select').material_select();
	    $('.modal').modal({startingTop: '0%',
	    	      endingTop: '0%'});
	    $('.dropdown-button').dropdown({
	        inDuration: 300,
	        outDuration: 225,
	        constrainWidth: true, 
	        hover: false, 
	        gutter: 0, 
	        belowOrigin: true,
	        alignment: 'left',
	        stopPropagation: false
	      }
	    );
	    
	    <% if(session.getAttribute("orderConfirm")=="true")
	    	{
	    		out.println(" $('#orderCompletedModal').modal('open'); ");
	    		session.removeAttribute("orderConfirm");
	    	}
	    
	    if(session.getAttribute("orderService")!=null || session.getAttribute("orderCity")!=null)
    	{
    		out.println(" bookClient(); ");
    	}
	    
	    %>
    });
    
    jQuery(document).ready(function($) 
    {  
    	$(window).load(function()
    	{
    		$('#iloader').fadeOut('slow',function(){$(this).remove();});
    	});

    });
  
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
	
	function setBookingCity(city) 
	{
		bookingCity = city;
		bookClient();
	}
	
	function setBookingService(service)
	{
		bookingService = service;
		bookClient();
	}
	
	function setBookingAddress()
	{
		bookingAddress = document.getElementById('bookingAddressInput').value;
		bookClient();
	}
	
	function setBookingLocation(location)
	{
		bookingLocation = location;
		bookClient();
	}
	
	function setBookingContact()
	{
		var contact = document.getElementById('bookingContactInput').value;
		if(contact.match(/^\d{10}$/))
		{
			bookingContact = contact;
			bookClient();
		}
	}

	function removeService()
	{
		bookingService = null;
		bookClient();
	}
	function removeCity()
	{
		bookingCity = null;
		bookClient();
	}
	function removeAddress()
	{
		bookingAddress = null;
		bookClient();
	}
	function removeContact()
	{
		bookingContact = null;
		bookClient();
	}
	function removeLocation()
	{
		bookingLocation = null;
		bookClient();
	}
	
	function bookClient()
	{
		if(bookingService == null)
		{
			$('#bookingCityModal').modal('close');
			$('#bookingAddressModal').modal('close');
			$('#bookingContactModal').modal('close');
			$('#bookingConfirmModal').modal('close');
			$('#bookingLocationModal').modal('close');
			$('#bookingServiceModal').modal('open');
		}
		else if(bookingCity == null)
		{
			bookingLocation = null;
			$('#bookingAddressModal').modal('close');
			$('#bookingContactModal').modal('close');
			$('#bookingServiceModal').modal('close');
			$('#bookingConfirmModal').modal('close');
			$('#bookingLocationModal').modal('close');
			$('#bookingCityModal').modal('open');
		}
		else if(bookingLocation == null)
		{
			$('#bookingAddressModal').modal('close');
			$('#bookingContactModal').modal('close');
			$('#bookingServiceModal').modal('close');
			$('#bookingConfirmModal').modal('close');
			$('#bookingCityModal').modal('close');
			$('#bookingLocationModal').modal('open');
			
    		if(bookingCity =="kota")
    		{

    			document.getElementById('locationContent').innerHTML = 
	      		<%
	      			locations = locationM.getLocationsByCity("Kota");
	      			locationsI = locations.iterator();
	      			while(locationsI.hasNext())
	      			{
	      				location = locationsI.next();
	      				out.println("\"<div class='col s12 m6 l3 offset-l2 center'><a href='#' style='margin:5px;' onclick='setBookingLocation(\\\""+location.getArea()+"\\\")' class='btn grey lighten-4  waves-effect waves-teal black-text'>"+location.getArea()+"</a></div> \" + ");
	      			}
	      			
	      		%> "" ;
    		}
    		else if(bookingCity =="surat")
    		{

    			document.getElementById('locationContent').innerHTML = 
	      		<%
	      			locations = locationM.getLocationsByCity("Surat");
	      			locationsI = locations.iterator();
	      			while(locationsI.hasNext())
	      			{
	      				location = locationsI.next();
	      				out.println("\"<div class='col s12 m6 l3 offset-l2 center'><a href='#' style='margin:5px;' onclick='setBookingLocation(\\\""+location.getArea()+"\\\")' class='btn grey lighten-4  waves-effect waves-teal black-text'>"+location.getArea()+"</a></div> \" + ");
	      			}
	      			
	      		%> "" ;
    		}    		
    		else
    		{
    			location.reload();	
    		}
		}
		else if(bookingAddress == null)
		{
			$('#bookingCityModal').modal('close');
			$('#bookingContactModal').modal('close');
			$('#bookingLocationModal').modal('close');
			$('#bookingServiceModal').modal('close');
			$('#bookingConfirmModal').modal('close');
			$('#bookingAddressModal').modal('open');
		}
		else if(bookingContact == null)
		{
			$('#bookingCityModal').modal('close');
			$('#bookingAddressModal').modal('close');
			$('#bookingServiceModal').modal('close');
			$('#bookingConfirmModal').modal('close');
			$('#bookingLocationModal').modal('close');
			$('#bookingContactModal').modal('open');
		}
		else
		{
			$('#bookingCityModal').modal('close');
			$('#bookingAddressModal').modal('close');
			$('#bookingServiceModal').modal('close');
			$('#bookingContactModal').modal('close');
			$('#bookingLocationModal').modal('close');
			document.getElementById('bookingContactFinal').innerHTML = bookingContact;
			document.getElementById('bookingCityFinal').innerHTML = bookingCity;
			document.getElementById('bookingAddressFinal').innerHTML = bookingAddress;
			document.getElementById('bookingServiceFinal').innerHTML = bookingService;
			document.getElementById('bookingLocationFinal').innerHTML = bookingLocation;
			$('#bookingConfirmModal').modal('open');
		}
	}
	
	function bookClientConfirm()
	{
		var note = document.getElementById('bookingNoteTextArea').value;
		$('<form action="OrderController" method="post">'+
				'<input name="contact" value="'+bookingContact+'" />'+
				'<input name="address" value="'+bookingAddress+'" />'+
				'<input name="city" value="'+bookingCity+'" />'+
				'<input name="location" value="'+bookingLocation+'" />'+
				'<input name="service" value="'+bookingService+'" />'+
				'<input name="note" value="'+note+'" /></form>').appendTo('body').submit();
	}
	
  </script>
  </body>
</html>
