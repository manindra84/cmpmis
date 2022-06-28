<%@ Page Title="" Language="C#" MasterPageFile="~/Master_sitemaster.master" AutoEventWireup="true" CodeFile="CMOViewAll.aspx.cs" Inherits="CMOViewAll" %>


<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

    <%--Fully working grid view inside modal--%>
<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js"></script>
<script src="http://ajax.aspnetcdn.com/ajax/jquery.ui/1.8.9/jquery-ui.js" type="text/javascript"></script>
<link href="http://ajax.aspnetcdn.com/ajax/jquery.ui/1.8.9/themes/start/jquery-ui.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript">
    $(function () {
        $("[id*=btn_showhist]").click(function () {
            ShowPopup();
            return false;
        });
    });
    function ShowPopup() {
        $("#dialog").dialog({
            title: "Due Date Revise History",
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
           <% FillGridReviseHistory(); %>
        });               
    }
</script>

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
        <br />
        <div class="col-lg-12 col-md-12 col-12">
            <%--------------------Project Details--------------------%>
            <div class="form-group" style="align-content:flex-end; margin:0;">                 
                <div style="background-color:lightslategrey;width:120px;border-radius:5px;padding:2px 2px 2px 6px;">
                      <strong><strong><asp:Label runat="server" ID="lblheader" Text="Project Details" style="font-size: 13px; color: #0b2d4d;"></asp:Label></strong></strong>
                  </div> 
            </div>
              <div class="form-group" style="margin:0;">
                <asp:Label ID="lblprojectname" runat="server" Font-Size="13px" Font-Bold="true"></asp:Label>
            </div>

             <div class="form-group" style="margin:0px;">               
                 <strong><asp:Label ID="lbl_nodaldept" runat="server" Text="Nodal Department:" Font-Size="13px"></asp:Label></strong>                
                 <asp:Label ID="lblnodaldept" runat="server" Font-Size="13px"></asp:Label>                 
            </div>
            
             <div class="form-group" runat="server" style="margin-bottom:5px;">               
                 <strong><asp:Label ID="lbl_duedate" runat="server" Text="Due Date:" Font-Size="13px"></asp:Label></strong>  
                <asp:Label ID="lblduedate" runat="server" Font-Size="13px"></asp:Label>
            </div>

              <div class="form-group" runat="server"  visible="false">                
                  <strong><asp:Label ID="lbl_othrconcdept" runat="server" Text="Other Concerned Departments:" Font-Size="13px"></asp:Label></strong> 
                <asp:Label ID="lblotherconcerneddept" runat="server" Font-Size="13px"></asp:Label>
            </div>  
        </div>
                    <%--------------------Project Details End--------------------%>     
                    <%--------------------Activity Details--------------------%>   
        <div class="col-lg-12 col-md-12 col-12">
            <div class="form-group" style="margin-bottom: -3px;">
                <div style="background-color: lightslategrey; width: 120px; border-radius: 5px; padding: 2px 2px 2px 6px;">
                    <strong>
                        <asp:Label runat="server" ID="Label1" Text="Activity Details" Style="margin: auto; font-size: 13px; color: #0b2d4d;"></asp:Label>
                    </strong>
                </div>
            </div>
            <div class="form-group" style="margin-bottom: 0px;">                
                <strong><asp:Label runat="server" ID="inputactivityname" Text="Activity Name:" Font-Size="13px"></asp:Label></strong>                
                <asp:Label ID="lblactivityname" runat="server" Font-Size="13px"></asp:Label>
            </div>

            <div class="form-group" style="margin-bottom: -7px;">                
                <strong><asp:Label runat="server" ID="inputduedate" Text="Due Date:" Font-Size="13px"></asp:Label></strong>
                <asp:Label ID="lblactivityduedate" runat="server" Font-Size="13px"></asp:Label>
                &nbsp;&nbsp;&nbsp;
                <asp:Button ID="btn_showhist" runat="server" Visible="true" Text="Show Revise History"
                    Style="padding: 0px; margin: 0px;" Font-Size="13px" class="btn btn-link" OnClick="btn_showhist_Click" />
            </div>
             <%--------------------Activity Details End--------------------%>  
        
            </div>
              <br />
        <div class="col-lg-12 col-md-12 col-12" runat="server" id="tractions" visible="false">            
              <asp:Label runat="server" ID="Label2" Text="Progress in the Project" style="margin: auto; font-size: 13px; color: #0b2d4d;"></asp:Label>
             <div class="form-group" style="margin-bottom:-7px;">
                 <asp:Label runat="server" ID="lblactions"  Visible="false" style="font-size: 13px; color: #A52A2A;"></asp:Label>
            </div>
        </div>
        <br />
         <div class="col-lg-6 col-md-6 col-6;" >
             <asp:GridView ID="Gridviewactions" runat="server"  AutoGenerateColumns="false" GridLines="Both" BorderStyle="Solid" 
                 EnableTheming="False" CellPadding="2" Font-Size="13px"
                CellSpacing="2" HeaderStyle-BackColor="#0b2d4d" HeaderStyle-ForeColor="White" CssClass="gridfont" AlternatingRowStyle-BackColor="White"
                 HorizontalAlign="Center"
                AllowSorting="true" Visible="false" Width="100%">
                <HeaderStyle CssClass="gridheader" />
                <Columns>
                    <asp:TemplateField HeaderText="Sl No:" HeaderStyle-VerticalAlign="Top" ItemStyle-HorizontalAlign="Left" ItemStyle-VerticalAlign="Top">
                        <ItemTemplate>
                            <%# Container.DataItemIndex+1 %>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Work Details in the Project" HeaderStyle-VerticalAlign="Top" ItemStyle-HorizontalAlign="Left" ItemStyle-VerticalAlign="Top">
                        <ItemTemplate>
                            <%# Eval("actiontaken")%>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Action Date" HeaderStyle-VerticalAlign="Top" ItemStyle-HorizontalAlign="Left" ItemStyle-VerticalAlign="Top">
                        <ItemTemplate>
                            <%# Eval("actiondt")%>
                        </ItemTemplate>
                    </asp:TemplateField>               
                </Columns>
            </asp:GridView>
        </div>   
        <br />
          <div class="row; col-lg-6 col-md-6 col-6" runat="server" id="trcmview" visible="false">

              <div  runat="server" visible="false" id="trview12" >
                  <asp:Label runat="server" ID="Label3" Text="Details of the Directions in the Project" style="margin: auto; font-size: 13px; color: #0b2d4d;"></asp:Label>
              </div>
                <div class="form-group" style="margin:0;">
                 <asp:Label runat="server" ID="lblformessageactions"  Visible="false" style="font-size: 13px; color: #A52A2A;"></asp:Label>
            </div>
              <br />
              <div >
                   <asp:GridView ID="Gridcmremarks" runat="server"  AutoGenerateColumns="false" GridLines="Both" BorderStyle="Solid" EnableTheming="False" CellPadding="2"
                    CellSpacing="2" Font-Size="13px" HeaderStyle-BackColor="#0b2d4d" HeaderStyle-ForeColor="White" CssClass="gridfont" AlternatingRowStyle-BackColor="White"
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

        </div>


           <div class="col-lg-12 col-md-12 col-sm-12 col-12">
                <%--Fully working gridview inside modal--%>                
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
                                    <%# Eval("oldtimeline")%>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                </div>
                <%--End--%>
            </div>

        </div>
                    
           <asp:HiddenField ID="hftaskid" runat="server" />
    


</asp:Content>

