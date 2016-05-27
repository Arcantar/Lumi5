<%@ Page Language="Oxygene" AutoEventWireup="true" MasterPageFile="~/Site.Master" CodeBehind="ProductEdit.aspx.pas" Inherits="NorpaNet.Admin.ProductEdit" %>
<%@ Register Assembly="CKEditor.NET" Namespace="CKEditor" TagPrefix="CKEditor" %>
 
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
  <asp:literal ID="LitProduct" runat="server" Visible="true" ></asp:literal>  
  <asp:Panel ID="modedit" runat="server" CssClass="modedit">
      <table class="modedit" >
          <tr>
              <asp:HiddenField ID="ImageFileName" runat="server" />
              <asp:Label ID="LabelStatus" runat="server" Text=""></asp:Label>
              <td><asp:Label ID="LabelProductID" runat="server">ID:</asp:Label></td>
              <td>
                  <asp:TextBox ID="TXTProductID" runat="server" Width="100%" ReadOnly="true"></asp:TextBox>
              </td>
          </tr>
          <tr>
              <td><asp:Label ID="LabelAddCategory" runat="server">Category:</asp:Label></td>
              <td>
                  <asp:DropDownList ID="DropDownAddCategory" runat="server" 
                      ItemType="NorpaNet.Data.Business.categories" 
                      SelectMethod="GetCategories" DataTextField="CategoryName" 
                      DataValueField="CategoryID" Width="100%" >
                  </asp:DropDownList>
              </td>
          </tr>
          <tr>
              <td><asp:Label ID="LabelProductName" runat="server">Name:</asp:Label></td>
              <td>
                  <asp:TextBox ID="TXTProductName" runat="server" Width="100%"></asp:TextBox>
              </td>
          </tr>
          <tr>
              <td><asp:Label ID="LabelProductNameMini" runat="server">Name Mini:</asp:Label></td>
              <td>
                  <CKEditor:CKEditorControl ID="TXTProductNameMini" BasePath="//cdn.ckeditor.com/4.5.9/basic" runat="server"  Language="en" EnterMode="BR"></CKEditor:CKEditorControl>              
              </td>
          </tr>
          <tr>
              <td><asp:Label ID="LabelProductDescription" runat="server">Description:</asp:Label></td>
              <td>
                  <CKEditor:CKEditorControl ID="CKEditor" BasePath="//cdn.ckeditor.com/4.5.9/basic" runat="server"  Language="en" EnterMode="BR"></CKEditor:CKEditorControl>
              </td>
          </tr>
          <tr>
              <td><asp:Label ID="LabelProductPrice" runat="server">Price:</asp:Label></td>
              <td>
                  <asp:TextBox ID="TXTProductPrice" runat="server" Width="100%"></asp:TextBox>
              </td>
          </tr>
          <tr>
              <td><asp:Label ID="LabelAddImageFile" runat="server">Image File:</asp:Label></td>
              <td>
                  <asp:FileUpload ID="ProductImage" runat="server" />
              </td>
          </tr>
          <tr>            
              <td>
                 <asp:Button ID="SaveProductButton" runat="server" Text="Update Product" OnClick="UpdateProductButton_Click"  CausesValidation="true"/>
              </td>
          </tr>
      </table>
</asp:Panel>
</asp:Content>
