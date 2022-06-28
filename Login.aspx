<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="Login.aspx.cs" Inherits="Login" %>

<asp:Content ID="Content" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script language="javascript" src="JS/Sha512.js" type="text/javascript"></script>
    <script src="JS/aes.js" type="text/javascript"></script>
    <script language="JavaScript" type="text/JavaScript">
        function hashPass() {
            debugger;
            UserId = document.getElementById("<%=txtUserId.ClientID%>").value.trim();
            if (UserId == "") {
                alert("Please Enter Your UserId.");
                document.getElementById("<%=txtUserId.ClientID%>").focus();
                return false;
            }

            pwd = document.getElementById("<%=txtPwd.ClientID%>").value.trim();
            if (pwd == "") {
                alert("Please Enter Your Password.");
                document.getElementById("<%=txtPwd.ClientID%>").focus();
                return false;
            }
            else {
                var key = CryptoJS.enc.Utf8.parse('8080808080808080');
                var iv = CryptoJS.enc.Utf8.parse('8080808080808080');

                var encryptedlogin = CryptoJS.AES.encrypt(CryptoJS.enc.Utf8.parse(UserId), key,
                    {
                        keySize: 128 / 8,
                        iv: iv,
                        mode: CryptoJS.mode.CBC,
                        padding: CryptoJS.pad.Pkcs7
                    });
                document.getElementById("<%=txtUserId.ClientID %>").value = encryptedlogin
                if (document.getElementById('ctl00_ContentPlaceHolder1_txtPwd').value != "") {
                    document.getElementById('ctl00_ContentPlaceHolder1_txtPwd').value = Sha512.hash(document.getElementById('ctl00_ContentPlaceHolder1_txtPwd').value);
                    document.getElementById('ctl00_ContentPlaceHolder1_txtPwd').value = Sha512.hash(document.getElementById('ctl00_ContentPlaceHolder1_txtPwd').value + '<%=newsalt%>');
                }
            }
        }
    </script>
    <section class="headerTop ">
        <div class="container ">
            <div class="content">
                <div class="row">
                    <div class="col-lg-12 col-md-12 col-sm-12 col-12">
                        <h4 class="clr-blue">Authenticate Yourself</h4>
                        <hr />
                        <div class="row">
                            <div class="col-lg-6 col-md-6 col-12">
                                <div class="form-group">
                                    <label for="exampleInputEmail1">*User ID.</label>
                                    <asp:TextBox ID="txtUserId" TextMode="SingleLine" runat="server" AutoCompleteType="None" Columns="20" class="form-control" MaxLength="10" autocomplete="off"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Enter UserID"
                                        Display="Dynamic" ForeColor="Red" ControlToValidate="txtUserId" ValidationGroup="SubmitDetails"></asp:RequiredFieldValidator>
                                </div>
                                <div class="form-group">
                                    <label for="exampleInputEmail1">*Password</label>


                                    <asp:TextBox ID="txtPwd" TextMode="Password" AutoCompleteType="None" runat="server" Columns="20" class="form-control" MaxLength="10"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ErrorMessage="Enter Password"
                                        Display="Dynamic" ForeColor="Red" ControlToValidate="txtPwd" ValidationGroup="SubmitDetails"></asp:RequiredFieldValidator>
                                </div>

                                <div class="form-group">

                                    <label for="exampleInputEmail1">Enter Captcha</label>
                                    <asp:TextBox ID="txtCaptcha" runat="server" Width="140px" MaxLength="6" AutoCompleteType="None" class="form-control" placeholder="Enter captcha"></asp:TextBox><br />
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" ForeColor="Red" runat="server"
                                        ControlToValidate="txtCaptcha" Display="Dynamic" ErrorMessage="* Field cannot blank!"
                                        ValidationGroup="SubmitDetails">
                                    </asp:RequiredFieldValidator>

                                    <div>
                                        <img width="110px" height="35px" alt="Visual verification" title="Please enter the security code as shown in the image."
                                            src="JpegImage_CS.aspx?r=<%= System.Guid.NewGuid().ToString("N") %>" vspace="5"
                                            tabindex="-1" />
                                        <asp:ImageButton ToolTip="Click here to load a new Image" runat="server" ImageUrl="~/images/refresh.jpg"
                                            ID="ibtnRefresh" OnClick="ibtnRefresh_Click" OnClientClick="return SignValidateRefresh();"
                                            TabIndex="-1" />
                                    </div>
                                    <div>
                                        <asp:Label ID="lblMsgLogin" Text="" runat="server"></asp:Label></div>
                                </div>
                                <asp:Button ID="btnLogin" Text="LogIn" runat="server" ValidationGroup="SubmitDetails"
                                    OnClick="btnLogin_Click" OnClientClick="hashPass()" />

                                <asp:HiddenField ID="txtClientSignature" runat="server" />
                                <asp:Label ID="Label1" Text="" runat="server"></asp:Label>

                            </div>
                            <%--<div class="col-lg-6 col-md-6 col-sm-12 col-12">
                            <img src="images/cert.jpg">
                            </div>--%>
                        </div>
                    </div>

                </div>
            </div>
            </div>
    </section>
</asp:Content>
