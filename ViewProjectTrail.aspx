<%@ Page Title="" Language="C#" MasterPageFile="~/Master_sitemaster.master" AutoEventWireup="true" CodeFile="ViewProjectTrail.aspx.cs" Inherits="ViewProjectTrail" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

    <div class="container">
        <div class="col-sm-12 col-md-12 col-lg-12 col-12">
            <div class="row">     
                <div class="col-sm-12 col-md-12 col-lg-12 col-12">
                    <br /> 
                </div>                                 
            </div>
            <div class="row">
                <div class="col-sm-4 col-md-4 col-lg-4 col-4" style="padding:0px;">
                    <asp:Button ID="btn_dwnld" class="btn btn-sm btn-primary" runat="server" Text="Download" OnClick="btn_dwnld_Click" />
                </div>
                <div class="col-sm-8 col-md-8 col-lg-8 col-8" style="float:right;">
                   <asp:Label ID="lbl_pageheader" runat="server" class="col-form-label" Text="Project Trail" style="color:#0b2d4d;font-size:20px;"></asp:Label>                    
                </div> 
                
            </div>
            <div class="row">     
                <div class="col-sm-12 col-md-12 col-lg-12 col-12">
                    <br /> 
                </div>                                 
            </div>

            <div class="row" id="divPrint" runat="server">
                <table id="tbl_projtrail" class="table-bordered" width="75%">
                    <tr style="background-color:#0b2d4d;">
                        <td ><asp:Label ID="lblsno" runat="server" style="color:white;" class="col-form-label" Text="S.No"></asp:Label></td>
                        <td ><asp:Label ID="lbldesc" runat="server" style="color:white;" class="col-form-label" Text="Description"></asp:Label></td>
                        <td ><asp:Label ID="lbltype" runat="server" style="color:white;" class="col-form-label" Text=""></asp:Label></td>                        
                        <td style="width:100px;" ><asp:Label ID="lbldate" runat="server" style="color:white;" class="col-form-label" Text="Target Date"></asp:Label></td>
                       <%--<td ><asp:Label ID="lbltime" runat="server" style="color:white;" class="col-form-label" Text="Time"></asp:Label></td>--%>                                              
                    </tr>

                  
                    <% for (int i = 0; i < dt.Rows.Count; i++)
                                   {%>
                    <tr>
                        <td>
                            <%=i+1 %>
                        </td>
                        <td>
                            <%=dt.Rows[i]["pname"].ToString()%>
                        </td>
                        <td>
                            <%=dt.Rows[i]["activitytype"].ToString()%>
                            <%=dt.Rows[i]["taskname"].ToString()%>
                        </td>
                        <td>
                            <%=Convert.ToDateTime(dt.Rows[i]["enddt"]).ToString("dd/MM/yyyy").Substring(0, 10)%>                                        
                        </td>
                        <%-- <td> 
                        <%= dt.Rows[i]["edate"].ToString().Substring(10, 6) %>
                        </td>--%>
                    </tr>
                    <%} %>
                </table>
            </div>

           <%-- <div class="row">                
                    <asp:GridView ID="grid_projtrail" runat="server" AutoGenerateColumns="false" GridLines="Both" BorderStyle="Solid" EnableTheming="False" CellPadding="2"
                        CellSpacing="2" HeaderStyle-BackColor="#0b2d4d" HeaderStyle-ForeColor="White" CssClass="gridfont" AlternatingRowStyle-BackColor="White"
                        AllowSorting="true">
                        <HeaderStyle CssClass="gridheader" />
                        <Columns>
                            <asp:TemplateField HeaderText="Sl No:" HeaderStyle-VerticalAlign="Top" ItemStyle-HorizontalAlign="Left" ItemStyle-VerticalAlign="Top">
                                <ItemTemplate>
                                    <%# Container.DataItemIndex+1 %>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Activity Detail" HeaderStyle-VerticalAlign="Top" ItemStyle-HorizontalAlign="Left" ItemStyle-VerticalAlign="Top">
                                <ItemTemplate>
                                    <%# Eval("pname")%>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Due Date" HeaderStyle-VerticalAlign="Top" ItemStyle-HorizontalAlign="Left" ItemStyle-VerticalAlign="Top">
                                <ItemTemplate>
                                   <%# Eval("startdt")%>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Type" HeaderStyle-VerticalAlign="Top" ItemStyle-HorizontalAlign="Left" ItemStyle-VerticalAlign="Top">
                                <ItemTemplate>
                                    <asp:Label ID="lbl_type" runat="server" class="col-form-label" Text="Project"></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                </div>--%>
           
        </div>
    </div>

</asp:Content>

