<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="UnSendGoodsList.aspx.cs" Inherits="KyGYS.UnSendGoodsList" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <link href="jquery-easyui-1.4.2/themes/icon.css" rel="stylesheet" />
    <link href="jquery-easyui-1.4.2/demo/demo.css" rel="stylesheet" />
    <%--    <script type="text/javascript" src="http://code.jquery.com/jquery-1.7.1.min.js"></script>--%>
    <%--   <script src="jquery-easyui-1.4.2/jquery-1.4.2.min.js"></script>--%>
    <script src="js/jquery-1.7.min.js"></script>
    <script src="jquery-easyui-1.4.2/jQuery.easyui.min.js"></script>
    <script src="jquery-easyui-1.4.2/locale/easyui-lang-zh_CN.js"></script>
    <link href="jquery-easyui-1.4.2/themes/metro/easyui.css" rel="stylesheet" />
    <script src="js/tip.js"></script>
    <script src="js/LodopFuncs.js"></script>
    <%--    <script type="text/javascript">
        var LODOP;
        function prn1_preview() {
            CreateOneFormPage();
            LODOP.PREVIEW();
        };
        function CreateOneFormPage() {

            LODOP = getLodop(document.getElementById('LODOP_OB'), document.getElementById('LODOP_EM'));
            //LODOP.PRINT_INIT("打印");
            LODOP.SET_PRINT_PAGESIZE(3, 2200, 600, "A4");
            LODOP.SET_PRINT_STYLE("FontSize", 18);
            LODOP.SET_PRINT_STYLE("Bold", 1);
            //LODOP.ADD_PRINT_TEXT(20, 320, 260, 39, "");
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
    <object id="”LODOP_OB”" classid="”clsid:2105C259-1E0C-4534-8141-A753534CB4CA”" width="0" height="0">
        <embed id="LODOP_EM" type="application/x-print-lodop" width="0" height="0" pluginspage="install_lodop32.exe"></embed>
    </object>
    <form runat="server">
        <div id="p" class="easyui-panel" style="width: 100%; height: 38px; padding: 4px;">
            <asp:Button runat="server" CssClass="easyui-linkbutton" ID="btnRef" Text="查  询" OnClick="btnRef_Click" Style="width: 80px; height: 28px;"></asp:Button>
            买家：<asp:TextBox runat="server" ID="txtBuyerNick"></asp:TextBox>
            &nbsp;
            <%--            订单来源:
            <asp:TextBox runat="server" ID="txtOrderFrom"></asp:TextBox>&nbsp;--%>
                        店铺:
            <asp:TextBox runat="server" ID="txtSellerNick"></asp:TextBox>&nbsp;
             收货人:
            <asp:TextBox runat="server" ID="txtReceiverName"></asp:TextBox>&nbsp;
             手机号:
            <asp:TextBox runat="server" ID="txtReceiverMobile"></asp:TextBox>&nbsp;
              地址:
            <asp:TextBox runat="server" ID="txtReceiverAddress"></asp:TextBox>&nbsp;

        </div>
        <input type="hidden" id="txtBatchId" />
        <div style="margin: 6px 0;"></div>
        <table title=""  id="tt" rownumbers="true" pagination="true" style="width: 100%; height: 309px"
            data-options="singleSelect:false,collapsible:true,url:'/data/getUnSendList.aspx',onSelect:SelectRow,toolbar:toolbar,method:'get',remoteSort:false,multiSort:true,pageSize:1,pageList:[10,20,50,100,200]">
            <thead>
                <tr>
                    <th data-options="field:'SellerNick',width:120,sortable:true">店铺</th>
                    <th data-options="field:'BuyerNick',width:118,sortable:true">买家</th>
                    <th data-options="field:'OrderTime',width:143,sortable:true" formatter="datestr">下单时间</th>
                    <th data-options="field:'ProDelTime',width:143,sortable:true" formatter="datestr">交货时间</th>
                    <th data-options="field:'BatchItemCount',width:55, align: 'center', sortable:true">商品总数</th>
                    <th data-options="field:'ReceiverName',width:120,sortable:true">收货人</th>
                    <th data-options="field:'Reserved1',width:150,align: 'center',sortable:true"  formatter="formatprint">是否打印</th>
                    <th data-options="field:'Reserved2',width:200,sortable:true">收货地址</th>

                </tr>
            </thead>
        </table>

        <div style="margin: 6px 0;"></div>
        <table title="" class="easyui-datagrid" id="orderlist" rownumbers="true" style="width: 100%; height: 150px"
            data-options="singleSelect:true,collapsible:true,remoteSort:false,multiSort:true">
            <thead>
                <tr>
                    <th data-options="field:'ItemName',width:200,sortable:true" title="admin">商品名称</th>
                    <th data-options="field:'SkuProperties',width:190,sortable:true">规格名称</th>
                    <th data-options="field:'OuterIid',width:200,align:'left',sortable:true">商品编码</th>
                    <th data-options="field:'OuterSkuId',width:200,align:'left',sortable:true">规格编码</th>
                    <th data-options="field:'Num',width:60,sortable:true">数量</th>
                    <th data-options="field:'PackageCount',width:60,sortable:true">包件数</th>
                    <th data-options="field:'BusVolume',width:80,align:'left',sortable:true">体积</th>
                    <th data-options="field:'Size',width:80,align:'left',sortable:true">尺寸</th>
                    <th data-options="field:'Color',width:120,align:'left', sortable:true">颜色</th>
                </tr>
            </thead>
        </table>
    </form>
    <script>
        function formatprint(val, row) {
            if (val == 1) {
                return '<span style="color:red;">' + '是' + '</span>';
            } else {
                return '否';
            }
        }
    </script>
    <script type="text/javascript">
        $(function () {
            openwid();
            $('#btnsendok').click(function () {
                var logisno = $('#txtLogisNo').val();
                var logisname = $('#txtLogisName').val();
                var logiscost = $('#txtLogisCost').val();
                var logismobile = $('#txtLogisMobile').val();

                //if (logisno == '') {
                //    msgShow('系统提示', '请输入物流单号！', 'warning');
                //    return false;
                //}
                //if (logisname == '') {
                //    msgShow('系统提示', '请输入物流公司！', 'warning');
                //    return false;
                //}

                //if (logiscost == '') {
                //    msgShow('系统提示', '请输入实际运费', 'warning');
                //    return false;
                //}
                var guid = "";
                close();
                $.messager.confirm("系统提示", "您确定要发货吗？", function (data) {
                    if (!data) {
                        return false;
                    }
                    else {
                        guid = $('#txtbchGuid').val();
                        if (guid == null) {
                            return false;
                        }
                        $.ajax({
                            url: "/data/getUnSendList.aspx/SendGoods",
                            type: "POST",
                            data: "{'guids':'" + guid + "','logisNo':'" + logisno + "','logisName':'" + logisname + "','logisCost':'" + logiscost + "','logisMobile':'" + logismobile + "'}",
                            dataType: 'json',
                            contentType: "application/json; charset=utf-8",
                            error: function (err) {
                                msgShow('系统提示', '发货失败！', 'error');
                            },
                            success: function (data) {
                                if (data.d == "登陆超时") {
                                    alert("登录超时,请重新登录!");
                                    if (window == top) { window.location.href = '../Login.aspx'; } else { top.location.href = '../Login.aspx'; }
                                }
                                else {
                                    msgShow('系统提示', data.d, 'info');
                                    $('#tt').datagrid('reload');
                                    $('#orderlist').datagrid('loadData', { total: 0, rows: [] });
                                }
                            }
                        });
                        return false;
                    }
                });
            })

            $('#btncancel').click(function () {
                $('#txtLogisNo').val("");
                $('#txtLogisName').val("");
                $('#txtLogisCost').val("");
                $('#txtLogisMobile').val("");
                $('#txtbchGuid').val("");
                close();
            })
            $('#tt').datagrid({
                //singleSelect: (this.value == 0),
                onLoadSuccess: function (data) {
                    $('#tt').datagrid('doCellTip', { cls: { 'background-color': '#E6E6E6' }, delay: 300 });
                },
                onLoadError: function () {
                    alert("登录超时,请重新登录！");
                    if (window == top) { window.location.href = '../Login.aspx'; } else { top.location.href = '../Login.aspx'; }
                    return false;
                },
                loadFilter: function (data) {
                    if (data.IsError) {
                        alert("登录超时,请重新登录！");
                        if (window == top) { window.location.href = '../Login.aspx'; } else { top.location.href = '../Login.aspx'; }
                        return {
                            total: 0,
                            rows: []
                        };
                    } else {
                        return data;
                    }
                }
            });
            //$('#tt').datagrid({
            //    columns: [[
            //    //{ field: 'ck', checkbox: true },
            //    //{ field: 'OrderFrom', title: '订单来源', width: '120', sortable: true },
            //                    { field: 'SellerNick', title: '店铺', width: '120', sortable: true },
            //    { field: 'BuyerNick', title: '买家', width: '118', sortable: true },
            //       {
            //           field: 'OrderTime', width: '143', sortable: true, title: '下单时间',
            //           formatter: function (value, row, index) {
            //               if (typeof (value) != "undefined" && value != null) {
            //                   value = value.replace(/\T/g, ' ');
            //                   if (value.lastIndexOf('.') > 0) {
            //                       value = value.substring(0, value.lastIndexOf('.'));
            //                   }
            //               }
            //               //  var unixTimestamp = new Date(value).Format("yyyy-MM-dd hh:mm:ss");
            //               var unixTimestamp = value;
            //               return unixTimestamp;
            //           }
            //       },
            //       {
            //           field: 'ProDelTime', width: '143', sortable: true, title: '交货时间',
            //           formatter: function (value, row, index) {
            //               if (typeof (value) != "undefined" && value != null) {
            //                   value = value.replace(/\T/g, ' ');
            //                   if (value.lastIndexOf('.') > 0) {
            //                       value = value.substring(0, value.lastIndexOf('.'));
            //                   }
            //               }
            //               //  var unixTimestamp = new Date(value).Format("yyyy-MM-dd hh:mm:ss");
            //               var unixTimestamp = value;
            //               return unixTimestamp;
            //           }
            //       },
            //       { field: 'Num', title: '商品总数', width: '55', align: 'right', sortable: true },
            //       { field: 'ReceiverName', title: '收货人', width: '120', sortable: true },
            //       //{ field: 'ReceiverMobile', title: '手机', width: '120', sortable: true },
            //       { field: 'Reserved1', title: '是否打印', width: '80', formatter: formatprint, align: 'center', sortable: true },
            //    { field: 'Reserved2', title: '收货地址', width: '400', sortable: true }
            //    ]],
            //});
        });


        function datestr(value, row, index) {
            if (typeof (value) != "undefined" && value != null) {
                value = value.replace(/\T/g, ' ');
                if (value.lastIndexOf('.') > 0) {
                    value = value.substring(0, value.lastIndexOf('.'));
                }
            }
            //  var unixTimestamp = new Date(value).Format("yyyy-MM-dd hh:mm:ss");
            var unixTimestamp = value;
            return unixTimestamp;
        };
        //设置登录窗口
        function openwid() {
            $('#logis').window({
                title: '填写物流信息',
                width: 350,
                modal: true,
                shadow: true,
                closed: true,
                height: 220,
                onBeforeClose: function () {
                    $('#txtLogisNo').val("");
                    $('#txtLogisName').val("");
                    $('#txtLogisCost').val("");
                    $('#txtLogisMobile').val("");
                },
                resizable: false
            });
        }
        //关闭登录窗口
        function close() {
            $('#logis').window('close');
        }
        // 对Date的扩展，将 Date 转化为指定格式的String
        // 月(M)、日(d)、小时(h)、分(m)、秒(s)、季度(q) 可以用 1-2 个占位符， 
        // 年(y)可以用 1-4 个占位符，毫秒(S)只能用 1 个占位符(是 1-3 位的数字) 
        // 例子： 
        // (new Date()).Format("yyyy-MM-dd hh:mm:ss.S") ==> 2006-07-02 08:09:04.423 
        // (new Date()).Format("yyyy-M-d h:m:s.S")      ==> 2006-7-2 8:9:4.18 
        Date.prototype.Format = function (fmt) { //author: meizz 
            var o = {
                "M+": this.getMonth() + 1, //月份 
                "d+": this.getDate(), //日 
                "h+": this.getHours(), //小时 
                "m+": this.getMinutes(), //分 
                "s+": this.getSeconds(), //秒 
                "q+": Math.floor((this.getMonth() + 3) / 3), //季度 
                "S": this.getMilliseconds() //毫秒 
            };
            if (/(y+)/.test(fmt)) fmt = fmt.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));
            for (var k in o)
                if (new RegExp("(" + k + ")").test(fmt)) fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : (("00" + o[k]).substr(("" + o[k]).length)));
            return fmt;
        }
        //弹出信息窗口 title:标题 msgString:提示信息 msgType:信息类型 [error,info,question,warning]
        function msgShow(title, msgString, msgType) {
            $.messager.alert(title, msgString, msgType);
        }
        $("div[class='tabs-panels']").attr('overflow', 'hidden');
        var toolbar = [
            {
                text: '打印预览',
                iconCls: 'icon-print',
                handler: function () {
                    var select = $('#tt').datagrid('getSelected');
                    if (!select) {
                        // msgShow('系统提示', '请选择数据！', 'warning');
                        return false;
                    }
                    $.ajax({
                        url: "/data/print.aspx/Print",
                        type: "POST",
                        data: "{'guid':'" + select.Guid + "'}",
                        dataType: 'json',
                        contentType: "application/json; charset=utf-8",
                        error: function (err) {
                            if (window == top) {
                                window.location.href = '../Login.aspx';
                            } else {
                                top.location.href = '../Login.aspx';
                            }
                        },
                        success: function (data) {
                            var LODOP;
                            if (data.d == "操作失败") {
                                alert("登陆超时,请重新登录!");
                                if (window == top) {
                                    window.location.href = '../Login.aspx';
                                } else {
                                    top.location.href = '../Login.aspx';
                                }
                                return false;
                            }

                            LODOP = getLodop(document.getElementById('LODOP_OB'), document.getElementById('LODOP_EM'));
                            LODOP.SET_PRINT_PAGESIZE(3, "208mm", "139mm", "");
                            //LODOP.SET_PRINT_PAGESIZE(3, 2200, 600, "A4");
                            LODOP.SET_PRINT_STYLE("FontSize", 18);
                            LODOP.SET_PRINT_STYLE("Bold", 1);
                            //LODOP.ADD_PRINT_TEXT(20, 320, 260, 39, "发货单");
                            LODOP.ADD_PRINT_HTM(120, 30, 400, 900, data.d);
                            LODOP.SET_SHOW_MODE("NP_NO_RESULT", true);
                            //LODOP.PRINT_INIT("打印任务名");               //首先一个初始化语句 
                            //LODOP.ADD_PRINT_TEXT(0, 0, 100, 20, "文本内容一");//然后多个ADD语句及SET语句 
                            //ADD_PRINT_TABLE
                            //LODOP.PRINT();
                            //LODOP.NewPageA();//分页
                            LODOP.PREVIEW();

                        }
                    });
                }
            }, '-',
            {
                text: '发货',
                iconCls: 'icon-redo',
                handler: function () {
                    var select = $('#tt').datagrid('getSelections');
                    if (!select) {
                        // msgShow('系统提示', '请选择数据！', 'warning');
                        return false;
                    }
                    else {
                        var list = "";
                        for (var i = 0; i < select.length; i++) {
                            list += select[i].Guid + ",";
                        }
                        //$('#txtbchGuid').val(select.Guid);
                        $('#txtbchGuid').val(list);
                        $('#logis').window('open');
                    }
                }
            }, '-', {
                text: '导出',
                iconCls: 'icon-save',
                handler: function () {
                    window.location.href = "/data/export.aspx?send=0";
                }
            }];
        function clearNoNum(obj) {
            obj.value = obj.value.replace(/[^\d.]/g, ""); //清除"数字"和"."以外的字符
            obj.value = obj.value.replace(/^\./g, ""); //验证第一个字符是数字而不是
            obj.value = obj.value.replace(/\.{2,}/g, "."); //只保留第一个. 清除多余的
            obj.value = obj.value.replace(".", "$#$").replace(/\./g, "").replace("$#$", ".");
            obj.value = obj.value.replace(/^(\-)*(\d+)\.(\d\d).*$/, '$1$2.$3'); //只能输入两个小数
        }
        function SelectRow(rowIndex, rowData) {
            var SuppBatchGuid = rowData.Guid;
            if ($('#txtBatchId').val() == SuppBatchGuid) {
                return false;
            }
            $('#txtBatchId').val(SuppBatchGuid);
            $('#orderlist').datagrid({
                url: "/data/getItemList.aspx?SuppBatchGuid=" + SuppBatchGuid
            });
            $('#orderlist').datagrid({
                onLoadSuccess: function (data) {
                    $('#orderlist').datagrid('doCellTip', { cls: { 'background-color': '#E6E6E6' }, delay: 300 });
                }
            });
        }
    </script>
    <div id="logis" class="easyui-window" title="填写物流信息" collapsible="false" minimizable="false"
        maximizable="false" icon="icon-save" style="width: 280px; height: 124px; background: #fafafa;">
        <div class="easyui-layout" fit="true">
            <div region="center" border="false" style="padding: 10px; background: #fff; border: 1px solid #ccc;">
                <table cellpadding="3">
                    <tr>
                        <td>物流单号：</td>
                        <td>
                            <input id="txtLogisNo" type="text" class="txt01" />
                            <input id="txtbchGuid" type="hidden" />
                        </td>

                    </tr>
                    <tr>
                        <td>物流公司：</td>
                        <td>
                            <input id="txtLogisName" type="text" class="txt01" /></td>
                    </tr>
                    <tr>
                        <td>实际运费：</td>
                        <td>
                            <input id="txtLogisCost" type="text" class="txt01" onkeyup="clearNoNum(this)" />
                            元</td>
                    </tr>
                    <tr>
                        <td>联系号码：</td>
                        <td>
                            <input id="txtLogisMobile" type="text" class="txt01" /></td>
                    </tr>
                </table>
            </div>
            <div region="south" border="false" style="text-align: right; height: 30px; line-height: 30px;">
                <a id="btnsendok" class="easyui-linkbutton" icon="icon-ok" href="javascript:void(0)">确定</a> <a id="btncancel" class="easyui-linkbutton" icon="icon-cancel" href="javascript:void(0)">取消</a>
            </div>
        </div>
    </div>

</body>
</html>
