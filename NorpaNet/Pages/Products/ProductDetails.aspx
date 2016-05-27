<%@ Page Title="Gallery" Language="Oxygene" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ProductDetails.aspx.pas" Inherits="NorpaNet.ProductDetails"  ValidateRequest="false" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
     
             <asp:Literal ID="litEdit" runat="server" Visible="false"></asp:Literal>   
                                            
    
        <div id="CategoryMenuPan" style="text-align: center">
            <ct:MenuCategory id="CategoryMenu" runat="server" Visible="true"  showimage="false" UseSep="false" />
        </div>
        <br /> 
        <asp:literal ID="LitProduct" runat="server" Visible="true" ></asp:literal>  
</asp:Content>