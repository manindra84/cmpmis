<%@ Page Title="" Language="C#" MasterPageFile="~/Master_sitemaster.master" AutoEventWireup="true"
    CodeFile="CMOProject_details.aspx.cs" Inherits="CMOProject_details" %>


<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    
    
    <div class="container" runat="server" id="trsearch" >
        <br />
        <div class="col-lg-12 col-md-12 col-12"  runat="server" id="divsearch" visible="false">
            <div class="form-group">
                <label for="inputdeptname">Department Name :</label>
                <asp:DropDownList runat="server" ID="ddldept" Width="20%" class="form-control"></asp:DropDownList>
            </div>

            <div class="form-group">
                <label for="inputProjectName">Project Name:</label>
               <asp:TextBox runat="server" ID="txtboxpname" MaxLength="150" Width="40%" class="form-control"></asp:TextBox>
            </div>

              <div class="form-group">
                <asp:Label runat="server" ID="lblstatus" Visible="false" Width="100px" Text="Status" class="form-control"></asp:Label>
               <asp:DropDownList runat="server" ID="ddlstatus" Width="20%" Visible="false" class="form-control"></asp:DropDownList>
            </div>

              <div class="form-group">
                <asp:Button runat="server" ID="btnsearch" Text="Search" class="btn btn-primary" OnClick="btnsearch_Click" />
            </div>

        </div>
      
        <div class="col-lg-12 col-md-12 col-12">
              <asp:Label runat="server" ID="lblnorecord"  Visible="true" ></asp:Label>
        </div>

        <center>
          <div class="col-lg-12 col-md-12 col-12">
              <asp:Label runat="server" ID="lblheader"  Visible="true" Text="List of Projects" Font-Bold="true " style="color:#0b2d4d;"></asp:Label>
        </div>
        </center>

         <div class="col-lg-12 col-md-12 col-12">
            <asp:Label ID="gridheading" runat="server" Text="#Click on Serial No. to View Project Details" style="color:#A52A2A;font-size:15px;font-weight:800;"></asp:Label>
                </div>
        <div class="col-lg-12 col-md-12 col-12">
            <asp:GridView ID="grdprojctdtls" Width="70%" runat="server" AutoGenerateColumns="false"
                Visible="true" HeaderStyle-BackColor="#0b2d4d" HeaderStyle-ForeColor="White"
                CssClass="gridfont" AlternatingRowStyle-BackColor="White"
                OnRowDataBound="grdprojctdtls_RowDataBound" AllowSorting="true"
                DataKeyNames="pname,pcode" OnSorting="grdprojctdtls_Sorting">
                <Columns>
                    <asp:TemplateField HeaderText="S.No" HeaderStyle-VerticalAlign="Top" ItemStyle-HorizontalAlign="Left" ItemStyle-VerticalAlign="Top" HeaderStyle-Width="5%">
                        <ItemTemplate>
                           <%-- <%#Container.DataItemIndex+1%>--%>
                            <asp:HyperLink runat="server" ID="lnkbtncmoview" Text='<%# Container.DataItemIndex+1 %>' ToolTip="Click on Serial No. to View Project Details"></asp:HyperLink>
                            <%-- <asp:LinkButton ID="lnkbtncmoview" runat="server" CommandName="action" CommandArgument='<%# DataBinder.Eval(Container, "RowIndex") %>' Text="<%# Container.DataItemIndex+1 %>"></asp:LinkButton>   --%>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Name of Project" HeaderStyle-VerticalAlign="Top" ItemStyle-VerticalAlign="Top" ItemStyle-HorizontalAlign="Left" SortExpression="pname" HeaderStyle-Width="50%">
                        <ItemTemplate>
                          <%--  <asp:HyperLink runat="server" ID="hlinkpname" Text='<%# Eval ("pname") %>'></asp:HyperLink>--%>

                             <asp:Label ID="lblpname" runat="server" Text='<%# Eval ("pname") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Nodal Department" HeaderStyle-Width="8%" HeaderStyle-VerticalAlign="Top" ItemStyle-VerticalAlign="Top"  SortExpression="nodaldept" ItemStyle-HorizontalAlign="Left">
                        <ItemTemplate>
                            <%-- <asp:Label ID="lbldeptname" runat="server" Text='<%# Eval ("nodaldept") %>' ToolTip='<%#string.Concat("Department(s) Concerned  : ", " ", Eval("deptname")) %>'></asp:Label>--%>
           <%--                 <asp:HyperLink runat="server" ID="hlinknodaldept" Text='<%# Eval ("nodaldept") %>'></asp:HyperLink>--%>
                             <asp:Label ID="lblnodaldept" runat="server" Text='<%# Eval ("nodaldept") %>'></asp:Label>

                        </ItemTemplate>
                    </asp:TemplateField>

                    <%-- <asp:TemplateField HeaderText="Start Date" HeaderStyle-VerticalAlign = "Top" ItemStyle-VerticalAlign = "Top" SortExpression = "startdt" ItemStyle-HorizontalAlign="Left">
                            <ItemTemplate>
                                <asp:Label ID="lblstartdate" runat="server" Text='<%# Eval ("startdt") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>--%>

                    <asp:TemplateField HeaderText="Due Date" HeaderStyle-Width="8%" HeaderStyle-VerticalAlign="Top" ItemStyle-VerticalAlign="Top" SortExpression="startdt" ItemStyle-HorizontalAlign="Left">
                        <ItemTemplate>
                               <asp:Label ID="Label1" runat="server" Text='<%# Eval ("enddt") %>'></asp:Label>
                           <%-- <asp:HyperLink runat="server" ID="hlinkenddate" Text='<%# Eval ("enddt") %>'></asp:HyperLink>--%>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <%--  <asp:TemplateField HeaderText="All Department(s) Concerned" HeaderStyle-VerticalAlign = "Top" ItemStyle-VerticalAlign = "Top" ItemStyle-HorizontalAlign="Left">
                          <ItemTemplate>
                            <asp:Label ID="lblconcerned" runat="server" Text='<%# Eval ("dept_abb") %>'></asp:Label>
                        </ItemTemplate>
                         </asp:TemplateField>--%>

                    <asp:TemplateField HeaderText="Status" HeaderStyle-VerticalAlign="Top" Visible="false" ItemStyle-VerticalAlign="Top" ItemStyle-HorizontalAlign="Left">
                        <ItemTemplate>
                            <asp:Label ID="lblstatus" runat="server" Text='<%# Eval ("status") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Project Trail" HeaderStyle-VerticalAlign="Top" ItemStyle-VerticalAlign="Top" ItemStyle-HorizontalAlign="Left">
                        <ItemTemplate>
                            <asp:HyperLink runat="server" ID="linkbtn_trail" Text="View"></asp:HyperLink>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <%--                      <asp:TemplateField HeaderText="Add New Activity" Visible="false" HeaderStyle-VerticalAlign = "Top" ItemStyle-VerticalAlign = "Top" ItemStyle-HorizontalAlign="Left">
                            <ItemTemplate>
                                <asp:HyperLink runat="server" ID="hlinkIssues" Text="Click to Add" ForeColor="#407DC7"></asp:HyperLink>
                            </ItemTemplate>                         
                        </asp:TemplateField>--%>

                    <%--  <asp:TemplateField  HeaderText="View Activity List" Visible="false" HeaderStyle-VerticalAlign = "Top" ItemStyle-VerticalAlign = "Top" ItemStyle-HorizontalAlign="Left">
                            <ItemTemplate>
                                <asp:HyperLink runat="server" ID="hlinkviewworkdone" Text="Click to View" ForeColor="#407DC7"></asp:HyperLink>
                            </ItemTemplate>
                        </asp:TemplateField>--%>
                </Columns>
            </asp:GridView>

        </div>

    </div>
     <input id="csrftoken" type="hidden" name="csrftoken" runat="server" />
</asp:Content>
