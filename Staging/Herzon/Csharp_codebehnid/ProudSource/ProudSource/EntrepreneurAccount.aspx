﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="EntrepreneurAccount.aspx.cs" Inherits="ProudSource.EntrepreneurAccount" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Entrepreneur</title>
    <link rel="Stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.css" />
    <link rel="Stylesheet" href="styles/EntrepreneurAccount.css" />
	<script type="text/javascript" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.js"></script>
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
		            <li>
		        	    <a href="UserDashboard.aspx">
		        		    <span class="glyphicon glyphicon-home" aria-hidden="true"></span>
		        	    </a>
		            </li>
		          </ul>
		        </div><!-- /.navbar-collapse -->
		      </div><!-- /.container-fluid -->
		    </nav>
		</div>
    <!-- end of navbar stuff -->
    <form id="form1" runat="server">
        <div class="container">
            <div>
                <h3>Entrepreneur Account for <asp:Label ID="lbl_UserName" runat="server" Text="Label"></asp:Label></h3>
            </div>
            <div id="Entrepreneur-Information">
                <div id="Entrepreneur-Datum" >
                    <ul class="list-group">
                        <li class="list-group-item">
                            <asp:Label ID="lbl_Name" runat="server" Text=""></asp:Label>
                        </li>
                        <li class="list-group-item">
                            <asp:Image ID="img_Entrepreneur" runat="server" Height="400px" Width="300px" />
                        </li >
                            <!-- TODO figure out how to display/serve a pdf file or display the name of the pdf file -->
                        <li class="list-group-item">
                            <asp:Label ID="Label1" runat="server" Text="Profile public"></asp:Label>
                            <br />
                            <asp:Label ID="lbl_ProfilePublic" runat="server" Text=""></asp:Label>
                        </li>
                    </ul>
                </div>
                <div id="Entrepreneur-Update">
                    <ul class="list-group">
                        <li class="list-group-item">
                            <asp:TextBox ID="Tbox_Name" runat="server"></asp:TextBox>
                        </li >
                        <li class="list-group-item">
                            <asp:FileUpload ID="FileUp_Image" runat="server" />
                        </li >
                            <!-- TODO figure out how to upload a pdf file from client side and pass it off to the server -->
                        <li class="list-group-item">
                            <asp:RadioButton ID="RButton_Public" runat="server" Text=" Make Account Public" />
                        </li >
                    </ul>
                </div>
                <div id="Update-Button-container">
                    <button id="btn-EditProfile" onclick="">
                        <span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>
                    </button>
                </div>
                <div id="Update-Button-send">
                    <asp:Button ID="btn_Update" runat="server" Text="Update" OnClick="btn_Update_Click" />
                </div>
            </div>
        </div>
    </form>
    <br />
    <div id="ProjectResults" class="container">
        <%=ProjectsResults %>
    <br />
    <button id="Btn_add_project" type="button" onclick="window.location.href = 'CreateProject.aspx';"><span class="glyphicon glyphicon-plus" aria-hidden="true"></span></button>
    </div>
</body>
</html>
