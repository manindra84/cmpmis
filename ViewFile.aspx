<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ViewFile.aspx.cs" Inherits="ViewFile" EnableEventValidation="true" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
     <div>
   <%if (FileType.ToLower() == ".jpg" || FileType.ToLower() == "jpeg")
      { %>
      <img src = "ViewFile.aspx" alt="No Image"/>
    <%} %>
    </div>
    </form>
</body>
</html>
