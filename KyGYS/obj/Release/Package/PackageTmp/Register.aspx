<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="KyGYS.Register" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
    <link href="style/default.css" rel="stylesheet" />
    <link href="jquery-easyui-1.4.2/themes/default/easyui2.css" rel="stylesheet" />
    <link href="jquery-easyui-1.4.2/themes/icon.css" rel="stylesheet" />
    <script src="jquery-easyui-1.4.2/jquery-1.4.2.min.js"></script>
    <script src="jquery-easyui-1.4.2/jQuery.easyui.js"></script>
    <script type="text/javascript">
        var pwd = $('#txtPwd');
        if (pwd.val() == '') {
            msgShow('系统提示', '请输入密码！', 'warning');
        }
        //弹出信息窗口 title:标题 msgString:提示信息 msgType:信息类型 [error,info,question,warning]
        function msgShow(title, msgString, msgType) {
            $.messager.alert(title, msgString, msgType);
        }
    </script>
</head>
<body>
   
    <form runat="server">
    <div style="margin: 180px 0;"></div>
    <div id="p" class="easyui-panels" style="width: 400px; height: 240px; margin: 0 auto; border:1px solid #99BBE8">
        <div style="padding: 60px 60px 20px 80px">
            <table cellpadding="5">
                <tr>
                    <td>用户名:</td>
                    <td>
                    <asp:TextBox runat="server" ID="txtUserName" ></asp:TextBox></td>
                </tr>
                <tr>
                    <td>密码:</td>
                    <td>
                         <asp:TextBox runat="server" ID="txtPwd"  TextMode="Password"></asp:TextBox></td>
                </tr>
                <tr>
                    <td>手机:</td>
                    <td>
                         <asp:TextBox runat="server" ID="txtTel" ></asp:TextBox></td>
                </tr>
            </table>
            <div style="text-align: center; padding: 5px">
                <asp:Button runat="server" ID="btnSave" OnClick="btnSave_Click" CssClass="easyui-linkbutton" Text="注册" Width="140" />
            </div>
        </div>
    </div>
        </form>
</body>
</html>
