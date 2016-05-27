<%@ Control Language="Oxygene" AutoEventWireup="true" CodeBehind="Contact.ascx.pas" Inherits="NorpaNet.Components.Controls.Contact" %>

<section id="loginForm">
                <div class="form-horizontal">
                    <p>Please contact me for more information, or to simply share your thoughts about my work.</p>
                    <p>Talk to you soon,</p>
                    <br />
                    <p><i>Taru Kaukovalta</i></p>
                    <p>Kylmälä, Finland</p>
                    <br />
                    <hr />
                    <asp:PlaceHolder runat="server" ID="ErrorMessage" Visible="false">
                        <p class="text-danger">
                            <asp:Literal runat="server" ID="FailureText" />
                        </p>
                    </asp:PlaceHolder>
                    <div class="form-group">
                        <asp:Label runat="server" AssociatedControlID="Email" CssClass="col-md-2 control-label">Email</asp:Label>
                        <div class="col-md-10">
                            <asp:TextBox runat="server" ID="Email" CssClass="form-control" TextMode="Email" />
                            <asp:RequiredFieldValidator runat="server" ControlToValidate="Email"
                                CssClass="text-danger" ErrorMessage="The email field is required." />
                        </div>
                        <asp:Label runat="server" AssociatedControlID="Subject" CssClass="col-md-2 control-label">Subject</asp:Label>
                        <div class="col-md-10">
                            <asp:TextBox runat="server" ID="Subject" TextMode="SingleLine" CssClass="form-control" />
                            
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-md-offset-2 col-md-10">
                           <CKEditor:CKEditorControl ID="CKEditor" BasePath="//cdn.ckeditor.com/4.5.9/basic" runat="server"  Language="en" EnterMode="BR"></CKEditor:CKEditorControl>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-md-offset-2 col-md-10">
                            <asp:Button runat="server" OnClick="Send" Text="Send" CssClass="btn btn-default" />
                        </div>
                    </div>
                </div>
            </section>
