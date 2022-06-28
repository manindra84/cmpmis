<%@ Page Title="" Language="C#" MasterPageFile="~/Master_sitemaster.master" AutoEventWireup="true" CodeFile="EditProject.aspx.cs" Inherits="EditProject" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <script src="JS/jquery.min.js" type="text/javascript"></script>
    <script src="JS/jquery-ui.min.js" type="text/javascript"></script>
    <link href="JS/jquery-ui.css" rel="Stylesheet" type="text/css" />

          <script type="text/jscript">
          <%--$(function () {
              $('#<%=txtstartdate.ClientID %>').datepicker(
    {
        dateFormat: 'dd/mm/yy',
        changeMonth: true,
        changeYear: true,
        yearRange: '1950:2100'
    });
          })--%>

          $(function () {
              $('#<%=txtenddate.ClientID %>').datepicker(
    {
        dateFormat: 'dd/mm/yy',
        changeMonth: true,
        changeYear: true,
        yearRange: '1950:2100'
    });
          })

function LimtCharacters1(txtboxdesc, CharLength, indicator) {
    chars = txtboxdesc.value.length;
              document.getElementById(indicator).innerHTML = CharLength - chars;
              if (chars > CharLength) {
                  txtboxdesc.value = txtboxdesc.value.substring(0, CharLength);
              }
          }
       
    </script>

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
                    <label id="lbl_ppcomdate" style="color: #0b2d4d;"><strong>Due Date : </strong></label>
                    <label id="lblppcomdate" runat="server" style="color: #0b2d4d;"></label>
                </div>
                <br />

                <div class="form-group">
                    <label for="lblpname" style="color: #0b2d4d;"><strong>Enter Project Name </strong></label>
                    <asp:TextBox ID="txtprojectname" Width="50%" runat="server" class="form-control"
                        placeholder="Project Name" TextMode="MultiLine" MaxLength="500"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="Rfpname" runat="server" ControlToValidate="txtprojectname"
                        Display="none" ErrorMessage="Please Enter Project " ValidationGroup="1"></asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="reg_txtpname" runat="server" ControlToValidate="txtprojectname"
                        ValidationExpression="^[a-zA-Z0-9 _,/]{0,500}$" ErrorMessage="Enter valid character upto 500 Length"
                        SetFocusOnError="true" ValidationGroup="1" ForeColor="Blue" />
                </div>

                 <div>
                    <label for="lbl_projenddate" style="color:#0b2d4d;"><strong>Project proposed Completion Date</strong></label>                    
                    <asp:TextBox ID="txtenddate" Width="100%" runat="server" class="form-control"></asp:TextBox>
                   <%-- <asp:RequiredFieldValidator ID="rfcenddate" runat="server" ControlToValidate="txtenddate"
                        Display="none" ErrorMessage="Project proposed Completion Date not be blank" ValidationGroup="1"></asp:RequiredFieldValidator>--%>
                     <asp:RegularExpressionValidator ID="rdstartdate" runat="server" ControlToValidate="txtenddate"
                         ValidationExpression="(0[1-9]|[12][0-9]|3[01])[- /.](0[1-9]|1[012])[- /.](19|20)\d\d" ErrorMessage="*End Date should be in DD/MM/YYYY "
                         SetFocusOnError="true" ValidationGroup="1" />
                </div> 

                  <div class="form-group">
                    <left><asp:Button ID="btn_submit" runat="server" Text="Update" OnClick="btn_submit_Click" class="btn btn-primary"
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

