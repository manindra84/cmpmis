<%@ Page Title="" Language="C#" MasterPageFile="~/Master_sitemaster.master" AutoEventWireup="true" CodeFile="OfficerList.aspx.cs" Inherits="OfficerList" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

    <div class="container">
        <br />
        <div class="row">
            <div class="col-sm-12 col-md-12 col-lg-12 col-12">                
                <div class="col-sm-4 col-md-4 col-lg-4 col-4" style="width:30%;float:left;">
                    <div class="col-sm-6 col-md-6 col-lg-6 col-6" style="float:left;padding:0px;">
                        <%--<asp:TextBox ID="txt_filter" runat="server" class="form-control-sm" Width="100%" placeholder="Enter Department" AutoPostBack="true" MaxLength="50" TextMode="SingleLine"></asp:TextBox>--%>
                        <asp:DropDownList ID="ddl_filter" runat="server" class="form-control" AutoPostBack="true" OnSelectedIndexChanged="ddl_filter_SelectedIndexChanged">
                            
                        </asp:DropDownList>

                    </div>
                    <div class="col-sm-6 col-md-6 col-lg-6 col-6" style="float:left;padding:0px;">
                        <%--<asp:Button ID="btn_search" runat="server"  class="btn btn-primary" Text="Search" OnClick="btn_searchflter_Click" />--%>
                    </div>
                </div>
                <div class="col-sm-4 col-md-4 col-lg-4 col-4" style="width:40%;float:left;">
                    <center>
                        <asp:Label ID="lbl_pgheader" runat="server" class="col-form-label" Text="" Style="font-size: 22px; color: #0b2d4d;"></asp:Label>
                         
                        
                          
                    </center>
                </div>
                <div class="col-sm-4 col-md-4 col-lg-4 col-4" style="width:30%;float:left;">
                    <div class="col-sm-8 col-md-8 col-lg-8 col-8" style="float:left;padding:0px;">
                        <p></p>
                    </div>
                    <div class="col-sm-2 col-md-2 col-lg-2 col-2" style="float:left;padding:0px;">
                        <asp:ImageButton ID="imgbtn_pdf" runat="server" Height="30" Width="30" ImageUrl="~/images/pdf.jpg" OnClick="imgbtn_pdf_Click" />
                    </div>
                    <div class="col-sm-2 col-md-2 col-lg-2 col-2" style="float:left;padding:0px;">
                        <asp:ImageButton ID="imgbtn_excel" runat="server" Height="30" Width="30" ImageUrl="~/images/xcel.png" OnClick="imgbtn_excel_Click" />
                    </div>
                </div>                
            </div>
        </div>

       <br />

         <div class="row">
            <div class="col-sm-12 col-md-12 col-lg-12 col-12">                
                <asp:GridView ID="grid_officer" runat="server" AutoGenerateColumns="false" GridLines="Both" BorderStyle="Solid" EnableTheming="False" CellPadding="2"
                    CellSpacing="2" HeaderStyle-BackColor="#0b2d4d" HeaderStyle-ForeColor="White" CssClass="gridfont" AlternatingRowStyle-BackColor="White"
                    AllowSorting="true" Width="100%">
                    <HeaderStyle CssClass="gridheader" />
                    <Columns>
                        <asp:TemplateField HeaderText="S No" HeaderStyle-VerticalAlign="Top" ItemStyle-HorizontalAlign="Left" ItemStyle-VerticalAlign="Top">
                            <ItemTemplate>
                                <%# Container.DataItemIndex+1 %>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Department" HeaderStyle-VerticalAlign="Top" ItemStyle-HorizontalAlign="Left" ItemStyle-VerticalAlign="Top">
                            <ItemTemplate>
                                <%# Eval("dept_abb")%>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Name" HeaderStyle-VerticalAlign="Top" ItemStyle-HorizontalAlign="Left" ItemStyle-VerticalAlign="Top">
                            <ItemTemplate>
                                <%# Eval("user_name")%>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Designation" HeaderStyle-VerticalAlign="Top" ItemStyle-HorizontalAlign="Left" ItemStyle-VerticalAlign="Top">
                            <ItemTemplate>
                                <%# Eval("designation")%>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Mobile" HeaderStyle-VerticalAlign="Top" ItemStyle-HorizontalAlign="Left" ItemStyle-VerticalAlign="Top">
                            <ItemTemplate>
                                <%# Eval("contactno")%>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Email" HeaderStyle-VerticalAlign="Top" ItemStyle-HorizontalAlign="Left" ItemStyle-VerticalAlign="Top">
                            <ItemTemplate>
                                <%# Eval("email")%>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </div>
        </div>
        </div>

                    
        <br />
       
    

</asp:Content>

