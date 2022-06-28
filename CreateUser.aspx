<%@ Page Title="" Language="C#" MasterPageFile="~/Master_sitemaster.master" AutoEventWireup="true"
    CodeFile="CreateUser.aspx.cs" Inherits="CreateUser" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <section class="headerTop ">
    <div class="container ">
        <div class="content">
            <div class="row">
                <div class="col-lg-12 col-md-12 col-sm-12 col-12">
                    <h4 class="clr-blue">
                        User Creation Form</h4>
                    <hr>
                    <div class="row">
                        <div class="col-lg-6 col-md-6 col-12">
                            <div class="text-right">
                                All fields are mandatory</div>
                            <div class="form-group">
                                <label for="exampleInputEmail1">
                                    User Id*</label>
                                <asp:TextBox ID="txtUserId" runat="server" class="form-control" placeholder="Enter User Id"
                                    MaxLength="10"></asp:TextBox>
                                <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator3" ControlToValidate="txtUserId"
                                    ValidationGroup="SubmitDetails" ErrorMessage="Please Enter UserID!" SetFocusOnError="true" />
                                <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="txtUserId"
                                    ValidationExpression="^([A-Za-z])+(?:(([A-Za-z\s]))|(\.[A-Za-z\s]+))*([A-Za-z])+$"
                                    ErrorMessage="*Valid characters: Alphabets and space." SetFocusOnError="true"
                                    ValidationGroup="SubmitDetails" />
                            </div>
                            <div class="form-group">
                                <label for="exampleInputEmail1">
                                    User Type*</label>
                                <asp:DropDownList ID="ddlUserType" runat="server" class="form-control">
                                    <asp:ListItem Text="Verifier" Value="1"></asp:ListItem>
                                    <asp:ListItem Text="Issuer" Value="2"></asp:ListItem>
                                </asp:DropDownList>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ErrorMessage="Please select value"
                                    Display="Dynamic" ForeColor="Red" ControlToValidate="ddlUserType" ValidationGroup="SubmitDetails"></asp:RequiredFieldValidator>
                                <br />
                            </div>
                            <div class="form-group">
                                <label for="exampleInputEmail1">
                                    User Name*</label>
                                <asp:TextBox ID="txtUserName" runat="server" class="form-control" placeholder="Enter User Name"
                                    MaxLength="35"></asp:TextBox>
                                <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator1" ControlToValidate="txtUserName"
                                    ValidationGroup="SubmitDetails" ErrorMessage="Please Enter User Name!" SetFocusOnError="true" />
                                <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ControlToValidate="txtUserName"
                                    ValidationExpression="^([A-Za-z])+(?:(([A-Za-z\s]))|(\.[A-Za-z\s]+))*([A-Za-z])+$"
                                    ErrorMessage="*Valid characters: Alphabets and space." SetFocusOnError="true"
                                    ValidationGroup="SubmitDetails" />
                            </div>
                            <div class="form-group">
                                <label for="exampleInputEmail1">
                                    Designation*</label>
                                <asp:TextBox ID="txtDesignation" runat="server" class="form-control" placeholder="Enter Designation"
                                    MaxLength="35"></asp:TextBox>
                                <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator2" ControlToValidate="txtDesignation"
                                    ValidationGroup="SubmitDetails" ErrorMessage="Please Enter Designation!" SetFocusOnError="true" />
                                <asp:RegularExpressionValidator ID="RegularExpressionValidator3" runat="server" ControlToValidate="txtDesignation"
                                    ValidationExpression="^([A-Za-z])+(?:(([A-Za-z\s]))|(\.[A-Za-z\s]+))*([A-Za-z])+$"
                                    ErrorMessage="*Valid characters: Alphabets and space." SetFocusOnError="true"
                                    ValidationGroup="SubmitDetails" />
                            </div>
                            <div class="form-group">
                                <label for="exampleInputEmail1">
                                    Mobile No.*</label>
                                <asp:TextBox ID="txtMobileNo" runat="server" class="form-control" placeholder="Enter Mobile No."
                                    ClientIDMode="Static" MaxLength="10" onkeydown="return onlyNumbers(event)">
                                </asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvMobNo" runat="server" ErrorMessage="Please Provide Mobile No!"
                                    Display="Dynamic" ValidationGroup="SubmitDetails" ForeColor="Red" ControlToValidate="txtMobileNo"></asp:RequiredFieldValidator>
                                <asp:RegularExpressionValidator ID="revMobNo" runat="server" ErrorMessage="Invalid Mobile Number."
                                    ValidationExpression="^[7-9][0-9]{9}$" ControlToValidate="txtMobileNo" ValidationGroup="SubmitDetails"
                                    ForeColor="Red" Display="Dynamic"></asp:RegularExpressionValidator>
                                <br />
                            </div>
                            <div class="form-group">
                                <label for="exampleInputEmail1">
                                    Email ID*</label>
                                <asp:TextBox ID="txtEmail" runat="server" ClientIDMode="Static" class="form-control"
                                    placeholder="Enter Email Id" MaxLength="30">
                                </asp:TextBox>
                                <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator4" ControlToValidate="txtEmail"
                                    ValidationGroup="SubmitDetails" ErrorMessage="Please Provide Email Id.!" SetFocusOnError="true" />
                                <asp:RegularExpressionValidator ID="validateEmail" runat="server" ErrorMessage="Invalid email."
                                    ControlToValidate="txtEmail" ValidationGroup="SubmitDetails" ValidationExpression="^([\w\.\-]+)@([\w\-]+)((\.(\w){2,3})+)$" />
                                <div id="error_email">
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="exampleInputEmail1">
                                    Whether Active*</label>
                                <asp:DropDownList ID="ddlActive" runat="server" class="form-control">
                                    <asp:ListItem Text="Yes" Value="true"></asp:ListItem>
                                    <asp:ListItem Text="No" Value="false"></asp:ListItem>
                                </asp:DropDownList>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ErrorMessage="Please select value"
                                    Display="Dynamic" ForeColor="Red" ControlToValidate="ddlActive" ValidationGroup="SubmitDetails"></asp:RequiredFieldValidator>
                                <br />
                            </div>
                            <div>
                                <asp:Label ID="lblMsgLogin" Text="" runat="server"></asp:Label></div>
                            <div class="form-group">
                                <asp:Button ID="btnSubmit" runat="server" Text="Submit" OnClick="btnSubmit_Click"
                                    class="btn btn-primary" ValidationGroup="SubmitDetails" />
                                     <asp:Button ID="btnUpdate" runat="server" Text="Update" Visible="false" 
                                     class="btn btn-primary" ValidationGroup="SubmitDetails" 
                                    onclick="btnUpdate_Click" />
                            </div>
                        </div>
                        <br />
                        <br />
                        <div class="col-lg-12 col-md-12 col-sm-12 col-12">
                            <h4 class="text-center">
                                User List</h4>
                            <%if (dtView.Rows.Count > 0)
                              {%>
                            <table class="tableStyle" border="1" cellspacing="0" cellpadding="0" align="center"
                                width="96%">
                                <tr>
                                    <th>
                                        S.No.
                                    </th>
                                    <th>
                                        User Id
                                    </th>
                                    <th>
                                        User Name
                                    </th>
                                    <th>
                                        Mobile No.
                                    </th>
                                    <th>
                                        Email Id
                                    </th>
                                    <th>
                                       User Type
                                    </th>
                                    <th>
                                        Status
                                    </th>
                                    <th>
                                        Edit
                                    </th>
                                </tr>
                                <%for (int i = 0; i < dtView.Rows.Count; i++)
                                  { %>
                                <tr>
                                    <td>
                                        <%=(i+1 )%>
                                    </td>
                                    <td>
                                        <%=dtView.Rows[i]["userid"].ToString()%>
                                    </td>
                                    <td>
                                        <%=dtView.Rows[i]["username"].ToString()%>
                                    </td>
                                    <td>
                                        <%=dtView.Rows[i]["mobileno"].ToString()%>
                                    </td>
                                    <td>
                                        <%=dtView.Rows[i]["emailid"].ToString()%>
                                    </td>
                                    <td>
                                    <%if (dtView.Rows[i]["usertypeid"].ToString() == "1")
                                      { %>
                                        Verifier
                                        <%}
                                      else if (dtView.Rows[i]["usertypeid"].ToString() == "2")
                                      { %>
                                      Issuer
                                        <%} %>
                                    </td>
                                    <td>
                                        <%=dtView.Rows[i]["status"].ToString()%>
                                    </td>
                                    <td align="center">
                                        <a href="CreateUser.aspx?Userid=<%=Utlity.Encryptdata(dtView.Rows[i]["userid"].ToString()) %>">
                                            Edit</a>
                                    </td>
                                </tr>
                                <%} %>
                            </table>
                            <%} %>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    </section>
</asp:Content>
