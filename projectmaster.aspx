<%@ Page Title="" Language="C#" MasterPageFile="~/Master_sitemaster.master" AutoEventWireup="true"
    CodeFile="projectmaster.aspx.cs" Inherits="projectmaster" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script src="JS/jquery.min.js" type="text/javascript"></script>
    <script src="JS/jquery-ui.min.js" type="text/javascript"></script>
    <link href="JS/jquery-ui.css" rel="Stylesheet" type="text/css"  />

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

function LimtCharacters(txtMsg, CharLength, indicator)
      {
         chars = txtMsg.value.length;
         document.getElementById(indicator).innerHTML = CharLength - chars;
         if (chars > CharLength) {
             txtMsg.value = txtMsg.value.substring(0, CharLength);
         }
     }
       
    </script>



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
            <br />
        </div>
        <div class="row" id="inputaction" runat="server"> 
            <div class="col-lg-12 col-md-12 col-12">
                <div class="form-group">
                    <center>
                    <label for="lbl_pageheading" style="color:#0b2d4d;font-size:20px;"><strong>New Project Entry Form</strong></label>                    
                        </center>
                </div>
                <div class="form-group">
                    <label for="lbl_projecttype" style="color:#0b2d4d;"><strong>Project Type*</strong></label>
                    <asp:DropDownList ID="ddlpcategory" runat="server" class="form-control">
                    </asp:DropDownList>
                    <asp:RequiredFieldValidator ID="rfvpcategory" runat="server" ControlToValidate="ddlpcategory"
                        Display="none" ErrorMessage="Please Select Project Type" ValidationGroup="1"></asp:RequiredFieldValidator>
                </div>

                <div class="form-group">
                    <label for="lblpname" style="color:#0b2d4d;"><strong>Project Name*</strong></label>                    
                    <asp:TextBox ID="txtpname" Width="100%" runat="server" class="form-control"
                        placeholder="Project Name" TextMode="MultiLine" MaxLength="500"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="Rfpname" runat="server" ControlToValidate="txtpname"
                        Display="none" ErrorMessage="Please Enter Project Name" ValidationGroup="1"></asp:RequiredFieldValidator>
                      <asp:RegularExpressionValidator ID="reg_txtpname" runat="server" ControlToValidate="txtpname"
                                ValidationExpression="^[a-zA-Z0-9 _,/]{0,500}$" ErrorMessage="Enter valid character upto 500 Length"
                                SetFocusOnError="true" ValidationGroup="1" ForeColor="Blue" />
                </div>

                <div class="form-group">
                    <label for="lbl_projdescription" style="color:#0b2d4d;"><strong>Brief Description of the Project</strong></label>                    
                    <asp:TextBox ID="txtboxdesc" Width="100%" runat="server" class="form-control"
                        placeholder="Brief Description of the Project" TextMode="MultiLine" MaxLength="500"></asp:TextBox> 
                      <asp:RegularExpressionValidator ID="reg_txtboxdesc" runat="server" ControlToValidate="txtboxdesc"
                                ValidationExpression="^[a-zA-Z0-9 _,/]{0,500}$" ErrorMessage="Enter valid character upto 500 Length"
                                SetFocusOnError="true" ValidationGroup="1" ForeColor="Blue" />                   
                </div>

                 <%--<div class="form-group">
                    <label for="lbl_projstartdate" style="color:#0b2d4d;"><strong>Project Start Date*</strong></label>                    
                    <asp:TextBox ID="txtstartdate" Width="100%" runat="server" class="form-control"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfcstartdate" runat="server" ControlToValidate="txtstartdate"
                        Display="none" ErrorMessage="Start Date should not be blank" ValidationGroup="1"></asp:RequiredFieldValidator>
                     <asp:RegularExpressionValidator ID="rfstartdtae" runat="server" ControlToValidate="txtstartdate"
                         ValidationExpression="(0[1-9]|[12][0-9]|3[01])[- /.](0[1-9]|1[012])[- /.](19|20)\d\d" ErrorMessage="*Start Date should be in DD/MM/YYYY"
                         SetFocusOnError="true" ValidationGroup="1" />
                </div>--%>

                <div class="form-group">
                    <label for="lbl_projenddate" style="color:#0b2d4d;"><strong>Project proposed Completion Date</strong></label>                    
                    <asp:TextBox ID="txtenddate" Width="100%" runat="server" class="form-control"></asp:TextBox>
                   <%-- <asp:RequiredFieldValidator ID="rfcenddate" runat="server" ControlToValidate="txtenddate"
                        Display="none" ErrorMessage="Project proposed Completion Date not be blank" ValidationGroup="1"></asp:RequiredFieldValidator>--%>
                     <asp:RegularExpressionValidator ID="rdstartdate" runat="server" ControlToValidate="txtenddate"
                         ValidationExpression="(0[1-9]|[12][0-9]|3[01])[- /.](0[1-9]|1[012])[- /.](19|20)\d\d" ErrorMessage="*End Date should be in DD/MM/YYYY "
                         SetFocusOnError="true" ValidationGroup="1" />
                </div>                

                <div class="form-group">
                    <asp:GridView ID="grddept" runat="server" AutoGenerateColumns="false" Visible="true"
                        GridLines="None" CssClass="labelwithoutbold" Width="70%" DataKeyNames="deptcode">
                        <HeaderStyle CssClass="label" HorizontalAlign="Left" Font-Underline="true" />
                        <RowStyle HorizontalAlign="Left" />
                        <Columns>
                            <asp:TemplateField HeaderText="Select Department(s) Concerned" ControlStyle-ForeColor="#407DC7">
                                <ItemTemplate>
                                    <asp:CheckBox ID="chk" runat="server" ForeColor="#407DC7" />
                                    <%# Eval("deptname") %>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Tick, if Nodal" ItemStyle-HorizontalAlign="Left">
                                <ItemTemplate>
                                    <asp:CheckBox ID="chknd" runat="server" AutoPostBack="true" OnCheckedChanged="chknd_CheckedChanged" />
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                </div>
                <div class="form-group">
                    <br />
                </div>
                <div class="form-group">
                    <center><asp:Button ID="btn_submit" runat="server" Text="Submit" OnClick="btn_submit_Click" class="btn btn-primary"
                                    ValidationGroup="1" /></center>
                </div>

                </div>
            </div>        
        </div>
    <asp:HiddenField ID="hfnd" runat="server" />
    <%-- <asp:HiddenField ID="hfpcode" runat="server" />--%>
    <asp:ValidationSummary ID="ValidationSummary1" runat="server" ValidationGroup="1"
        ShowSummary="false" ShowMessageBox="true" />
  <%--  <input id="csrftoken" type="hidden" name="csrftoken" runat="server" />--%>
</asp:Content>
