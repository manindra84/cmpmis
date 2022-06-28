<%@ Page Title="" Language="C#" MasterPageFile="~/Master_sitemaster.master" AutoEventWireup="true" CodeFile="taskAction.aspx.cs" Inherits="taskAction" EnableEventValidation="false" %>

<%@ Register Src="~/UserControl/ProjectDetails.ascx" TagPrefix="uc" TagName="ProjectDetails"%>  
<%@ Register Src="~/UserControl/TaskDetails.ascx" TagPrefix="uc1" TagName="taskDetails"%>  

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
     <%--bootstrap css--%>
    <%--<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
    <script type="text/C#" src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
    <script type="text/C#" src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
    <script type="text/C#" src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
 --%>
    <%--jquery, bootstrap and popper js files--%>
   <%-- <script type="text/C#" src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
    <script type="text/C#" src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
    <script type="text/C#" src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
    --%>
    <%--jquery js files--%>
    <script src="JS/jquery.min.js" type="text/javascript"></script>
    <script src="JS/jquery-ui.min.js" type="text/javascript"></script>
    <link href="JS/jquery-ui.css" rel="Stylesheet" type="text/css" />

    <script type="text/jscript">
        $(function () {
            $('#<%=txt_actiondt.ClientID %>').datepicker(
                {
                    dateFormat: 'dd/mm/yy',
                    changeMonth: true,
                    changeYear: true,
                    yearRange: '1950:2100'
                });
        })

        $(function () {
            $('#<%=txtnewdate.ClientID %>').datepicker(
          {
              dateFormat: 'dd/mm/yy',
              changeMonth: true,
              changeYear: true,
              yearRange: '1950:2100'
          });
                })

        $(document).ready(function () {

            $(txt_actiondt).datepicker({
                dateFormat: 'dd/mm/yy',
                minDate: "01/01/1900",
                maxDate: new Date,
                changeMonth: true,
                changeYear: true,
                showButtonPanel: true,
                yearRange: "-100:+50"
            });
        })

        $(function () {
            $('#<%=txtreason.ClientID %>').datepicker(
                 {
                     dateFormat: 'dd/mm/yy',
                     changeMonth: true,
                     changeYear: true,
                     yearRange: '1950:2100'
                 });
        })

        function LimtCharacters(txtMsg, CharLength, indicator) {
            chars = txtMsg.value.length;
            document.getElementById(indicator).innerHTML = CharLength - chars;
            if (chars > CharLength) {
                txtMsg.value = txtMsg.value.substring(0, CharLength);
            }
        }
    </script>
           
     <style>

        #hrtag
        {
            background-color:#0b2d4d;         
            padding:0px;
        }

    </style> 

    <div class="container">
        <br />
         <center>
            <asp:Label ID="lbl_mainheading" runat="server" style="color:#0b2d4d;font-size:20px;font-weight:800;"></asp:Label>
                </center>
       
        
        <div class="row">
            <uc:ProjectDetails ID="projectdetailscontrol" runat="server" /> 
        </div>
       
       <hr id="hrtag" />
 
         <div class="row">
            <uc1:taskDetails ID="taskdetails" runat="server" /> 
        </div>
   


         <%------------ Update Form for Timeline Revise ---------------%>
        <div class="row">           
           
           
        </div>
        <br />
        <div class="row" id="updatedate" runat="server" visible="false" width="100%">
            <div class="col-lg-12 col-md-12 col-12">
                <div class="form-group" >
                    <label for="lbl_newdate" style="color:#0b2d4d;"><strong>New Target Date*</strong></label>
                    <asp:TextBox ID="txtnewdate" Width="100%" runat="server" class="form-control" MaxLength="10">
                                    </asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtnewdate"
                        Display="none" ErrorMessage="Please Enter New Target Date" ValidationGroup="1"></asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="regex_newdate" runat="server" ErrorMessage="Invalid  Date."
                        ValidationExpression="^(?:(?:31(\/|-|\.)(?:0?[13578]|1[02]))\1|(?:(?:29|30)(\/|-|\.)(?:0?[13-9]|1[0-2])\2))(?:(?:1[6-9]|[2-9]\d)?\d{2})$|^(?:29(\/|-|\.)0?2\3(?:(?:(?:1[6-9]|[2-9]\d)?(?:0[48]|[2468][048]|[13579][26])|(?:(?:16|[2468][048]|[3579][26])00))))$|^(?:0?[1-9]|1\d|2[0-8])(\/|-|\.)(?:(?:0?[1-9])|(?:1[0-2]))\4(?:(?:1[6-9]|[2-9]\d)?\d{2})$"
                        ControlToValidate="txtnewdate" ValidationGroup="1"
                        ForeColor="Red" Display="Dynamic"></asp:RegularExpressionValidator>
                </div>
                <div class="form-group" style="margin-bottom: 0;">
                    <label for="lbl_reason" style="color: #0b2d4d;"><strong>Reason for revising timeline*</strong></label>
                    <asp:TextBox ID="txtreason" Width="100%" runat="server" class="form-control"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="txtreason"
                        Display="none" ErrorMessage="Please Enter Reason for Revising Timeline" ValidationGroup="1"></asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="regex_reason" runat="server" ControlToValidate="txtreason"
                        ValidationExpression="^[a-zA-Z0-9 .,]{0,500}$" ErrorMessage="*Enter valid characters"
                        SetFocusOnError="true" ValidationGroup="1" />
                </div>
                <div class="form-group" >
                    <asp:Button ID="btnupdt" runat="server" Text="Update" OnClick="btnupdt_Click" class="btn btn-primary"
                                    ValidationGroup="1" />
                </div>
            </div>
        </div>

       
        <%------------ Update Form for Timeline Revise ---------------%>
        
        
            <asp:Label ID="gridheading_cm" runat="server" Visible="false" style="color:#0b2d4d;font-size:15px;font-weight:800;">Directions On Project</asp:Label>
               
         <div class="grid">
            <asp:GridView ID="Gridcmremarks" runat="server" AutoGenerateColumns="false" GridLines="Both" BorderStyle="Solid" EnableTheming="False" CellPadding="2"
                CellSpacing="2" HeaderStyle-BackColor="#0b2d4d" HeaderStyle-ForeColor="White" CssClass="gridfont" AlternatingRowStyle-BackColor="White" 
                AllowSorting="true" Visible="false" Width="45%">
                <HeaderStyle CssClass="gridheader" />
                <Columns>
                    <asp:TemplateField HeaderText="Sl No:" HeaderStyle-Width="60" HeaderStyle-VerticalAlign="Top" ItemStyle-HorizontalAlign="Left" ItemStyle-VerticalAlign="Top">
                        <ItemTemplate>
                            <%# Container.DataItemIndex+1 %>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Directions" HeaderStyle-VerticalAlign="Top" ItemStyle-HorizontalAlign="Left" ItemStyle-VerticalAlign="Top">
                        <ItemTemplate>
                            <%# Eval("cmremarks")%>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Date" HeaderStyle-Width="100" HeaderStyle-VerticalAlign="Top" ItemStyle-HorizontalAlign="Left" ItemStyle-VerticalAlign="Top">
                        <ItemTemplate>
                            <%# Eval("cmremarkdate")%>
                        </ItemTemplate>
                    </asp:TemplateField>               
                </Columns>
            </asp:GridView>
        </div>

         

        <%-- <div class="row">
            <div class="col-lg-12 col-md-12 col-12">
                <h3 style="margin:auto;font-size:20px;color:white;background-color:#0b2d4d;padding:5px;"><center>List of Activities</center></h3>
            </div>
        </div>--%>

        

        <%------------ Grid for listing actions ---------------%>
         <br />
            <asp:Label ID="gridheading_workdone" runat="server" Visible="false" style="color:#0b2d4d;font-size:15px;font-weight:800;">Details of Work Done</asp:Label>
          <br />
           <%-- <asp:Label ID="trheaderactions" Visible="false" runat="server" Text="#Click on Serial No. to Download Uploaded Documents" style="color:#A52A2A;font-size:15px;font-weight:800;"></asp:Label>--%>
           
        <div class="grid">
            <asp:GridView ID="Gridviewactions" runat="server" AutoGenerateColumns="false" GridLines="Both" BorderStyle="Solid" EnableTheming="False" CellPadding="2"
                CellSpacing="2" HeaderStyle-BackColor="#0b2d4d" HeaderStyle-ForeColor="White" CssClass="gridfont" AlternatingRowStyle-BackColor="White"
                AllowSorting="true" Visible="false" Width="60%" DataKeyNames="taskid,deptcode,contenttype,actionid" OnRowDataBound="Gridviewactions_RowDataBound">
                <HeaderStyle CssClass="gridheader" />
                <Columns>
                    <asp:TemplateField HeaderText="SNo:" HeaderStyle-Width="60" HeaderStyle-VerticalAlign="Top" ItemStyle-HorizontalAlign="Left" ItemStyle-VerticalAlign="Top">
                        <ItemTemplate>
                            <%# Container.DataItemIndex+1 %>
                             <%--<asp:HyperLink runat="server" ID="lnkbtserialnumberviewdoc" Target="_blank" Text='<%# Container.DataItemIndex+1 %>' ToolTip="Click on Serial No. to Download Uploaded Documents"></asp:HyperLink>--%>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Work Done" HeaderStyle-VerticalAlign="Top" ItemStyle-HorizontalAlign="Left" ItemStyle-VerticalAlign="Top">
                        <ItemTemplate>
                            <%# Eval("actiontaken")%>
                        </ItemTemplate>
                    </asp:TemplateField>
               
                    <asp:TemplateField HeaderText="Date" HeaderStyle-Width="100" HeaderStyle-VerticalAlign="Top" ItemStyle-HorizontalAlign="Left" ItemStyle-VerticalAlign="Top">
                        <ItemTemplate>
                            <%# Eval("actiondt")%>
                        </ItemTemplate>
                    </asp:TemplateField>  
                    
                         <asp:TemplateField HeaderText="Download"  HeaderStyle-Width="100" HeaderStyle-VerticalAlign="Top" ItemStyle-HorizontalAlign="Left" ItemStyle-VerticalAlign="Top">
                        <ItemTemplate>
<%--                           <asp:HyperLink runat="server" ID="hprlinkbtn" Target="_blank" ImageUrl='<%# "~/Images/" + (Eval("contenttype").ToString() == ".pdf" ? "pdf.png" : "imageshow.png") %>' Text="View" ToolTip="Click here to Download file" />--%>
                              <asp:HyperLink runat="server" ID="hprlinkbtn" Target="_blank" Text="View" ToolTip="Click here to Download file" />
                        </ItemTemplate>
                    </asp:TemplateField> 
                                 
                </Columns>
            </asp:GridView>
        </div>
        <%------------ Grid for listing actions ---------------%>

        

        <%------------ Input Form for Action Taken ---------------%> 
        
        <br />
        <div class="row" id="inputaction" runat="server" visible="false"> 
            <div class="col-lg-12 col-md-12 col-12">                
                <div class="form-group" style="margin-bottom:-13px;">
                    <label for="lbl_actiondetails" style="color:#0b2d4d;"><strong>Details of the Action Taken*</strong></label>
                    <asp:TextBox ID="txtactiondetail" Width="100%" runat="server" class="form-control"
                        placeholder="Details of the Action Taken" TextMode="MultiLine" MaxLength="500"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtactiondetail"
                        Display="none" ErrorMessage="Please Enter Details of the Action Taken" ValidationGroup="1"></asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="regex_actiondetail" runat="server" ControlToValidate="txtactiondetail"
                                         ValidationExpression="^[a-zA-Z0-9 .,]{0,500}$" ErrorMessage="*Enter valid characters"
                                        SetFocusOnError="true" ValidationGroup="1" />
                </div>
                <div class="form-group" style="margin-bottom:0;">
                    <label for="lbl_actiondt" style="color:#0b2d4d;"><strong>Date of Action Taken*</strong></label>
                    <asp:TextBox ID="txt_actiondt" Width="100%" runat="server" class="form-control">
                                    </asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txt_actiondt"
                        Display="none" ErrorMessage="Please Enter Date of the Action" ValidationGroup="1"></asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="regex_actiondt" runat="server" ErrorMessage="Invalid  Date."
                                        ValidationExpression="^(?:(?:31(\/|-|\.)(?:0?[13578]|1[02]))\1|(?:(?:29|30)(\/|-|\.)(?:0?[13-9]|1[0-2])\2))(?:(?:1[6-9]|[2-9]\d)?\d{2})$|^(?:29(\/|-|\.)0?2\3(?:(?:(?:1[6-9]|[2-9]\d)?(?:0[48]|[2468][048]|[13579][26])|(?:(?:16|[2468][048]|[3579][26])00))))$|^(?:0?[1-9]|1\d|2[0-8])(\/|-|\.)(?:(?:0?[1-9])|(?:1[0-2]))\4(?:(?:1[6-9]|[2-9]\d)?\d{2})$" 
                        ControlToValidate="txt_actiondt" ValidationGroup="1"
                                        ForeColor="Red" Display="Dynamic"></asp:RegularExpressionValidator>
                </div>

                <div class="col-lg-12 col-md-12 col-sm-12">
                    <label for="exampleInputLbl">
                        Upload Documents in PDF/JPEG/JPG Format Only*</label>
                    <asp:FileUpload ID="fuFileUpload" runat="server" class="form-control"></asp:FileUpload>
                   <%-- <asp:RequiredFieldValidator runat="server" ID="req_txtGCName" ControlToValidate="fuFileUpload"
                        ValidationGroup="SubmitDetails" ErrorMessage="Please Upload!" SetFocusOnError="true"
                        ForeColor="Blue" />--%>
                </div>

                 <div class="row">
                                <div class="col-lg-12 col-md-12 col-sm-12">
                                    <table style='font-family: Verdana; font-size: 10pt' border="0" width="100%">
                                        <tr>
                                            <td colspan="2">
                                                <b>Instruction & Error Code to Upload the File</b>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                1.
                                            </td>
                                            <td>
                                                File Size Should be less than 200 KB <b>(Error Code 100)</b>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                2.
                                            </td>
                                            <td>
                                                File Name Length Should be Less then 20 Characters (No Special Characters Allowed) and all alphabets are in small
                                                case like filename.jpeg <b>(Error Code 101)</b>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                3.
                                            </td>
                                            <td>
                                                Only .PDF/.JPEG/.JPG File Extensions are allowed. <b>(Error Code 102)</b>
                                            </td>
                                        </tr>
                                         <tr>
                                            <td>
                                                4.
                                            </td>
                                            <td>
                                                Please upload a single PDF/JPEG/JPG file.
                                            </td>
                                        </tr>
                                        <%--<tr>
                                            <td>
                                                4.
                                            </td>
                                            <td>
                                                Only .JPG/.JPEG File Extensions are allowed for photograph. <b>(Error Code 102)</b>
                                            </td>
                                        </tr>--%>
                                    </table>
                                </div>
                            </div>

                <div class="form-group" style="margin-top:10px;">
                    <asp:Button ID="btn_add" runat="server" Text="Submit" OnClick="btn_add_Click" class="btn btn-primary"
                                    ValidationGroup="1" />
                </div>
            </div>
        </div>
        <%------------ Input Form for Action Taken ---------------%>

       
        <asp:HiddenField ID="hfnd" runat="server" />
         <asp:HiddenField ID="hfduedate" runat="server" />
    <asp:ValidationSummary ID="ValidationSummary1" runat="server" ValidationGroup="1"
        ShowSummary="false" ShowMessageBox="true" />
        <asp:ValidationSummary ID="ValidationSummary2" runat="server" ValidationGroup="2"
        ShowSummary="false" ShowMessageBox="true" />
    <input id="csrftoken" type="hidden" name="csrftoken" runat="server" />
        
        
        <br />
    </div>
</asp:Content>

