<%@ Control Language="Oxygene" AutoEventWireup="true" CodeBehind="ViewSwitcher.ascx.pas" Inherits="NorpaNet.ViewSwitcher" %>
<div id="viewSwitcher">
    <%: CurrentView %> view | <a href="<%: SwitchUrl %>" data-ajax="false">Switch to <%: AlternateView %></a>
</div>