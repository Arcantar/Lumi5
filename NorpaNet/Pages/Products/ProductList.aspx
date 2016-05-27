<%@ Page Title="Gallery" Language="Oxygene" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ProductList.aspx.pas" Inherits="NorpaNet.ProductList" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <section>        
        <div id="CategoryMenuPan" style="text-align: center">
            <ct:MenuCategory id="CategoryMenu" runat="server" Visible="true" showimage="false" UseSep="true" />
        </div>
        <div>
            
            <br /> 
               <asp:literal ID="LitProduct" runat="server" Visible="true" ></asp:literal> 
            <br />         
        </div>
    </section>
</asp:Content>
