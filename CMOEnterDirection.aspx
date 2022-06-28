<%@ Page Title="" Language="C#" MasterPageFile="~/Master_sitemaster.master" AutoEventWireup="true" EnableEventValidation="false" CodeFile="CMOEnterDirection.aspx.cs" Inherits="CMOEnterDirection" %>


<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

    <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js"></script>
    <script src="http://ajax.aspnetcdn.com/ajax/jquery.ui/1.8.9/jquery-ui.js" type="text/javascript"></script>
    <link href="http://ajax.aspnetcdn.com/ajax/jquery.ui/1.8.9/themes/start/jquery-ui.css" rel="stylesheet" type="text/css" />

    <%--<script type="text/javascript">
    $(function () {
        $("[id*=btn_earliertimeline]").click(function () {
            ShowPopup();
            return false;
        });
    });
    function ShowPopup() {
        $("#dialog").dialog({
            title: "Revise Timeline",
            width: 400,
            height: 250,            
            //buttons:
            //{
            //    Ok: function ()
            //    {
            //        $(this).dialog('close');
            //    }
            //},
            modal: true,            
         <% FillModal(taskid1.ToString()); %>
        });               
    }
    </script>--%>

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
    
    <%--<iframe id="forPostyouradd" data-src="EarlierTimeline.aspx?taskid=<%= taskid1 %>" src="about:blank" width="500" height="200" style="background: #ffffff"></iframe>

    <script type="text/javascript">
        function postYourAdd() {
            var iframe = $("#forPostyouradd");
            iframe.attr("src", iframe.data("src"));
        }
    </script>--%> 

    <style>
    .ui-widget-header
    {
        background:#0b2d4d;
    }   

    ui-dialog-title-dialog   
    {
        color:white;        
    }
</style>
    
    <div class="container" runat="server">
        <div class="col-lg-12 col-md-12 col-12">           
            <br />
            <%--------------------Project Details--------------------%>
            <div class="form-group" style="align-content: flex-end; margin: 0;">
                <div style="background-color: lightslategrey; width: 120px; border-radius: 5px; padding: 2px 2px 2px 6px;">
                    <strong>
                        <asp:Label runat="server" ID="Label1" Text="Project Details" Style="font-size: 13px; color: #0b2d4d;"></asp:Label>
                    </strong>
                </div>
            </div>

            <div class="form-group" style="margin: 0;">
                <strong>
                    <asp:Label ID="lblprojectname" runat="server" Style="font-size: 13px;"></asp:Label></strong>
            </div>

            <div class="form-group" style="margin-bottom: -7px;">
                <strong>
                    <label for="inputProjectName" style="font-size: 13px;">Nodal Department:</label></strong>
                <asp:Label ID="lblnodaldept" runat="server" Style="font-size: 13px;"></asp:Label>
            </div>

            <div class="form-group" style="margin: 0px;">
                <strong>
                    <label for="inputProjectName" style="font-size: 13px;">Due Date:</label></strong>
                <asp:Label ID="lblppcomdate" runat="server" Style="font-size: 13px;"></asp:Label>
            </div>
            <%--------------------Project Details End--------------------%>

            <%--------------------Actvity Details--------------------%>
             <div class="form-group" style="align-content:flex-end; margin:0;">
                 <div style="background-color:lightslategrey;width:160px;border-radius:5px;padding:2px 2px 2px 6px;">
                     <strong><asp:Label runat="server" ID="Label5" Text="Nodal Officer Details" style="font-size: 13px; color: #0b2d4d;"></asp:Label></strong>
                 </div>                 
            </div>           
               <div class="form-group" style="margin:0;">
                      <strong><asp:Label ID="Label2" runat="server" Text="Name: " style="font-size:13px;"></asp:Label></strong>
               <asp:Label ID="lblnodalname" runat="server" style="font-size:13px;"></asp:Label>
            </div>

             <div class="form-group" style="margin:0;">
             <strong><asp:Label ID="Label3" runat="server" Text="Mobile : " style="font-size:13px;"></asp:Label></strong>
           <asp:Label ID="lblNmob" runat="server" style="font-size:13px;"></asp:Label>
            </div>
             <div class="form-group" style="margin:0;">
                 <strong> <asp:Label ID="Label4" runat="server" Text="Email: " style="font-size:13px;"></asp:Label></strong>
            <asp:Label ID="lblemail" runat="server" style="font-size:13px;"></asp:Label>
            </div>
        <%--------------------Actvity Details End--------------------%>


              <div class="form-group" style="margin:0;">              
                <asp:RadioButtonList ID="rblstatus" runat="server" Font-Size="13px" CellPadding="5" AutoPostBack="true" RepeatDirection="Horizontal" OnSelectedIndexChanged="rblstatus_SelectedIndexChanged">
                    <asp:ListItem Text="Pending" Value="P" Selected="True"></asp:ListItem>
                      <asp:ListItem Text="Completed" Value="C"></asp:ListItem>
                      <asp:ListItem Text="All" Value="A"></asp:ListItem>
                </asp:RadioButtonList>
            </div>          

        </div>

        <div class="form-group" >
            <div class="col-sm-6 col-lg-6 col-md-6 col-6">
                <asp:Label runat="server" ID="lblheader" Style="margin: auto; font-size: 13px; font-weight: 800; color: #0b2d4d;"></asp:Label>
            </div>
            <div class="col-sm-6 col-md-6 col-lg-6 col-6" style="float:right;">
                <asp:ImageButton ID="imgbtn_excel" runat="server" style="margin-left:100px;" Height="30" Width="30" ImageUrl="~/images/xcel.png" OnClick="imgbtn_excel_Click" />
                <asp:ImageButton ID="imgbtn_pdf" runat="server"  Height="30" Width="30" ImageUrl="~/images/pdf.jpg" OnClick="imgbtn_pdf_Click" />
            </div>
        </div>
                 
        
        <div class="row" id="trheader" runat="server" visible="false">
            <div class="col-lg-12 col-md-12 col-12" >
                <asp:Label ID="gridheading" runat="server" Text="#Click on Serial No. to View Activity Details" Style="color: #A52A2A; font-size: 13px; font-weight: 800;"></asp:Label>
            </div>            
        </div>
         
        <div class="col-lg-12 col-md-12 col-12">
              <asp:GridView ID="grdprojview" Width="70%" runat="server" AutoGenerateColumns="false"
                    Visible="true" HeaderStyle-BackColor="#0b2d4d" HeaderStyle-ForeColor="White"
                    CssClass="gridfont" Font-Size="13px" AlternatingRowStyle-BackColor="White"                    
                    DataKeyNames="pcode,taskid" OnRowDataBound="grdprojview_RowDataBound" OnRowCommand="grdprojview_RowCommand">
                    <Columns>
                        <asp:TemplateField HeaderText="S.No" HeaderStyle-VerticalAlign = "Top" HeaderStyle-Width="5%" ItemStyle-HorizontalAlign="Left" ItemStyle-VerticalAlign = "Top" >
                            <ItemTemplate>
                                 <asp:HyperLink runat="server" ID="lnkbtncmoview" Text='<%# Container.DataItemIndex+1 %>' ToolTip="Click on Serial No. to View Activity Details"></asp:HyperLink>
                            </ItemTemplate>
                        </asp:TemplateField> 
                        <asp:TemplateField HeaderText="Activities" HeaderStyle-VerticalAlign = "Top" HeaderStyle-Width="50%" ItemStyle-VerticalAlign = "Top" ItemStyle-HorizontalAlign="Left" SortExpression = "pname" >
                            <ItemTemplate>
                                <asp:Label ID="lblpname" runat="server" Text='<%# Eval ("taskname") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                          <asp:TemplateField HeaderText="Assigned to" HeaderStyle-VerticalAlign = "Top" HeaderStyle-Width="8%" ItemStyle-VerticalAlign = "Top" ItemStyle-HorizontalAlign="Left" SortExpression = "pname" >
                            <ItemTemplate>
                                <asp:Label ID="lblissuedate" runat="server" Text='<%# Eval ("deptname") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>                         
                         <asp:TemplateField HeaderText="Earlier TimeLine" HeaderStyle-VerticalAlign = "Top" HeaderStyle-Width="8%" ItemStyle-VerticalAlign = "Top" ItemStyle-HorizontalAlign="Left" SortExpression = "pname" >
                            <ItemTemplate>                                
                                <%--<asp:LinkButton ID="lbtn_earliertimeline" runat="server" CommandName="action" CommandArgument='<%# DataBinder.Eval(Container, "RowIndex") %>' Text='<%# Eval ("earliertimeline") %>' OnClick="lbtn_earliertimeline_Click"></asp:LinkButton>--%>
                                <asp:Button ID="btn_earliertimeline" runat="server" Font-Size="13px" class="btn btn-link" Text='<%# Eval ("earliertimeline") %>' CommandName="action" CommandArgument='<%# DataBinder.Eval(Container, "RowIndex")  %>' />
                                <%--<asp:Button ID="btn_earliertimeline" runat="server" Font-Size="13px" class="btn btn-link" Text='<%# Eval ("earliertimeline") %>' OnClientClick="postYourAdd()"/>--%>
                            </ItemTemplate>
                        </asp:TemplateField>
                         <asp:TemplateField HeaderText="Status" HeaderStyle-VerticalAlign="Top" Visible="true" ItemStyle-VerticalAlign="Top" ItemStyle-HorizontalAlign="Left">
                        <ItemTemplate>
                            <asp:Label ID="lblstatus" runat="server" Text='<%# Eval ("status") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                        <asp:TemplateField HeaderText="Due Date" HeaderStyle-VerticalAlign = "Top" HeaderStyle-Width="8%" ItemStyle-VerticalAlign = "Top" ItemStyle-HorizontalAlign="Left" SortExpression = "pname" >
                            <ItemTemplate>
                                <asp:Label ID="lbltargetdate" runat="server" Text='<%# Eval ("enddt") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
        </div>   

        <%--Fully working grid inside modal--%>
        <div class="col-lg-12 col-md-12 col-sm-12 col-12">            
               <div id="dialog" style="display: none">
                    <asp:GridView ID="gridrevisehistroy" runat="server" AutoGenerateColumns="false" GridLines="Both" BorderStyle="Solid" CellPadding="2"
                        CellSpacing="2" Font-Size="13px" HeaderStyle-BackColor="#0b2d4d" HeaderStyle-ForeColor="White" CssClass="gridfont" AlternatingRowStyle-BackColor="White"
                        AllowSorting="true" Width="100%">
                        <HeaderStyle CssClass="gridheader" />
                        <Columns>
                            <asp:TemplateField HeaderText="S No" ControlStyle-Font-Bold="false" HeaderStyle-VerticalAlign="Top" ItemStyle-HorizontalAlign="Left" ItemStyle-VerticalAlign="Top">
                                <ItemTemplate>
                                    <%# Container.DataItemIndex+1 %>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Reason" ControlStyle-Font-Bold="false" HeaderStyle-VerticalAlign="Top" ItemStyle-HorizontalAlign="Left" ItemStyle-VerticalAlign="Top">
                                <ItemTemplate>
                                    <%# Eval("reason")%>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Old TimeLine" ControlStyle-Font-Bold="false" HeaderStyle-VerticalAlign="Top" ItemStyle-HorizontalAlign="Left" ItemStyle-VerticalAlign="Top">
                                <ItemTemplate>
                                    <%# Eval("oldduedate")%>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                </div>                
            </div>
        <%--End--%>
        </div>  

   

    <asp:HiddenField ID="hfpcode" runat="server" />
    <asp:HiddenField ID="hfc_deptnodal" runat="server" />
    <asp:HiddenField ID="hfc_pname" runat="server" />
       <input id="csrftoken" type="hidden" name="csrftoken" runat="server" />
  

</asp:Content>

