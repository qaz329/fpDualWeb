<%@page import="model.UsuariDAO" %>
<%@page import="model.Usuari" %>
<%@page import="model.TutorDAO" %>
<%@page import="java.util.List" %>
<%@page import="java.sql.Date" %>
<%@page import="java.text.*" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <script src="https://use.fontawesome.com/d43d49ce33.js"></script>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Registre d'hores</title>
	<!-- BOOTSTRAP STYLES-->
     <!-- FONTAWESOME STYLES-->
    <link href="../assets/css/font-awesome.css" rel="stylesheet" />
        <!-- CUSTOM STYLES-->
    <link href="../assets/css/bootstrap-theme.css" rel="stylesheet" />

    <link href="../assets/css/bootstrap-theme.min.css" rel="stylesheet" />

    <link href="../assets/css/bootstrap.min.css" rel="stylesheet" />

    <link href="../assets/css/bootstrap-theme.min.css" rel="stylesheet" />
    
     <link href="../assets/css/bootstrap-X.X.css" rel="stylesheet" />
     
     <link href="../assets/css/bootstrap-X.X-flex.css" rel="stylesheet" />
     
     <link href="../assets/css/bootstrap.js" rel="stylesheet" />
    
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-alpha.‌​2/css/bootstrap.min.‌​css">
    
    <link href="../assets/css/tutors.css" rel="stylesheet" />
    
    <link href="../assets/css/custom.css" rel="stylesheet" />
     <!-- GOOGLE FONTS-->
    <link href='http://fonts.googleapis.com/css?family=Open+Sans' rel='stylesheet' type='text/css' />
         <!-- FAVICON -->
	<link rel="shortcut icon" type="image/ico" href="../assets/img/favicon-clock-o.ico" />
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
                        <img src="../assets/img/logo.png" height="50px"/>

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
					<%if(permis > 1){ %>
                    <li>
                        <a href="alumnes.jsp"><i class="fa fa-graduation-cap "></i>Alumnes</a>
                    </li>
                    <%} %>
                    <%if(permis > 1){ %>
                    <li>
                        <a href="tutors.jsp"><i class="fa fa-book"></i>Tutors</a>
                    </li>
					<%} %>
                    <%if(permis > 1){ %>
                    <li>
                        <a href="centre.jsp"><i class="fa fa-university "></i>Centres </a>
                    </li>
                    <%} %>
                    <%if(permis >= 2){%>
                    <li>
                        <a href="activitats.jsp"><i class="fa fa-list "></i>Activitats</a>
                    </li>
                    <%} %>
                    <%if(permis == 1 || permis == 2){ %>
                    <li>
                    	<a href="registre.jsp"><i class="fa fa-clock-o"></i>Registre d'hores</a>
                    </li>
                    <%} %>
                    <%if(permis == 4){ %>
                    <li>
                        <a href="administrador.jsp"><i class="fa fa-user-o "></i>Administrador </a>
                    </li>
                    <%} %>
                    <%if(permis > 1){ %>
                    <li>
                    	<a href="responsables.jsp"><i class="fa fa-street-view"></i>Responsables</a>
                    </li>
                    <%} %>
                    <%if(permis == 1){ %>
                    <li class="active-link">
                    	<a href="dadesUsuari.jsp"><i class="fa fa-id-card"></i>Dades d'usuari</a>
                    </li>
                    <%} %>
                </ul>
            </div>


        </nav>
        <!-- /. NAV SIDE  -->
        <div id="page-wrapper" >
            <div id="page-inner">
                <div class="row">
                    <div class="col-lg-12">
                     <h2><i id="imgTitol" class="fa fa-list" aria-hidden="true">&nbsp;</i>Dades tutor</h2>   
                    </div>
                </div>              
                 <!-- /. ROW  -->
                  <hr />
                <div class="row">
                    <div class="col-lg-12 ">
                    </div>
 
                    </div>
                  <!-- /. ROW  --> 
                        
                            <div class="row">
                                <div class="col-lg-12">
                                          
	                                <table class="table table-hover table-inverse">
	                                    <thead>
	                                        <tr id="headeer">
		                                        <th><span>Nom</span></th>
		                                        <th><span>Cognom</span></th>
		                                        <th><span>Segon Cognom</span></th>
		                                        <th><span>NIF</span></th>
		                                        <th><span>E-mail</span></th>
	                                        </tr>
	                                    </thead>
	                                    <tbody>
	                                        <%
	                                        	TutorDAO tDAO=new TutorDAO();
	                                        	UsuariDAO uDAO=new UsuariDAO();
	                                        	int id=Integer.parseInt(request.getSession().getAttribute("idAl").toString());
	                                        	System.out.println(id);
	                                    		Usuari u=null;
	                                    		try {
	                                    			u=tDAO.cercarTutorAlumne(id);
	                                    		} catch (Exception e) {
	                                    			e.printStackTrace();
	                                    		}
	                                        %>
	                                        		<tr>
	                                        			<td>
	                                        				<%=u.getNom()%>
	                                        			</td>
	                                        			<td>
	                                        				<%=u.getCognom1()%>
	                                        			</td>
	                                        			<td>
	                                        				<%=u.getCognom2()%>
	                                        			</td>
	                                        			<td>
	                                        				<%=u.getNIF()%>
	                                        			</td>
	                                        			<td>
	                                        				<%=u.getMail()%>
	                                        			</td>
	                                        		</tr>
	                                    </tbody>
	                                </table>
                                   </div>
                               </div>
                                   </div>
                               </div>
                    <%if(permis == 1){ %>
                    	<a href="dadesUsuari.jsp"  id="fletxa">
	               			<i class="fa fa-hand-o-left fa-4x" style='position:fixed; head:0; bottom:50px; right:35px;' width="50" height="50"></i>
	              		</a>
                    <%}else{ %>
	                    <a href="tutors.jsp"  id="fletxa">
	               			<i class="fa fa-hand-o-left fa-4x" style='position:fixed; head:0; bottom:50px; right:35px;' width="50" height="50"></i>
	              		</a>
              		<%} %>
                           </div>
                        
    <div class="footer">
      
    
            <div class="row">
                <div class="col-lg-12" >
                    &copy;  2017 Indra Software Labs | Design by: Joan Espu�es, Sergi Fern�ndez, Sisco Navarro, Thiago Hachikyan
                </div>
            </div>
        </div>
          
     <!-- /. WRAPPER  -->
    <!-- SCRIPTS -AT THE BOTOM TO REDUCE THE LOAD TIME-->
    <!-- JQUERY SCRIPTS -->
    <!-- CUSTOM SCRIPTS -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
    <script src="../assets/js/bootstrap.min.js"></script>
    <script src="../assets/js/custom.js"></script>

    
   
</body>
</html>