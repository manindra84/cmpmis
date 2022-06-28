<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="ErrorPage.aspx.cs" Inherits="lgcmrelief_ErrorPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <section class="headerTop ">
    <div class="container ">
    <div class="content">
        <div class="row">
            <div class="col-lg-12 col-md-12 col-sm-12 col-12">
                <h4 class="clr-blue">Some Error Occured Kindly Try Again</h4>
                
<%if(!string.IsNullOrEmpty(Message)){ %>
 <h5 class="clr-blue"><%=Message %></h5>
<%} %>
        </div>
    </div>

    </div>
</div>
</section>
</asp:Content>
