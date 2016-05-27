<%@ Page Title="Home" Language="Oxygene"  MasterPageFile="~/Site.Master" AutoEventWireup="true"  CodeBehind="Default.aspx.pas" Inherits="NorpaNet._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
        
        <h2 class="center">Welcome to my gallery!</h2>
        <p class="lead center">In the <a href="/Category/Available">available</a> section you’ll find paintings that are looking for a new home, and already re-homed paintings are regrouped under the <a href="/Category/Portfolio">portfolio</a> section.<br />
         I hope that you enjoy the visit!<br />
        <i>Taru Kaukovalta</i></p>
        <div id="CategoryMenuPan" style="text-align: center">
            <ct:MenuCategory id="CategoryMenu" runat="server" Visible="true" showimage="true" UseSep="false" classimg="catimg" classitem="catitem"/>
        </div>

</asp:Content>