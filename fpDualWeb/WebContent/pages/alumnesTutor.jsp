<%@ page import="controlador.*" %>
<%@ page import="model.*" %>
<%@ page import="servlet.*" %>
<%@ page import="java.util.*" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Registre d'hores</title>
    <!-- FONTAWESOME STYLES-->
    <link href="../assets/css/font-awesome.css" rel="stylesheet" />
    <!-- BOOTSTRAP STYLES-->    
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
  	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
  	<script src="../assets/js/bootbox.js"></script>
  	
    <link href="../assets/css/bootstrap-theme.css" rel="stylesheet" />

    <link href="../assets/css/bootstrap-theme.min.css" rel="stylesheet" />

    <link href="../assets/css/bootstrap.min.css" rel="stylesheet" />

    <link href="../assets/css/bootstrap-theme.min.css" rel="stylesheet" />
    
    <link href="../assets/css/bootstrap.css" rel="stylesheet" />
    <!-- CUSTOM STYLES-->
    <link href="../assets/css/custom.css" rel="stylesheet" />
     <!-- GOOGLE FONTS-->
    <link href='http://fonts.googleapis.com/css?family=Open+Sans' rel='stylesheet' type='text/css' />
    <!-- FAVICON -->
	<link rel="shortcut icon" type="image/ico" href="../assets/img/favicon-clock-o.ico" />

	<script src="//ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
	<script type="text/javascript" src="../assets/js/jquery.tablesorter.js"></script>
	<script type="text/javascript">
	$(document).ready(function() 
		    { 
		        $("#myTable").tablesorter();
		    } 
		);
	</script>
</head>
<body> 
<%
	HttpSession sesion=request.getSession(); 
	String nif=null;
	String usuNif=null;
	String usuNom=null;
	String usuCognom=null;
	String usuMail=null;
	int permis=0;
	List<Alumne> alumnes = null;
	try{
		if(sesion.getAttribute("nif") == null){	
			session.invalidate();
			response.sendRedirect("login.jsp");
		}
	
		usuNif = sesion.getAttribute("nif").toString();
		usuNom = sesion.getAttribute("nomComplet").toString();
		usuCognom = sesion.getAttribute("cognom1Login").toString();
		usuMail = sesion.getAttribute("mailLogin").toString();
		permis = Integer.parseInt(sesion.getAttribute("permis").toString());
		
		String sessionID = null;
		Cookie[] cookies = request.getCookies();
		if(cookies != null){
			for(Cookie cookie : cookies){
				if(cookie.getName().equals("JSESSIONID")) sessionID = cookie.getValue();			
			}
		}
		
		Tutor tut = new Tutor();
		tut.setNIF(usuNif);
		AlumneDAO aDAO = new AlumneDAO();
		alumnes = aDAO.alumnesTutoritzats(tut);
	}catch(Exception e){}	
	
	
%>           
          
    <div id="wrapper">
         <div class="navbar navbar-inverse navbar-fixed-top">
            <div class="adjust-nav">
                <div class="navbar-header">
                    <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".sidebar-collapse">
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                    </button>
                    <a class="navbar-brand" href="../index.jsp">
                        <img src="../assets/img/logo.png" height="50px" />
                    </a>
                </div>
              
                 <span class="logout-spn" >                
	                <form method="post" action="../Logout" name="logoutForm">
						<a href="javascript: submitform()" style="color:#fff;">LOGOUT</a>
					</form>
					<p><strong><%=usuNom %></strong> | <%=usuNif%></p>
					<script type="text/javascript">
						function submitform(){
						  document.logoutForm.submit();
						}
					</script>
					
                </span>
            </div>
        </div>
        <!-- /. NAV TOP  -->
        <nav class="navbar-default navbar-side" role="navigation">
            <div class="sidebar-collapse">
                <ul class="nav" id="main-menu">
                 
                    <li>
                        <a href="../index.jsp" ><i class="fa fa-desktop "></i>Inici </a>
                    </li>

                    <li class="active-link dropdown">
                        <a href="alumnes.jsp"><i class="fa fa-graduation-cap "></i>Alumnes</a>
                        
                    </li>
                    <li>
                        <a href="tutors.jsp"><i class="fa fa-book"></i>Tutors</a>
                    </li>

                    <li>
                        <a href="centre.jsp"><i class="fa fa-university "></i>Centres </a>
                    </li>
                    <li>
                        <a href="activitats.jsp"><i class="fa fa-list "></i>Activitats</a>
                    </li>
                </ul>
            </div>
        </nav>
        <!-- /. NAV SIDE  -->
        <div id="page-wrapper" >
            <div id="page-inner">
                
                <div class="row">
                    <div class="col-md-12">
                    <br>
                     <h2 style="display:inline">Llistat del teus alumnes</h2>
                     <div style="float:right; font-size:16px" ><a href="alumnes.jsp"><strong>Torna enrere</strong></a></div>
                    </div>
                </div>              
                 <!-- /. ROW  -->
                  <hr />
              <div class="row">
                    <div class="col-lg-12 col-md-12">
						<table class="table table-striped  table-hover" id="myTable">
							<thead>
                                <tr id="headeer">
                                    <th>#</th>
                                    <th>NIF</th>
                                    <th>Nom</th>
                                    <th>Cognoms</th>
                                    <th>Correu electr�nic</th>

                                </tr>
                            </thead>
                            <tbody>
                                                        
                                <tr>
									<%
										for (Alumne alumne : alumnes) {
									%>
									<td><%=alumne.getIdUsuari()%></td>
									<td><%=alumne.getNIF()%></td>
									<td><%=alumne.getNom()%></td>
									<td><%=alumne.getCognom1()%>&nbsp;<%=alumne.getCognom2()%></td>
									<td><%=alumne.getMail()%></td>
                             									
								</tr>
								<%
									}
								%>
                                
                            </tbody>
                        </table>


                    </div>
                 <!-- /. ROW  -->           
                </div>
             <!-- /. PAGE INNER  -->
            </div>
         <!-- /. PAGE WRAPPER  -->
        </div>
    <div class="footer">
      
    
             <div class="row">
                <div class="col-lg-12" >
                    &copy;  2017 Indra Software Labs | Design by: Joan Espu�es, Sergi Fern�ndez, Sisco Navarro, Thiago Hachikyan
                </div>
        </div>
        </div>
          

     <!-- /. WRAPPER  -->
    <script src="../assets/js/bootstrap.min.js"></script>
    <script src="../assets/js/custom.js"></script>
    
   
</body>
</html>