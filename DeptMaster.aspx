<%@ Page Title="" Language="C#" MasterPageFile="~/Master_sitemaster.master" AutoEventWireup="true"
    CodeFile="DeptMaster.aspx.cs" Inherits="DeptMaster" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script type="text/javascript">
        function LimtCharacters(txtMsg, CharLength, indicator) {
            chars = txtMsg.value.length;
            document.getElementById(indicator).innerHTML = CharLength - chars;
            if (chars > CharLength) {
                txtMsg.value = txtMsg.value.substring(0, CharLength);
            }
        }

    </script>
    <div class="container">
        <br />
        <div class="row">
            
            <div class="col-lg-12 col-md-12 col-12">
                <center><label id="lbl_gridheading" style="color: #0b2d4d;"><strong>List of Departments</strong></label></center>
                <asp:GridView ID="grddept" runat="server" AutoGenerateColumns="false"
                    ShowFooter="true" Visible="true" HeaderStyle-BackColor="#0b2d4d" DataKeyNames="deptcode,userid,dept_abb"
                    HeaderStyle-ForeColor="White" CssClass="gridfont" Width="100%"
                    AlternatingRowStyle-BackColor="White" HorizontalAlign="Center" OnRowCancelingEdit="grddept_RowCancelingEdit"
                    OnRowEditing="grddept_RowEditing1" OnRowUpdating="grddept_RowUpdating1" OnRowCommand="grddept_RowCommand"
                    OnRowDataBound="grddept_RowDataBound" OnSelectedIndexChanged="grddept_SelectedIndexChanged">
                    <Columns>
                        <asp:TemplateField HeaderText="S.No" ItemStyle-HorizontalAlign="Left">
                            <ItemTemplate>
                                <%#Container.DataItemIndex+1%>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Name of Department" ItemStyle-HorizontalAlign="Left">
                            <EditItemTemplate>
                                <asp:TextBox ID="txtEname" runat="server" Width="250px" TextMode="MultiLine" onkeyup="LimtCharacters(this,100,'lblEname');" Text='<%# Eval("deptname") %>'></asp:TextBox><br />
                                Number of Characters Left:<label id="lblEname" style="color: Red; font-weight: bold;">100</label><br />
                                <asp:RequiredFieldValidator ID="refEname" runat="server" ControlToValidate="txtEname"
                                    ErrorMessage="Please Enter name of department" Display="None" ValidationGroup="2"></asp:RequiredFieldValidator>
                                  <asp:RegularExpressionValidator ID="revdeptname" runat="server" ControlToValidate="txtEname" 
                                      ValidationExpression="^[\sa-zA-Z0-9]*$" Display="None" ErrorMessage="Invalid Characters In Dept Name"
                        ValidationGroup="2"></asp:RegularExpressionValidator>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="lblname" runat="server" Text='<%# Eval ("deptname") %>'></asp:Label>
                            </ItemTemplate>
                            <FooterTemplate>
                                <asp:TextBox ID="txtFname" runat="server" TextMode="MultiLine" onkeyup="LimtCharacters(this,100,'lblFname');" Width="250px"></asp:TextBox><br />
                                 Number of Characters Left:<label id="lblFname" style="color: Red; font-weight: bold;">100</label><br />
                                <asp:RequiredFieldValidator ID="rfFName" runat="server" ControlToValidate="txtFname"
                                    ErrorMessage="Please Enter name of department" Display="None" ValidationGroup="1"></asp:RequiredFieldValidator>
                                 <asp:RegularExpressionValidator ID="revdeptfooter" runat="server" ControlToValidate="txtFname" 
                                      ValidationExpression="^[\sa-zA-Z0-9]*$" Display="None" ErrorMessage="Invalid Characters In Dept Name"
                        ValidationGroup="1"></asp:RegularExpressionValidator>
                            </FooterTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Short Name" ItemStyle-HorizontalAlign="Left">
                            <EditItemTemplate>
                                <asp:TextBox ID="txtEabb" runat="server" MaxLength="10" onkeyup="LimtCharacters(this,100,'lblEabb');" Width="250px" Text='<%# Eval("dept_abb") %>'
                                    Enabled="false"></asp:TextBox><br />
                                     Number of Characters Left:<label id="lblEabb" style="color: Red; font-weight: bold;">10</label><br />
                                <asp:RequiredFieldValidator ID="rfabb" runat="server" ControlToValidate="txtEabb"
                                    ErrorMessage="Please Enter Department Abbreviation" Display="None" ValidationGroup="2"></asp:RequiredFieldValidator>
                                <asp:RegularExpressionValidator ID="Reabbr" runat="server" ValidationExpression="^[a-zA-Z]*$"
                                    ErrorMessage="Only Alphabets are allowed in Abbreviation(Without space)" ControlToValidate="txtEabb"
                                    ValidationGroup="2" Display="None"></asp:RegularExpressionValidator>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="lblabbre" runat="server" Text='<%# Eval ("dept_abb") %>'></asp:Label>
                            </ItemTemplate>
                            <FooterTemplate>
                                <asp:TextBox ID="txtFabbr" runat="server" MaxLength="10" onkeyup="LimtCharacters(this,100,'lblFabb');" Width="250px"></asp:TextBox> <br />
                                 Number of Characters Left:<label id="lblFabb" style="color: Red; font-weight: bold;">10</label><br />
                                <asp:RequiredFieldValidator ID="rfFabb" runat="server" ControlToValidate="txtFabbr"
                                    ErrorMessage="Please Enter Department Abbreviation" Display="None" ValidationGroup="1"></asp:RequiredFieldValidator>
                                <asp:RegularExpressionValidator ID="ReFabbr" runat="server" ValidationExpression="^[a-zA-Z]*$"
                                    ErrorMessage="Only Alphabets are allowed in Abbreviation(Without space)" ControlToValidate="txtFabbr"
                                    ValidationGroup="1" Display="None"></asp:RegularExpressionValidator>
                            </FooterTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="User Id" ItemStyle-HorizontalAlign="Left">
                            <ItemTemplate>
                                <asp:HyperLink ID="hylink" runat="server" Text='<%# Eval ("userid") %>'></asp:HyperLink>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:ButtonField CommandName="Reset" Text="Reset Password" ButtonType="Button" />
                        <asp:TemplateField>
                            <FooterTemplate>
                                <asp:LinkButton ID="lnkadd" runat="server" CausesValidation="true" CommandName="Add"
                                    ValidationGroup="1" Text="Add New Department"></asp:LinkButton>
                            </FooterTemplate>
                            <FooterStyle VerticalAlign="Top" HorizontalAlign="Left" />
                        </asp:TemplateField>
                        <asp:CommandField ShowEditButton="True" ValidationGroup="2">
                            <HeaderStyle CssClass="gridheader" />
                            <ItemStyle CssClass="gridfont" />
                        </asp:CommandField>
                    </Columns>
                </asp:GridView>
            </div>
        </div>
    
        <asp:ValidationSummary ID="valsum" runat="server" ValidationGroup="1" ShowSummary="false"
            ShowMessageBox="true" />
        <asp:ValidationSummary ID="ValidationSummary1" runat="server" ValidationGroup="2" ShowSummary="false"
            ShowMessageBox="true" />
   
        </div>
    <input id="csrftoken" type="hidden" name="csrftoken" runat="server" />
</asp:Content>
