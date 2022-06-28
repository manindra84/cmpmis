<%@ Page Title="" Language="C#" MasterPageFile="~/Master_sitemaster.master" AutoEventWireup="true" CodeFile="addsubproject.aspx.cs" Inherits="addsubproject" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <script src="JS/jquery.min.js" type="text/javascript"></script>
    <script src="JS/jquery-ui.min.js" type="text/javascript"></script>
    <link href="JS/jquery-ui.css" rel="Stylesheet" type="text/css" />


    <div class="container">

        <div class="row">
            <div class="col-lg-12 col-md-12 col-12">

                <div class="form-group">
                    <br />
                   
                        <asp:Label runat="server" ID="lblheader" Style="color: #0b2d4d; font-size: 20px;"></asp:Label>
                  
                </div>

                <div class="form-group" style="margin:0;">
                    <label id="lblpname" style="color: #0b2d4d;"><strong>Project Name : </strong></label>
                    <label id="lblprojectname" runat="server" style="color: #0b2d4d;"></label>
                </div>

                <div class="form-group" style="margin:0;">
                    <label id="lbl_nodaldept" style="color: #0b2d4d;"><strong>Nodal Department : </strong></label>
                    <label id="lblnodaldept" runat="server" style="color: #0b2d4d;"></label>
                </div>

                    

                <div class="form-group" style="margin:0;">
                    <label id="lbl_ppcomdate" style="color: #0b2d4d;"><strong>Due Date : </strong></label>
                    <label id="lblppcomdate" runat="server" style="color: #0b2d4d;"></label>
                </div>
                <br />

                <div class="form-group">
                    <label for="lblpname" style="color: #0b2d4d;"><strong>Enter Sub Project</strong></label>
                    <asp:TextBox ID="txtsubprojectname" Width="50%" runat="server" class="form-control"
                        placeholder="SubProject Name" TextMode="MultiLine" MaxLength="500"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="Rfpname" runat="server" ControlToValidate="txtsubprojectname"
                        Display="none" ErrorMessage="Please Enter Sub Project " ValidationGroup="1"></asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="reg_txtpname" runat="server" ControlToValidate="txtsubprojectname"
                        ValidationExpression="^[a-zA-Z0-9 _,/]{0,500}$" ErrorMessage="Enter valid character upto 500 Length"
                        SetFocusOnError="true" ValidationGroup="1" ForeColor="Blue" />
                </div>
                  <div class="form-group">
                    <left><asp:Button ID="btn_submit" runat="server" Text="Submit" OnClick="btn_submit_Click" class="btn btn-primary"
                                    ValidationGroup="1" /></left>
                </div>
                <br />

                <div class="form-group" runat="server" id="tr6" visible="true">
                    <center>
                    </center>
                </div>

                <div class="form-group" runat="server" >
                     <%if (dt != null && dt.Rows.Count > 0)
      { %>
    <table class="table table-bordered table-striped" style="margin-top:10px">
        <thead>
            <tr>
                <th>
                    S.No.
                </th>
                <th>
                    Sub Project
                </th>          
            </tr>
        </thead>
        <tbody>
            <%for (int i = 0; i < dt.Rows.Count; i++)
                {
                      %>
            <tr>
                <td>
                    <%=i+1 %>
                </td>
                <td>
                    <%=dt.Rows[i]["subprojname"].ToString()%>
                </td>
            </tr>
            <%} %>
        </tbody>
    </table>
    <%}
      else
      { %>

   <%-- <table class="table">
        <thead>
            <tr>
                <th>
                    No details.
                </th>
            </tr>
        </thead>
    </table>--%>

    <%} %>

                </div>

            </div>
        </div>
    </div>
    <asp:ValidationSummary ID="ValidationSummary1" runat="server" ValidationGroup="1"
        ShowSummary="false" ShowMessageBox="true" />

   

    <asp:HiddenField ID="hfpcode" runat="server" />

    <input id="csrftoken" type="hidden" name="csrftoken" runat="server" />

</asp:Content>

