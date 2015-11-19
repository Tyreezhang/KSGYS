<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="print.aspx.cs" Inherits="KyGYS.Data.print" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <script src="../js/LodopFuncs.js"></script>
    <%--<script type="text/javascript">
        var LODOP;
        function prn1_preview() {
            CreateOneFormPage();
            LODOP.PREVIEW();
        };
        function CreateOneFormPage() {

            LODOP = getLodop(document.getElementById('LODOP_OB'), document.getElementById('LODOP_EM'));
            LODOP.PRINT_INIT("打印控件功能演示_Lodop功能_表单一");
            LODOP.SET_PRINT_PAGESIZE(3, 2200, 600, "A4");
            LODOP.SET_PRINT_STYLE("FontSize", 18);
            LODOP.SET_PRINT_STYLE("Bold", 1);
            LODOP.ADD_PRINT_TEXT(20, 320, 260, 39, "发货单");
            LODOP.ADD_PRINT_HTM(50, 10, 400, 900, document.getElementById("printdiv").innerHTML);
            LODOP.SET_SHOW_MODE("NP_NO_RESULT", true);
            //LODOP.PRINT_INIT("打印任务名");               //首先一个初始化语句 
            //LODOP.ADD_PRINT_TEXT(0, 0, 100, 20, "文本内容一");//然后多个ADD语句及SET语句 
            //ADD_PRINT_TABLE
            //LODOP.PRINT();
        }
    </script>--%>
</head>
<body>
<%--    <object id="”LODOP_OB”" classid="”clsid:2105C259-1E0C-4534-8141-A753534CB4CA”" width="0" height="0">
        <embed id="LODOP_EM" type="application/x-print-lodop" width="0" height="0" pluginspage="../js/install_lodop32.exe"></embed>
    </object>--%>
    <form id="form1" runat="server">
       <%-- <a href="javascript:prn1_preview()">打印预览</a>,可<a href="javascript:prn1_print()">直接打印</a>也可<a href="javascript:prn1_printA()">选择打印机</a>打印。<br />--%>
        <%--<div id="printdiv" style="width: 780px; height: 400px;">
            <span style="float: right">NO:1122121</span>
            <table style="width: 780px; padding: 4px;" border="1" cellspacing="0" cellpadding="0">
                <tr>
                    <td style="width: 70px;">客户名称</td>
                    <td>
                        <label  id="lblCusName"></label></td>
                    <td>客户id</td>
                    <td colspan="2"><label  id="lblCusid"></label></td>
                    <td style="width: 70px;">出货时间</td><td colspan="3"><label  id="lblSendtime"></label></td>
                </tr>
                <tr>
                    <td style="width: 70px;">订单编号</td><td colspan="4"></td><td>店铺</td><td colspan="3"></td>
                </tr>
                <tr>
                    <td style="width: 70px;">联系电话</td><td colspan="4"></td><td style="width: 70px;">公司名称</td><td colspan="3"></td>
                </tr>
                <tr>
                    <td style="width: 70px;">收货地址</td><td colspan="4"></td><td style="width: 70px;">公司地址</td><td colspan="3"></td>
                </tr>
                <tr>
                    <td style="width: 70px;">物流信息</td><td colspan="4"></td><td style="width: 70px;">公司电话</td><td colspan="3"></td>
                </tr>
                <tr>
                    <td style="width: 70px;">序号</td><td style="width: 100px;">产品型号</td><td style="width: 100px;">产品名称</td><td style="width: 100px;">产品规格</td><td style="width: 100px;">家具结构</td><td style="width: 70px;">皮布号</td><td style="width: 100px;">数量</td><td style="width: 100px;">包件数</td><td style="width: 100px;">备注</td>
                </tr>

                <tr>
                    <td style="width: 70px;"></td><td style="width: 100px;"></td><td style="width: 100px;"></td><td style="width: 100px;"></td><td style="width: 100px;"></td><td style="width: 70px;">合计</td><td style="width: 100px;"><label  id="lblNum"></label></td><td style="width: 100px;"><label  id="lblPackNum"></label></td><td style="width: 100px;"></td>
                </tr>
                <tr>
                    <td style="width: 70px;">客服</td><td style="width: 100px;" colspan="2"><label  id="lblCustomer"></label></td><td style="width: 100px;">经办人</td><td style="width: 100px;" colspan="3"><label  id="lblTransactor"></label></td><td style="width: 100px;">收货人</td><td style="width: 100px;"><label  id="lblReceiver"></label></td>
                </tr>
                <tr>
                    <td style="width: 70px;">备注</td><td style="width: 70px;" colspan="8"><label  id="lblRemark"></label></td>
                </tr>
            </table>
        </div>--%>
    </form>
</body>
</html>
