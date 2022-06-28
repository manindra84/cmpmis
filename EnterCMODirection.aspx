<%@ Page Title="" Language="C#" MasterPageFile="~/Master_sitemaster.master" AutoEventWireup="true" CodeFile="EnterCMODirection.aspx.cs" Inherits="EnterCMODirection" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

<script src="JS/jquery.min.js" type="text/javascript"></script>
    <script src="JS/jquery-ui.min.js" type="text/javascript"></script>
    <link href="JS/jquery-ui.css" rel="Stylesheet" type="text/css" />

       <script type="text/jscript">
        $(function () {
            $('#<%=txtboxcmdirdate.ClientID %>').datepicker(
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

    <div class="container" runat="server">
        <br />  
            <div class="col-lg-12 col-md-12 col-12" align="right">
                <asp:Button runat="server" ID="btnback" Text="Back" OnClick="btnback_Click" class="btn btn-primary" />
            </div>

        <div class="col-lg-12 col-md-12 col-12">
 
         <div>
                <asp:Label runat="server" ID="lblheader" Text="Project Details" style="margin: auto; font-size: 20px; color: #0b2d4d;"></asp:Label>
            </div>

         <div >             
                 <strong>  <asp:Label ID="lblprojectname" runat="server" ></asp:Label></strong>
            </div>

           <div style="margin-bottom:-7px;">
                <strong>  <label for="inputProjectName">Nodal Department:</label></strong>
                 <asp:Label ID="lblnodaldept" runat="server"></asp:Label>
               </div>       

          <div runat="server">
               <strong>  <label for="inputProjectName">Due Date:</label></strong>
                <asp:Label ID="lblppcomdate" runat="server"></asp:Label>
            </div>

             <div runat="server" id="tr3" visible="false" style="margin-bottom:-7px;">
                  <label for="inputProjectName">Other Concerned Departments:</label>
                 <asp:Label ID="lblotherconcerneddept" runat="server"></asp:Label>
                </div>

        <%--aarush_uat--%>
           <%--<div runat="server" visible="false">
                <label for="inputProjectName">Project Started on:</label>
                <asp:Label ID="Label1projstarteddate" runat="server" ></asp:Label>
            </div>--%>

          </div>

        <div class="col-lg-12 col-md-12 col-12">
            <div >
                <asp:Label runat="server" ID="lblacname" Text="Activity Details" Style="margin: auto; font-size: 20px; color: #0b2d4d;"></asp:Label>
            </div>

             <div style="margin-bottom:-7px;">
              <strong>   <label for="inputProjectName">Activity Name:</label></strong>
                <asp:Label ID="lblactivityname" runat="server" ></asp:Label>
             </div>

             <%--aarush_uat--%>
             <%--<div style="margin-bottom:-7px;">
              <strong>   <label for="inputProjectName">Start Date:</label></strong>
                <asp:Label ID="lblactivityissuedate" runat="server" ></asp:Label>
             </div>--%>

              <div >
              <strong>   <label for="inputProjectName">Due Date:</label> </strong>
                <asp:Label ID="lblactivityduedate" runat="server" ></asp:Label>
             </div>

        </div>



        <div class="col-lg-6 col-md-6 col-6">
            <asp:Label runat="server" ID="trcmview" Text="Details of the Directions in the Project" Style="margin: auto; font-size: 20px; color: #0b2d4d;"></asp:Label>
            <asp:GridView ID="Gridcmremarks" runat="server" AutoGenerateColumns="false" GridLines="Both" BorderStyle="Solid" EnableTheming="False" CellPadding="2"
                CellSpacing="2" HeaderStyle-BackColor="#0b2d4d" HeaderStyle-ForeColor="White" CssClass="gridfont" AlternatingRowStyle-BackColor="White" HorizontalAlign="Center"
                AllowSorting="true" Visible="false" Width="100%">
                <HeaderStyle CssClass="gridheader" />
                <Columns>
                    <asp:TemplateField HeaderText="Sl No" HeaderStyle-VerticalAlign="Top" ItemStyle-HorizontalAlign="Left" ItemStyle-VerticalAlign="Top">
                        <ItemTemplate>
                            <%# Container.DataItemIndex+1 %>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Directions" HeaderStyle-VerticalAlign="Top" ItemStyle-HorizontalAlign="Left" ItemStyle-VerticalAlign="Top">
                        <ItemTemplate>
                            <%# Eval("cmremarks")%>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Date" HeaderStyle-VerticalAlign="Top" ItemStyle-HorizontalAlign="Left" ItemStyle-VerticalAlign="Top">
                        <ItemTemplate>
                            <%# Eval("cmremarkdate")%>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </div>
        <br />

         <div class="form-group;col-lg-12 col-md-12 col-12" runat="server" id="tr5" visible="true">
               <label id="inputProjectName">CM Office Directions/Remarks if any:</label>
             <asp:TextBox ID="txtcmremarks" TextMode="MultiLine" Width="100%"
                    MaxLength="500" onkeyup="LimtCharacters(this,500,'lblcmremarks');" runat="server"></asp:TextBox>
               Number of Characters Left:<label id="lblcmremarks" style="color: Red; font-weight: bold;">500</label><br />
                <asp:RequiredFieldValidator ID="rfvcmremarks" runat="server" ControlToValidate="txtcmremarks"
                    Display="none" ErrorMessage="Please Enter CM Office directions,remarks if any" ValidationGroup="1"></asp:RequiredFieldValidator>
             </div>

          <div class="form-group;col-lg-12 col-md-12 col-12" runat="server" id="tr7" visible="true">
               <label id="lblinputdateofdirec">Date of Direction:</label>
                  <asp:TextBox ID="txtboxcmdirdate" runat="server"></asp:TextBox>
               <asp:RequiredFieldValidator ID="Rfacdate" runat="server" ControlToValidate="txtboxcmdirdate"
                    Display="none" ErrorMessage="Please Enter Date of Direction" ValidationGroup="1"></asp:RequiredFieldValidator>
                <asp:RegularExpressionValidator ID="rfvcmdate" runat="server" ControlToValidate="txtboxcmdirdate"
                    ErrorMessage="Date of Direction should be in DD/MM/YYYY" ValidationExpression="(0[1-9]|[12][0-9]|3[01])[- /.](0[1-9]|1[012])[- /.](19|20)\d\d"
                    ValidationGroup="1" Display="None"></asp:RegularExpressionValidator>
              
             </div>
        <%--aarush_uat--%>
        <div class="form-group;col-lg-12 col-md-12 col-12" runat="server" id="Div1" visible="true"> 
            <asp:CheckBox ID="chk_whetherdeptvisible" runat="server" Visible="false" AutoPostBack="true" Text="Whether to be made visible to department" />
             </div>

          <div class="form-group;col-lg-12 col-md-12 col-12" runat="server" id="tr8" visible="true">
               <asp:Button ID="btnsbmt" runat="server" ValidationGroup="1" Text="Submit" OnClick="btnsbmt_Click" class="btn btn-primary" />
             </div>
    </div>

    

<asp:ValidationSummary ID="ValidationSummary1" runat="server" ValidationGroup="1"
        ShowSummary="false" ShowMessageBox="true" />

    <asp:HiddenField ID="hfpcode" runat="server" />
     <asp:HiddenField ID="hftaskid" runat="server" />
      <asp:HiddenField ID="hfcmview" runat="server" />
      <asp:HiddenField ID="hfview" runat="server" />

      <input id="csrftoken" type="hidden" name="csrftoken" runat="server" />

</asp:Content>

