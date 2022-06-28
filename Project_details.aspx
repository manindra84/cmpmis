<%@ Page Title="" Language="C#" MasterPageFile="~/Master_sitemaster.master" AutoEventWireup="true"
    CodeFile="Project_details.aspx.cs" Inherits="Project_details" %>


<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    
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
                       <%--<label id="lbl_deptname" style="color:#0b2d4d;" text="Department Name"></label>--%>
                    <label for="lbl_deptname" style="color:#0b2d4d;">Department Name</label>
                     <asp:DropDownList ID="ddldept" runat="server" class="form-control">
                    </asp:DropDownList>
                </div>

                <div class="form-group">                  
                       <%--<label id="lbl_projctname" style="color:#0b2d4d;" text="Project Name"></label>--%>
                    <label for="lbl_projctname" style="color:#0b2d4d;">Project Name</label>
                    <asp:TextBox ID="txtboxpname" Width="100%" runat="server" class="form-control"
                        placeholder="Project Name"  MaxLength="150"></asp:TextBox>
                </div>

                <div class="form-group">                  
                       <%--<label id="lblstatus" style="color:#0b2d4d;" text="Status" visible="false" runat="server"></label>--%>
                    <label for="lblstatus" id="lblstatus" runat="server" style="color:#0b2d4d;" visible="false">Status</label>
                   <asp:DropDownList ID="ddlstatus" runat="server" class="form-control" visible="false">
                    </asp:DropDownList>
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
                 AllowSorting="true" DataKeyNames="pname,pcode" OnRowCommand="grdprojctdtls_RowCommand" OnSorting="grdprojctdtls_Sorting">
                <HeaderStyle CssClass="gridheader" />
                <Columns>
                    <asp:TemplateField HeaderText="S.No" Visible="false" HeaderStyle-VerticalAlign="Top" ItemStyle-HorizontalAlign="left" ItemStyle-VerticalAlign="Top">
                        <ItemTemplate>
                            <asp:LinkButton ID="lbtn_normal" runat="server" CommandName="normal" CommandArgument='<%# DataBinder.Eval(Container, "RowIndex") %>' Text="<%# Container.DataItemIndex+1 %>"></asp:LinkButton>                             
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="S.No" Visible="false" HeaderStyle-VerticalAlign="Top" ItemStyle-HorizontalAlign="left" ItemStyle-VerticalAlign="Top">
                        <ItemTemplate>                           
                            <asp:LinkButton ID="lbtn_newactivity" runat="server" CommandName="newactivity" CommandArgument='<%# DataBinder.Eval(Container, "RowIndex") %>' Text="<%# Container.DataItemIndex+1 %>"></asp:LinkButton>                            
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="S.No" Visible="false" HeaderStyle-VerticalAlign="Top" ItemStyle-HorizontalAlign="left" ItemStyle-VerticalAlign="Top">
                        <ItemTemplate>                            
                            <asp:LinkButton ID="lbtn_viewactivity" runat="server" CommandName="viewactivity" CommandArgument='<%# DataBinder.Eval(Container, "RowIndex") %>' Text="<%# Container.DataItemIndex+1 %>"></asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Name of Project" HeaderStyle-VerticalAlign="Top" ItemStyle-VerticalAlign="Top" ItemStyle-HorizontalAlign="Left" SortExpression="pname">
                                <ItemTemplate>
                                    <asp:Label ID="lblpname" runat="server" Text='<%# Eval ("pname") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>

                    <asp:TemplateField HeaderText="Nodal Department" HeaderStyle-Width="100px" HeaderStyle-VerticalAlign="Top" ItemStyle-VerticalAlign="Top" SortExpression="nodaldept" ItemStyle-HorizontalAlign="Left">
                                <ItemTemplate>
                                    <asp:Label ID="lbldeptname" runat="server" Text='<%# Eval ("nodaldept") %>' ToolTip='<%#string.Concat("Department(s) Concerned  : ", " ", Eval("deptname")) %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>

                    <%--<asp:TemplateField HeaderText="Start Date" HeaderStyle-VerticalAlign="Top" ItemStyle-VerticalAlign="Top" SortExpression="startdt" ItemStyle-HorizontalAlign="Left">
                                <ItemTemplate>
                                    <asp:Label ID="lblstartdate" runat="server" Text='<%# Eval ("startdt") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>--%>
                    <asp:TemplateField HeaderText="Due Date" HeaderStyle-Width="100px" HeaderStyle-VerticalAlign="Top" ItemStyle-VerticalAlign="Top" SortExpression="startdt" ItemStyle-HorizontalAlign="Left">
                                <ItemTemplate>
                                    <asp:Label ID="Label1" runat="server" Text='<%# Eval ("enddt") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>

                    <%--<asp:TemplateField HeaderText="Status" HeaderStyle-VerticalAlign="Top" ItemStyle-VerticalAlign="Top" ItemStyle-HorizontalAlign="Left">
                                <ItemTemplate>
                                    <asp:Label ID="lbl_status" runat="server" Text='<%# Eval ("status") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>--%>
                    <asp:TemplateField HeaderText="Add New Activity" Visible="false" HeaderStyle-VerticalAlign="Top" ItemStyle-VerticalAlign="Top" ItemStyle-HorizontalAlign="Left">
                                <ItemTemplate>
                                    <asp:HyperLink runat="server" ID="hlinkIssues" Text="Click to Add" ForeColor="#407DC7"></asp:HyperLink>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="View Activity List" Visible="false" HeaderStyle-VerticalAlign="Top" ItemStyle-VerticalAlign="Top" ItemStyle-HorizontalAlign="Left">
                                <ItemTemplate>
                                    <asp:HyperLink runat="server" ID="hlinkviewworkdone" Text="Click to View" ForeColor="#407DC7"></asp:HyperLink>
                                </ItemTemplate>
                            </asp:TemplateField>

                       <asp:TemplateField HeaderText="Add Sub Project" Visible="false" HeaderStyle-Width="20%" HeaderStyle-VerticalAlign="Top" ItemStyle-VerticalAlign="Top" ItemStyle-HorizontalAlign="Left">
                                <ItemTemplate>
                                    <asp:LinkButton ID="lbtn_addsubproject" runat="server" CommandName="addsubproject" CommandArgument='<%# DataBinder.Eval(Container, "RowIndex") %>' Text="Add Sub Project"></asp:LinkButton>
                                </ItemTemplate>
                            </asp:TemplateField>


                         <asp:TemplateField HeaderText="Edit" Visible="false" HeaderStyle-Width="20%" HeaderStyle-VerticalAlign="Top" ItemStyle-VerticalAlign="Top" ItemStyle-HorizontalAlign="Left">
                                <ItemTemplate>
                                    <asp:LinkButton ID="lbtn_editproject" runat="server" CommandName="editproject" CommandArgument='<%# DataBinder.Eval(Container, "RowIndex") %>' Text="Edit Project Details" ></asp:LinkButton>
                                </ItemTemplate>
                            </asp:TemplateField>


                        <asp:TemplateField HeaderText="Delete" Visible="false" HeaderStyle-Width="20%" HeaderStyle-VerticalAlign="Top" ItemStyle-VerticalAlign="Top" ItemStyle-HorizontalAlign="Left">
                                <ItemTemplate>
                                    <asp:LinkButton ID="lbtn_deleteproject" runat="server" CommandName="deleteproject" CommandArgument='<%# DataBinder.Eval(Container, "RowIndex") %>' Text="Delete Project" OnClientClick="return confirm('Are you sure you want to delete project details ,All the Task Details and CM Directions will be deleted for this Project Details and cannot be retrieved?');"></asp:LinkButton>
                                </ItemTemplate>
                            </asp:TemplateField>

                    


                </Columns>
            </asp:GridView>



                      <%--<asp:GridView ID="grdprojctdtls" Width="100%" class="table" runat="server" AutoGenerateColumns="false" Visible="true" HeaderStyle-BackColor="#0b2d4d" HeaderStyle-ForeColor="White"
                        CssClass="gridfont" AlternatingRowStyle-BackColor="White" OnRowDataBound="grdprojctdtls_RowDataBound" AllowSorting="true" DataKeyNames="pname,pcode" OnSorting="grdprojctdtls_Sorting">
                        <HeaderStyle CssClass="gridheader" />
                        <Columns>
                            <asp:TemplateField HeaderText="S.No" HeaderStyle-VerticalAlign="Top" ItemStyle-HorizontalAlign="Left" ItemStyle-VerticalAlign="Top">
                                <ItemTemplate>
                                    <%#Container.DataItemIndex+1%>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Name of Project" HeaderStyle-VerticalAlign="Top" ItemStyle-VerticalAlign="Top" ItemStyle-HorizontalAlign="Left" SortExpression="pname">
                                <ItemTemplate>
                                    <asp:Label ID="lblpname" runat="server" Text='<%# Eval ("pname") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Nodal Department" HeaderStyle-Width="100px" HeaderStyle-VerticalAlign="Top" ItemStyle-VerticalAlign="Top" SortExpression="nodaldept" ItemStyle-HorizontalAlign="Left">
                                <ItemTemplate>
                                    <asp:Label ID="lbldeptname" runat="server" Text='<%# Eval ("nodaldept") %>' ToolTip='<%#string.Concat("Department(s) Concerned  : ", " ", Eval("deptname")) %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Start Date" HeaderStyle-VerticalAlign="Top" ItemStyle-VerticalAlign="Top" SortExpression="startdt" ItemStyle-HorizontalAlign="Left">
                                <ItemTemplate>
                                    <asp:Label ID="lblstartdate" runat="server" Text='<%# Eval ("startdt") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Proposed Completion Date" HeaderStyle-Width="100px" HeaderStyle-VerticalAlign="Top" ItemStyle-VerticalAlign="Top" SortExpression="startdt" ItemStyle-HorizontalAlign="Left">
                                <ItemTemplate>
                                    <asp:Label ID="Label1" runat="server" Text='<%# Eval ("enddt") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Status" HeaderStyle-VerticalAlign="Top" ItemStyle-VerticalAlign="Top" ItemStyle-HorizontalAlign="Left">
                                <ItemTemplate>
                                    <asp:Label ID="lbl_status" runat="server" Text='<%# Eval ("status") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Add New Activity" Visible="false" HeaderStyle-VerticalAlign="Top" ItemStyle-VerticalAlign="Top" ItemStyle-HorizontalAlign="Left">
                                <ItemTemplate>
                                    <asp:HyperLink runat="server" ID="hlinkIssues" Text="Click to Add" ForeColor="#407DC7"></asp:HyperLink>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="View Activity List" Visible="false" HeaderStyle-VerticalAlign="Top" ItemStyle-VerticalAlign="Top" ItemStyle-HorizontalAlign="Left">
                                <ItemTemplate>
                                    <asp:HyperLink runat="server" ID="hlinkviewworkdone" Text="Click to View" ForeColor="#407DC7"></asp:HyperLink>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>--%>
                 </div>
            </div>
            </div>
               
        </div>
     <input id="csrftoken" type="hidden" name="csrftoken" runat="server" />
</asp:Content>
