<%@ Page Title="" Language="C#" MasterPageFile="~/Master_sitemaster.master" AutoEventWireup="true" EnableEventValidation="false" 
    CodeFile="ViewNodalList.aspx.cs" Inherits="ViewNodalList" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

    <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js"></script>
    <script src="http://ajax.aspnetcdn.com/ajax/jquery.ui/1.8.9/jquery-ui.js" type="text/javascript"></script>
    <link href="http://ajax.aspnetcdn.com/ajax/jquery.ui/1.8.9/themes/start/jquery-ui.css" rel="stylesheet" type="text/css" />

    <div class="container">
        <div class="row">
            <div class="col-sm-12 col-md-12 col-lg-12 col-12">
                <br />
                <div class="row">
                    <div class="col-sm-8 col-md-8 col-lg-8 col-8">
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        <asp:Label ID="lbl_pageheader" runat="server" class="col-form-label" Text="Nodal Officer List" style="color:#0b2d4d;font-size:23px;"></asp:Label>  
                    </div>
                    <div class="col-sm-4 col-md-4 col-lg-4 col-4" style="float:right">
                        <asp:Button ID="addnodal" runat="server" class="btn btn-link" Text="Add Nodal Officer" OnClick="addnodal_Click" />
                    </div>
                </div>
                <br />
                <%--<div class="form-group">
                    
                </div>--%>
                
                <div class="form-group">
                    <center><asp:GridView ID="grd_nodallist" runat="server" AutoGenerateColumns="false" GridLines="Both" BorderStyle="Solid" EnableTheming="False" CellPadding="2"
                CellSpacing="2" HeaderStyle-BackColor="#0b2d4d" HeaderStyle-ForeColor="White" CssClass="gridfont" AlternatingRowStyle-BackColor="White" 
                AllowSorting="true" Width="65%">
                <HeaderStyle CssClass="gridheader" />
                <Columns>
                    <asp:TemplateField HeaderText="Sl No:" HeaderStyle-VerticalAlign="Top" ItemStyle-HorizontalAlign="Left" ItemStyle-VerticalAlign="Top">
                        <ItemTemplate>
                            <%# Container.DataItemIndex+1 %>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="User Id" HeaderStyle-VerticalAlign="Top" ItemStyle-HorizontalAlign="Left" ItemStyle-VerticalAlign="Top">
                        <ItemTemplate>
                            <%# Eval("user_id")%>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Name" HeaderStyle-VerticalAlign="Top" ItemStyle-HorizontalAlign="Left" ItemStyle-VerticalAlign="Top">
                        <ItemTemplate>
                            <%# Eval("user_name")%>
                        </ItemTemplate>
                    </asp:TemplateField>  
                    <asp:TemplateField HeaderText="Mobile No" HeaderStyle-VerticalAlign="Top" ItemStyle-HorizontalAlign="Left" ItemStyle-VerticalAlign="Top">
                        <ItemTemplate>
                            <%# Eval("contactno")%>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Email" HeaderStyle-VerticalAlign="Top" ItemStyle-HorizontalAlign="Left" ItemStyle-VerticalAlign="Top">
                        <ItemTemplate>
                            <%# Eval("email")%>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="" HeaderStyle-VerticalAlign="Top" ItemStyle-HorizontalAlign="Left" ItemStyle-VerticalAlign="Top">
                        <ItemTemplate>
                            <asp:Button ID="btn_reset" runat="server" class="btn btn-sm btn-dark" Text="Reset Password" OnClick="btn_reset_Click" />
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
                    </asp:GridView></center>
                </div>
                
            </div>
        </div>
    </div>

</asp:Content>

