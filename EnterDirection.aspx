<%@ Page Title="" Language="C#" MasterPageFile="~/Master_sitemaster.master" AutoEventWireup="true" CodeFile="EnterDirection.aspx.cs" Inherits="EnterDirection" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <script src="JS/jquery.min.js" type="text/javascript"></script>
    <script src="JS/jquery-ui.min.js" type="text/javascript"></script>
    <link href="JS/jquery-ui.css" rel="Stylesheet" type="text/css" />

    <script type="text/jscript">
        /*aarush_uat*/
        <%--$(function () {
            $('#<%=txtdateofissue.ClientID %>').datepicker(
                {
                    dateFormat: 'dd/mm/yy',
                    changeMonth: true,
                    changeYear: true,
                    yearRange: '1950:2100'
                });
        })--%>

        $(function () {
            $('#<%=txtboxtargetdate.ClientID %>').datepicker(
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
    <%--  <script type="text/jscript">
        $(function () {
            $('#<%=txtdirdt.ClientID %>').datepicker(
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

    </script>--%>

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

                <%--<div class="form-group" style="margin:0;">
                    <label id="lbl_otherconcerneddept" style="color: #0b2d4d;"><strong>Other Concerned Departments : </strong></label>
                    <label id="lblotherconcerneddept" runat="server" style="color: #0b2d4d;"></label>
                </div>--%>

                <%--aarush_uat--%>
                <%--<div class="form-group" style="margin:0;">
                    <label id="Label1_projstarteddate" style="color: #0b2d4d;"><strong>Started on : </strong></label>
                    <label id="Label1projstarteddate" runat="server" style="color: #0b2d4d;"></label>
                </div>--%>

                <div class="form-group" style="margin:0;">
                    <label id="lbl_ppcomdate" style="color: #0b2d4d;"><strong>Due Date : </strong></label>
                    <label id="lblppcomdate" runat="server" style="color: #0b2d4d;"></label>
                </div>
               


                 <br />
                <div class="form-group">
                    <fieldset class="border p-2 fieldset" >
                        <legend style="color: #0b2d4d;">List of Activity to be Done</legend>
                        <%if (dtfill != null && dtfill.Rows.Count > 0)
                            { %>
                        <table style='font-family: Verdana; font-size: 11pt;' width="100%" border="1" class="gridfont">
                            <tr style='font-weight: bold'>
                                <td style="text-align: left">S.No.
                                </td>
                                <td style="text-align: left">Dept. Name
                                </td>
                                <td style="text-align: left">Sub Project Name
                                </td>
                                <td style="text-align: left">Details of activity to be Done
                                </td>
                                <td style="text-align: left">Remarks
                                </td>
                                <td style="text-align: left">Earlier Timeline
                                </td>
                                <td style="text-align: left">Due Date
                                </td>
                                <td style="text-align: left">
                                    <% if (Convert.ToInt32(Session["usertype"].ToString()) == 13)
                                        { %>
                                        Delete Task
                                        <%  }
                                            else
                                            {%>
                                   Directions
                                    <%}%>
                                </td>
                            </tr>
                            <tbody style="text-align: left">
                                <%foreach (var group in deptModelList.GroupBy(i => i.subprojid))
                                    {
                                        var items = group.ToList(); %>
                                <tr style="text-align: left">

                                    <td style="text-align: left">
                                        <%=items[0].serial_number%>
                                    </td>
                                    <td style="text-align: left">
                                        <%=items[0].deptname%>
                                    </td>

                                    <td rowspan="<%=items.Count%>" style="text-align: left">
                                        <%=items[0].subprojname%>
                                    </td>
                                    <td style="text-align: left">
                                        <%=items[0].taskname%>
                                    </td>
                                    <td style="text-align: left">
                                        <%=items[0].activityremarks%>
                                    </td>
                                    <td style="text-align: left">
                                        <%=items[0].earliertimeline%>
                                    </td>
                                    <td style="text-align: left">
                                        <%=items[0].enddt%>
                                    </td>
                                    <td style="width: 120px; text-align:left;">
                                        <%if (Convert.ToInt32(Session["usertype"].ToString()) != 13 && viewonly.ToString() == "add")
                                            { %>
                                       
                                        <a href="EnterCMODirection.aspx?pcode=<%= MD5Util.Encrypt(items[0].pcode, true) + "&taskid=" + MD5Util.Encrypt(items[0].taskid, true) + "&flag=" + MD5Util.Encrypt("add", true)%>">Add</a>
                                         <a href="EnterCMODirection.aspx?pcode=<%= MD5Util.Encrypt(items[0].pcode, true) + "&taskid=" + MD5Util.Encrypt(items[0].taskid, true) + "&cmview=" + MD5Util.Encrypt("cmview", true) + "&flag=" + MD5Util.Encrypt("view", true)%>">View</a>

                                        <%  }%>

                                        <%if (Convert.ToInt32(Session["usertype"].ToString()) != 13 && viewonly.ToString() == "view")
                                            { %>
                                        <a href="EnterCMODirection.aspx?pcode=<%= MD5Util.Encrypt(items[0].pcode, true) + "&taskid=" + MD5Util.Encrypt(items[0].taskid, true) + "&cmview=" + MD5Util.Encrypt("cmview", true) + "&flag=" + MD5Util.Encrypt("view", true)%>">View</a>
                                       <%  }%>

                                          <%if (Convert.ToInt32(Session["usertype"].ToString()) != 13 && viewonly.ToString() == "noview")
                                            { %>
                                     <%--   <a href="EnterCMODirection.aspx?pcode=<%= MD5Util.Encrypt(items[0].pcode, true) + "&taskid=" + MD5Util.Encrypt(items[0].taskid, true) + "&flag=" + MD5Util.Encrypt("add", true)%>">Add</a>--%>
                                         <a href="EnterCMODirection.aspx?pcode=<%= MD5Util.Encrypt(items[0].pcode, true) + "&taskid=" + MD5Util.Encrypt(items[0].taskid, true) + "&cmview=" + MD5Util.Encrypt("cmview", true) + "&flag=" + MD5Util.Encrypt("view", true)%>">View</a>

                                        <%  }%>
                                    
                                        <% else if (Convert.ToInt32(Session["usertype"].ToString()) == 13)
                                            { %>
                                       <a href="EnterDirection.aspx?pcode=<%= MD5Util.Encrypt(items[0].pcode, true)+ "&taskid=" + MD5Util.Encrypt(items[0].taskid, true)+ "&view=" + MD5Util.Encrypt("deletetask", true) %>" onclick="return confirm('Are you sure you want to delete Task details ,All the Task Details and CM Directions will be deleted for this Task and cannot be retrieved?');">Delete Task</a>
                                        <%  }%>  
                                           
                                    </td>

                                </tr>
                                <%for (int index = 1; index < items.Count; index++)
                                    {
                                %>
                                <tr style="text-align: left">
                                    <td style="text-align: left">
                                        <%=items[index].serial_number%>
                                    </td>
                                    <td style="text-align: left">
                                        <%=items[index].deptname%>
                                    </td>

                                    <td style="text-align: left">
                                        <%=items[index].taskname%>
                                    </td>
                                    <td style="text-align: left">
                                        <%=items[index].activityremarks%>
                                    </td>
                                    <td style="text-align: left">
                                        <%=items[index].earliertimeline%>
                                    </td>
                                    <td style="text-align: left">
                                        <%=items[index].enddt%>
                                    </td>
                                    <td style="width: 120px; text-align:left;">
                                        <%if (Convert.ToInt32(Session["usertype"].ToString()) != 13 && viewonly.ToString() == "add")
                                            { %>
                                        <a href="EnterCMODirection.aspx?pcode=<%= MD5Util.Encrypt(items[index].pcode, true) + "&taskid=" + MD5Util.Encrypt(items[index].taskid, true) + "&flag=" + MD5Util.Encrypt("add", true)%>">Add</a>
                                        <a href="EnterCMODirection.aspx?pcode=<%= MD5Util.Encrypt(items[index].pcode, true) + "&taskid=" + MD5Util.Encrypt(items[index].taskid, true) + "&cmview=" + MD5Util.Encrypt("cmview", true) + "&flag=" + MD5Util.Encrypt("view", true)%>">View</a>
                                         <%  }%>

                                           <%if (Convert.ToInt32(Session["usertype"].ToString()) != 13 && viewonly.ToString() == "view")
                                            { %>
                                        <a href="EnterCMODirection.aspx?pcode=<%= MD5Util.Encrypt(items[index].pcode, true) + "&taskid=" + MD5Util.Encrypt(items[index].taskid, true) + "&cmview=" + MD5Util.Encrypt("cmview", true) + "&flag=" + MD5Util.Encrypt("view", true)%>">View</a>
                                       <%  }%>

                                       
                                         <%if (Convert.ToInt32(Session["usertype"].ToString()) != 13 && viewonly.ToString() == "noview")
                                            { %>
                                     <%--   <a href="EnterCMODirection.aspx?pcode=<%= MD5Util.Encrypt(items[index].pcode, true) + "&taskid=" + MD5Util.Encrypt(items[index].taskid, true) + "&flag=" + MD5Util.Encrypt("add", true)%>">Add</a>--%>
                                         <a href="EnterCMODirection.aspx?pcode=<%= MD5Util.Encrypt(items[index].pcode, true) + "&taskid=" + MD5Util.Encrypt(items[index].taskid, true) + "&cmview=" + MD5Util.Encrypt("cmview", true) + "&flag=" + MD5Util.Encrypt("view", true)%>">View</a>

                                        <%  }%>
                                    

                                        <% else if (Convert.ToInt32(Session["usertype"].ToString()) == 13)
                                        { %>
                                         <a href="EnterDirection.aspx?pcode=<%= MD5Util.Encrypt(items[index].pcode, true)+ "&taskid=" + MD5Util.Encrypt(items[index].taskid, true)+ "&view=" + MD5Util.Encrypt("deletetask", true) %>"  onclick="return confirm('Are you sure you want to delete Task details ,All the Task Details and CM Directions will be deleted for this Task and cannot be retrieved?');">Delete Task</a>
                                        <%  }%>  
                                           
                                    </td>
                                </tr>
                                <%} %>
                                <%
                                 }%>
                            </tbody>
                        </table>
                        <%} %>
                    </fieldset>
                </div>
                    <br />
                

                 <div class="form-group" id="divsubprojname" runat="server" visible="false">
                    <label id="lbl_subprojname" style="color: #0b2d4d;"><strong>Sub Project</strong></label>
                   <asp:DropDownList runat="server" ID="ddlsubprojname" class="form-control"></asp:DropDownList>
                    <asp:RequiredFieldValidator ID="rfvddlsubprojname" runat="server" ControlToValidate="ddlsubprojname" 
                        Display="none" ErrorMessage="Please Select Sub Project" ValidationGroup="1" InitialValue="0"></asp:RequiredFieldValidator>
                </div>


                <div class="form-group" id="tr1" runat="server" visible="true">
                    <label id="lbl_activitydetails" style="color: #0b2d4d;"><strong>Details of the Activity to be Done</strong></label>
                    <asp:TextBox ID="txtdirection" Width="100%" runat="server" class="form-control" placeholder="Details of the Activity to be Done" TextMode="MultiLine" MaxLength="500"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="Rfdecision" runat="server" ControlToValidate="txtdirection" Display="none" ErrorMessage="Please Enter Details of the Activity to be Done" ValidationGroup="1"></asp:RequiredFieldValidator>
                </div>

                <div class="form-group" id="tr2" runat="server" visible="true">
                    <label id="lbl_deptactivity" style="color: #0b2d4d;"><strong>Department for this Activity</strong></label>
                    <asp:DropDownList ID="ddldeptnodal" runat="server" class="form-control"></asp:DropDownList>
                    <asp:RequiredFieldValidator ID="rfvddldeptnodal" runat="server" ControlToValidate="ddldeptnodal" Display="none" ErrorMessage="Please Select Department" ValidationGroup="1"></asp:RequiredFieldValidator>
                </div>

                <%--aarush_uat--%>
                <%--<div class="form-group" id="tr3" runat="server" visible="true">
                    <label id="lbl_startdt" style="color: #0b2d4d;"><strong>Start Date of the Activity</strong></label>
                    <asp:TextBox ID="txtdateofissue" Width="100%" runat="server" class="form-control"></asp:TextBox>
                    <asp:RegularExpressionValidator ID="rfstartdtae" runat="server" ControlToValidate="txtdateofissue" ErrorMessage="Start Date should be in DD/MM/YYYY "
                        ValidationExpression="(0[1-9]|[12][0-9]|3[01])[- /.](0[1-9]|1[012])[- /.](19|20)\d\d" ValidationGroup="1" Display="None"></asp:RegularExpressionValidator>
                </div>--%>

                <div class="form-group" id="tr4" runat="server" visible="true">
                    <label id="lbl_enddt" style="color: #0b2d4d;"><strong>Activity Completion Date</strong></label>
                    <asp:TextBox ID="txtboxtargetdate" Width="100%" runat="server" class="form-control"></asp:TextBox>
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="txtboxtargetdate"
                        ErrorMessage="Start Date should be in DD/MM/YYYY " ValidationExpression="(0[1-9]|[12][0-9]|3[01])[- /.](0[1-9]|1[012])[- /.](19|20)\d\d"
                        ValidationGroup="1" Display="None"></asp:RegularExpressionValidator>
                </div>

                
                <div class="form-group" id="tr5" runat="server" visible="true">
                    <label id="lbl_remarks" style="color: #0b2d4d;"><strong>Remarks</strong></label>
                    <asp:TextBox ID="txtactivityremarks" Width="100%" runat="server" class="form-control" placeholder="Activity Remarks" TextMode="MultiLine" MaxLength="500"></asp:TextBox>
<%--                    <asp:RequiredFieldValidator ID="rfvremarks" runat="server" ControlToValidate="txtactivityremarks" Display="none" 
                        ErrorMessage="Please Enter Remarks" ValidationGroup="1"></asp:RequiredFieldValidator>--%>
                      <asp:RegularExpressionValidator ID="reg_txtactivity" runat="server" ControlToValidate="txtactivityremarks"
                                ValidationExpression="^[a-zA-Z0-9 _,/]{0,500}$" ErrorMessage="Enter valid character upto 500 Length"
                                SetFocusOnError="true" ValidationGroup="1" ForeColor="Blue" />
                </div>

                <div class="form-group" runat="server" id="tr6" visible="true">
                    <center>
                        <asp:Button ID="btnsbmt" runat="server" Text="Submit" OnClick="btnsbmt_Click" class="btn btn-primary" ValidationGroup="1" />
                    </center>
                </div>

            </div>
        </div>
    </div>
    <asp:ValidationSummary ID="ValidationSummary1" runat="server" ValidationGroup="1"
        ShowSummary="false" ShowMessageBox="true" />

    <asp:HiddenField ID="hfpcode" runat="server" />
        <asp:HiddenField ID="hftaskid" runat="server" />

    <input id="csrftoken" type="hidden" name="csrftoken" runat="server" />

</asp:Content>

