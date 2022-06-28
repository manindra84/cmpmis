<%@ Page Language="C#" AutoEventWireup="true" CodeFile="EarlierTimeline.aspx.cs" Inherits="EarlierTimeline" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>

    <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js"></script>
    <script src="http://ajax.aspnetcdn.com/ajax/jquery.ui/1.8.9/jquery-ui.js" type="text/javascript"></script>
    <link href="http://ajax.aspnetcdn.com/ajax/jquery.ui/1.8.9/themes/start/jquery-ui.css" rel="stylesheet" type="text/css" />

    <%--<script type="text/javascript">
        $(function () {
            if (window.opener != null && !window.opener.closed) {
                var rowIndex = window.location.href.split("?")[1].split("=")[1];
                var parent = $(window.opener.document).contents();
                var row = parent.find("[id*=gridrevisehistroy]").find("tr").eq(rowIndex);
                $("#id").html(row.find("td").eq(0).html());
                $("#name").html(row.find("td").eq(1).html());
                $("#description").html(row.find("td").eq(2).html());
            }

        });
    </script>--%>

</head>
<body>
    <form id="form1" runat="server">
        <div class="container">
            <div class="row">
                <div class="col-sm-12 col-md-12 col-lg-12 col-12">
                    <center>
                    <asp:GridView ID="gridrevisehistroy" runat="server" AutoGenerateColumns="false" GridLines="Both" BorderStyle="Solid" CellPadding="2"
                        CellSpacing="2" Font-Size="18px" HeaderStyle-BackColor="#0b2d4d" HeaderStyle-ForeColor="White" CssClass="gridfont" AlternatingRowStyle-BackColor="White"
                        AllowSorting="true" Width="30%">
                        <HeaderStyle CssClass="gridheader" />
                        <Columns>
                            <asp:TemplateField HeaderText="S No" ControlStyle-Font-Bold="false" HeaderStyle-VerticalAlign="Top" ItemStyle-HorizontalAlign="Left" ItemStyle-VerticalAlign="Top">
                                <ItemTemplate>
                                    <%# Container.DataItemIndex+1 %>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Reason" ControlStyle-Font-Bold="false" HeaderStyle-VerticalAlign="Top" ItemStyle-HorizontalAlign="Left" ItemStyle-VerticalAlign="Top">
                                <ItemTemplate>
                                    <%# Eval("reason")%>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Old TimeLine" ControlStyle-Font-Bold="false" HeaderStyle-VerticalAlign="Top" ItemStyle-HorizontalAlign="Left" ItemStyle-VerticalAlign="Top">
                                <ItemTemplate>
                                    <%# Eval("oldduedate")%>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                        </center>
                </div>
            </div>
        </div>
    </form>
</body>
</html>
