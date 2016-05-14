<%@ Page Language="C#" AutoEventWireup="true" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <script src="js/jquery-1.8.2.min.js"></script>
    <link href="js/jquery.fancybox.css" rel="stylesheet" />
    <script src="js/jquery.fancybox.pack.js"></script>

    <script type="text/javascript">
        $(document).ready(function () {
            $(".v").fancybox({
                maxWidth: 800,
                maxHeight: 600,
                fitToView: false,
                width: '90%',
                height: '90%',
                autoSize: false,
                closeClick: false,
                openEffect: 'none',
                closeEffect: 'none'
            });
        });
    </script>
</head>
<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        StringBuilder sb = new StringBuilder();
        string ImageSession = Request.QueryString["ImageSession"];
        if (string.IsNullOrEmpty(ImageSession))
        {
            return;
        }
        sb.AppendFormat("<a class='v fancybox' rel='g' href=\"{0}\" target=\"_blank\"><img src='{1}' style=\"width:120px;height:80px;cursor:pointer;\"  /></a>", ImageSession, ImageSession);
        ltlImg.Text = sb.ToString();

    }
    
</script>
<body>
    <form id="form1" runat="server">
        <asp:Literal runat="server" ID="ltlImg">
        </asp:Literal>
    </form>
</body>
</html>
