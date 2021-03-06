﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="UserDashboard.aspx.cs" Inherits="ProudSource.UserDashboard" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Dashboard</title>
    <link rel="Stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.css" />
    <link rel="Stylesheet" href="styles/UserDashboard.css" />
	<script type="text/javascript" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.js"></script>
    <script type="text/javascript">
        function ToInvestor(arg, context) {
            //alert(arg);
            if (arg == 'Redirecting to Investor Profile') {
                window.location.replace("InvestorAccount.aspx");
            }
        }
        function ToEntrepreneur(arg, context) {
            //alert(arg);
            if (arg == 'Redirecting to Entrepreneur Profile') {
                window.location.replace("EntrepreneurAccount.aspx");
            }
        }
    </script>
</head>
<body>
    <!-- Navbar stuff -->
    <div id="navbar-container-div" class="navbar-container-div">
			<nav class="navbar navbar-default">
		        <div class="container-fluid">
		        <!-- Brand and toggle get grouped for better mobile display -->
		        <div class="navbar-header">
		          <a class="navbar-brand" href="#">
		      	    <img alt="Brand" src="images/ProudSourceLogoB.jpg" style="height:50px; width:50px; position:relative; top:-15px;">
		          </a>
		        </div>
		        <!-- Collect the nav links, forms, and other content for toggling -->
		        <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
		          <ul class="nav navbar-nav">
		            <li class="li-navbar-item"><a href="#">About</a></li>
		            <li class="li-navbar-item"><a href="Contact.aspx">Contact</a></li>
		            <li class="li-navbar-item"><a href="#">Careers</a></li>
		          </ul>
		          <div class="navbar-form navbar-left" role="search">
		            <div class="form-group">
		              <input type="text" class="form-control" placeholder="Search" id="in-search-arg">
		            </div>
		            <button type="submit" class="btn btn-default" id="btn_search_arg" onclick="window.location.replace('Search/' + document.getElementById('in-search-arg').value);">Submit</button>
		          </div>
		          <ul class="nav navbar-nav navbar-right">
                    <li>
                        <a href="UserLogout.aspx">
                            <span class="glyphicon glyphicon-log-out" aria-hidden="true"></span>
                        </a> 
                    </li>
		          </ul>
		        </div><!-- /.navbar-collapse -->
		      </div><!-- /.container-fluid -->
		    </nav>
		</div>
    <!-- end of navbar stuff -->
    <form runat="server">
    <div>
        <h3> Welcome <asp:Label ID="lbl_UserName" runat="server" Text="Label"></asp:Label> to ProudSource</h3>
    </div>
    </form>
    <br />
    <%=InvestorResults%>
    <br />
    <button id="Btn_add_investor" type="button" onclick="window.location.href = 'CreateInvestor.aspx';"><span class="glyphicon glyphicon-plus" aria-hidden="true"></span></button>
    <br />
    <%=EntreprenuerResults%>
    <br />
    <button id="Btn_add_entreprenuer" type="button" onclick="window.location.href = 'CreateEntreprenuer.aspx';"><span class="glyphicon glyphicon-plus" aria-hidden="true"></span></button>
</body>
</html>
