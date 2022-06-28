<%@ Page Title="" Language="C#" MasterPageFile="~/Master_sitemaster.master" AutoEventWireup="true" CodeFile="DeptLogin.aspx.cs" Inherits="DeptLogin" %>

<asp:Content ID="Content_head" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <%--bootstrap css--%>
  <%--  <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>

    
    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>

    --%>

    <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js"></script>
    <script src="http://ajax.aspnetcdn.com/ajax/jquery.ui/1.8.9/jquery-ui.js" type="text/javascript"></script>
    <link href="http://ajax.aspnetcdn.com/ajax/jquery.ui/1.8.9/themes/start/jquery-ui.css" rel="stylesheet" type="text/css" />

    

    <div class="container">
        <br />
        <div class="row">
            <div class="col-sm-12 col-md-12 col-lg-12 col-12">
                <center><h4 style="margin: auto; font-size: 20px;color:#0b2d4d;">Assigned Activity List</h4></center>
            </div>                       
        </div>
        
        <br />
        <div class="row">
            <div class="col-sm-12 col-md-12 col-lg-12 col-12">           
            <asp:Label ID="gridheading" runat="server" style="color:#A52A2A;font-size:15px;font-weight:800;"></asp:Label>               
            <asp:GridView ID="Gridviewdata" Width="70%" runat="server" AutoGenerateColumns="false" Font-Names="Arial" GridLines="Both" BorderStyle="Solid" EnableTheming="False"
                CellPadding="2" CellSpacing="2" HeaderStyle-BackColor="#0b2d4d" HeaderStyle-ForeColor="White" CssClass="gridfont" AlternatingRowStyle-BackColor="White"
                AllowSorting="true" DataKeyNames="taskid,pcode,targetdate" OnRowCommand="Gridviewdata_RowCommand">
                <HeaderStyle CssClass="gridheader" />
                <Columns>
                    <asp:TemplateField HeaderText="S.No" Visible="false" HeaderStyle-VerticalAlign="Top" ItemStyle-HorizontalAlign="left" ItemStyle-VerticalAlign="Top">
                        <ItemTemplate>
                            <asp:LinkButton ID="lbtn_action" runat="server" CommandName="action" CommandArgument='<%# DataBinder.Eval(Container, "RowIndex") %>' Text="<%# Container.DataItemIndex+1 %>"></asp:LinkButton>                             
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="S.No" Visible="false" HeaderStyle-VerticalAlign="Top" ItemStyle-HorizontalAlign="left" ItemStyle-VerticalAlign="Top">
                        <ItemTemplate>                           
                            <asp:LinkButton ID="lbtn_revise" runat="server" CommandName="revisedt" CommandArgument='<%# DataBinder.Eval(Container, "RowIndex") %>' Text="<%# Container.DataItemIndex+1 %>"></asp:LinkButton>                            
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="S.No" Visible="false" HeaderStyle-VerticalAlign="Top" ItemStyle-HorizontalAlign="left" ItemStyle-VerticalAlign="Top">
                        <ItemTemplate>                            
                            <asp:LinkButton ID="lbtn_view" runat="server" CommandName="view" CommandArgument='<%# DataBinder.Eval(Container, "RowIndex") %>' Text="<%# Container.DataItemIndex+1 %>"></asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateField>                   
                    <asp:TemplateField HeaderText="Activity Details" HeaderStyle-VerticalAlign="Top" ItemStyle-HorizontalAlign="left" ItemStyle-VerticalAlign="Top">
                        <ItemTemplate>
                            <%# Eval("taskname")%>
                        </ItemTemplate>
                    </asp:TemplateField>
                     <asp:TemplateField HeaderText="Project" HeaderStyle-VerticalAlign="Top" ItemStyle-HorizontalAlign="left" ItemStyle-VerticalAlign="Top">
                        <ItemTemplate>
                            <%--<%# Eval("pname")%> --%>
                            <asp:Label ID="lblprogcode" runat="server" Text='<%# Bind("pname") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Due Date" HeaderStyle-VerticalAlign="Top" ItemStyle-HorizontalAlign="left" ItemStyle-VerticalAlign="Top">
                        <ItemTemplate>
                            <%# Eval("targetdate")%>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </div>
        </div>
        
    </div>

    <asp:ValidationSummary ID="ValidationSummary1" runat="server" ValidationGroup="1"
        ShowSummary="false" ShowMessageBox="true" />
</asp:Content>





