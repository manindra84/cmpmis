<%@ Page Title="" Language="C#" MasterPageFile="~/Master_sitemaster.master" AutoEventWireup="true" CodeFile="AssignNodalOfficer.aspx.cs" Inherits="AssignNodalOfficer" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

     <div class="container">

        <div class="row" id="inputaction" runat="server">
            <div class="col-md-12 col-lg-12 col-12" id="trsearch" runat="server">
                <div class="form-group">
                    <center>
                        <%--<asp:Label runat="server" class ID="lblnorecord" Visible="true"></asp:Label>--%>
                        <label id="lblnorecord" runat="server" style="color:#0b2d4d;" visible="true"></label>
                    </center>
                </div>

                 <div class="form-group" id="tr1" runat="server">
                    <center>
                        <label id="gridheading" runat="server" style="color: #0b2d4d;"><strong>List of Projects</strong></label>
                    </center>
                </div>

                <div class="form-group">                  
                       <%--<label id="lbl_projctname" style="color:#0b2d4d;" text="Project Name"></label>--%>
                    <label for="lbl_projctname" style="color:#0b2d4d;">Project Name</label>
                    <asp:TextBox ID="txtboxpname" Width="100%" runat="server" class="form-control"
                        placeholder="Project Name"  MaxLength="150"></asp:TextBox>
                </div>
                              

                <div class="form-group">                  
                 <asp:Button ID="btnsearch" runat="server" Text="Search" OnClick="btnsearch_Click" class="btn btn-primary"
                                    ValidationGroup="1" />
                </div>
                 
                <div class="table-responsive">
                    <table id="projctdetails" runat="server" width="100%">

                    </table>
                </div>
                

             <div class="grid">
                 <asp:Label ID="lbl_gridheading" runat="server" style="color:#0b2d4d;font-size:15px;font-weight:800;"></asp:Label>  
                 <asp:GridView ID="grdprojctdtls" Width="70%" runat="server" class="table table-responsive" AutoGenerateColumns="false"  GridLines="Both" BorderStyle="Solid" EnableTheming="False"
                CellPadding="2" CellSpacing="2" HeaderStyle-BackColor="#0b2d4d" HeaderStyle-ForeColor="White" CssClass="gridfont" AlternatingRowStyle-BackColor="White"
                  DataKeyNames="pcode,nouserid" OnRowCommand="grdprojctdtls_RowCommand" OnRowDataBound="grdprojctdtls_RowDataBound" >
                <HeaderStyle CssClass="gridheader" />
                <Columns>

                    <asp:TemplateField HeaderText="S.No" Visible="true" HeaderStyle-VerticalAlign="Top" ItemStyle-HorizontalAlign="left" ItemStyle-VerticalAlign="Top">
                        <ItemTemplate>

                         <%# Container.DataItemIndex+1 %>
                         
                        </ItemTemplate>
                    </asp:TemplateField>  
                                     
                    <asp:TemplateField HeaderText="Name of Project" HeaderStyle-VerticalAlign="Top" ItemStyle-VerticalAlign="Top" ItemStyle-HorizontalAlign="Left" SortExpression="pname">
                                <ItemTemplate>
                                    <asp:Label ID="lblpname" runat="server" Text='<%# Eval ("pname") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>

                    <asp:TemplateField HeaderText="Nodal Department" HeaderStyle-Width="100px" HeaderStyle-VerticalAlign="Top" ItemStyle-VerticalAlign="Top" SortExpression="nodaldept" ItemStyle-HorizontalAlign="Left">
                                <ItemTemplate>
                                    <asp:Label ID="lbldeptname" runat="server" Text='<%# Eval ("nodaldept") %>' ></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>    
                                  
                    <asp:TemplateField HeaderText="Due Date" HeaderStyle-Width="100px" HeaderStyle-VerticalAlign="Top" ItemStyle-VerticalAlign="Top" SortExpression="startdt" ItemStyle-HorizontalAlign="Left">
                                <ItemTemplate>
                                    <asp:Label ID="Label1" runat="server" Text='<%# Eval ("enddt") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>

                    <asp:TemplateField HeaderText="Nodal Officer" HeaderStyle-VerticalAlign="Top" ItemStyle-VerticalAlign="Top" ItemStyle-HorizontalAlign="Left">
                                <ItemTemplate>
                                    <asp:DropDownList ID="ddlofficer" runat="server"></asp:DropDownList>
                                   <%-- <asp:RequiredFieldValidator id="reqnodal" Text="Select Nodal Officer " 
                                        InitialValue="0" ControlToValidate="ddlofficer" Runat="server" />--%> 
                                </ItemTemplate>
                    </asp:TemplateField>

                   <asp:TemplateField>
                       <ItemTemplate>
                           <asp:LinkButton ID="lnkassign" runat="server" Text="Assign" CommandName="assign" CommandArgument='<%# Container.DataItemIndex %>'></asp:LinkButton>
                       </ItemTemplate>
                   </asp:TemplateField>
                </Columns>
            </asp:GridView>                      
                 </div>
            </div>
            </div>
               
        </div>
     <input id="csrftoken" type="hidden" name="csrftoken" runat="server" />
</asp:Content>

