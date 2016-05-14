<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PurchOrderlist.aspx.cs" Inherits="KyGYS.PurchOrderlist" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <link href="jquery-easyui-1.4.2/themes/icon.css" rel="stylesheet" />
    <link href="jquery-easyui-1.4.2/demo/demo.css" rel="stylesheet" />
    <script src="js/jquery-1.8.2.min.js"></script>
    <script src="jquery-easyui-1.4.2/jQuery.easyui.min.js"></script>
    <script src="jquery-easyui-1.4.2/locale/easyui-lang-zh_CN.js"></script>
    <link href="jquery-easyui-1.4.2/themes/metro/easyui.css" rel="stylesheet" />
    <script src="js/tip.js"></script>
    <script src="js/LodopFuncs.js"></script>
</head>
<body>
    <object id="LODOP_OB" classid="clsid:2105C259-1E0C-4534-8141-A753534CB4CA" width="0" height="0">
        <embed id="LODOP_EM" type="application/x-print-lodop" width="0" height="0" pluginspage="install_lodop32.exe"></embed>
    </object>
    <form runat="server">
        <div id="p" class="easyui-panel" style="width: 99%; height: 38px; padding: 4px;">
            <asp:Button runat="server" CssClass="easyui-linkbutton" ID="btnRef" Text="查  询" OnClick="btnRef_Click" Style="width: 80px; height: 28px;"></asp:Button>
            采购单号:
            <asp:TextBox runat="server" ID="txtPurchNo"></asp:TextBox>&nbsp;
        </div>
        <input type="hidden" id="txtBatchId" />
        <input type="hidden" id="tabindex" runat="server" />
        <div style="margin: 2px 0;"></div>
        <div id="content" class="easyui-tabs" style="width: 100%;" >
            <div title="未接单" style="width: 99%;" >
                <table title="" id="tt" rownumbers="true" pagination="true" style="width: 100%; height: 320px"
                    data-options="singleSelect:true,collapsible:true,url:'/data/getUnauditPurch.aspx',onSelect:SelectRow,toolbar:Untoolbar,method:'get',remoteSort:false,multiSort:true,pageSize:1,pageList:[10,50,100,500,1000]">
                    <thead>
                        <tr>
                            <th data-options="field:'PurchNo',width:143, align: 'center', sortable:true">采购单号</th>
                            <th data-options="field:'CreateDate',width:143,align: 'center',sortable:true" formatter="datestr">下单时间</th>
                        </tr>
                    </thead>
                </table>
            </div>
            <div title="已接单" style="width: 99%;">
                <table title="" id="audittable" rownumbers="true" pagination="true" style="width: 100%; height: 320px"
                    data-options="singleSelect:true,collapsible:true,url:'/data/getAuditPurch.aspx',onSelect:SelectRow,toolbar:toolbar,method:'get',remoteSort:false,multiSort:true,pageSize:1,pageList:[10,50,100,500,1000]">
                    <thead>
                        <tr>
                            <th data-options="field:'PurchNo',width:143, align: 'center', sortable:true">采购单号</th>
                            <th data-options="field:'CreateDate',width:143,align: 'center',sortable:true" formatter="datestr">下单时间</th>
                            <th data-options="field:'Reserved1',width:150,align: 'center',sortable:true" formatter="formatprint">是否打印</th>
                        </tr>
                    </thead>
                </table>
            </div>
            <div title="已作废" style="width: 99%;">
                <table title="" id="Invalidtable" rownumbers="true" pagination="true" style="width: 100%; height: 320px"
                    data-options="singleSelect:true,collapsible:true,url:'/data/getInvalid.aspx',onSelect:SelectRow,method:'get',remoteSort:false,multiSort:true,pageSize:1,pageList:[10,50,100,500,1000]">
                    <thead>
                        <tr>
                            <th data-options="field:'PurchNo',width:143, align: 'center', sortable:true">采购单号</th>
                            <th data-options="field:'CreateDate',width:143,align: 'center',sortable:true" formatter="datestr">下单时间</th>
                            <th data-options="field:'Reserved1',width:150,align: 'center',sortable:true" formatter="formatprint">是否打印</th>
                            <th data-options="field:'InvalidTime',width:143,align: 'center',sortable:true" formatter="datestr">作废时间</th>
                            <th data-options="field:'InvalidRemark',width:150,align: 'center',sortable:true">作废原因</th>
                        </tr>
                    </thead>
                </table>
            </div>
        </div>
        <div style="margin: 6px 0;"></div>
        <table title="" class="easyui-datagrid" id="orderlist" rownumbers="true" style="width: 99%; height: 150px"
            data-options="singleSelect:true,collapsible:true,remoteSort:false,multiSort:true">
            <thead>
                <tr>
                </tr>
            </thead>
        </table>
    </form>
    <script type="text/javascript">
        function formatprint(val, row) {
            if (val == 1) {
                return '<span style="color:red;">' + '是' + '</span>';
            } else {
                return '否';
            }
        }

        function datestr(value, row, index) {
            if (typeof (value) != "undefined" && value != null) {
                value = value.replace(/\T/g, ' ');
                if (value.lastIndexOf('.') > 0) {
                    value = value.substring(0, value.lastIndexOf('.'));
                }
            }
            var unixTimestamp = value;
            return unixTimestamp;
        };
        $(function () {
            var tabindex = $("#<%=tabindex.ClientID%>").val();
            switch (tabindex) {
                case "0":
                    $("#content").tabs("select", 0);
                    UnAudit();
                    break;
                case "1":
                    $("#content").tabs("select", 1);
                    Audit();
                    break;
                case "2":
                    $("#content").tabs("select", 2);
                    Invalid();
                    break;
                default:
                    $("#content").tabs("select", 0);
                    UnAudit();
                    break;
            }
            openwid();
            $('#content').tabs({
                border: false,
                onSelect: function (title) {
                    switch (title) {
                        case "未接单":
                            $("#content").tabs("select", 0);
                            $("#<%=tabindex.ClientID%>").val("0");
                            UnAudit();
                            break;
                        case "已接单":
                            $("#content").tabs("select", 1);
                            $("#<%=tabindex.ClientID%>").val("1");
                            Audit();
                            break;
                        case "已作废":
                            $("#content").tabs("select", 2);
                            $("#<%=tabindex.ClientID%>").val("2");
                            Invalid();
                            break;
                        default:
                            $("#content").tabs("select", 0);
                            break;
                    }
                }
            });

            function UnAudit() {
                $('#tt').datagrid({
                    onLoadSuccess: function (data) {
                        $('#tt').datagrid('doCellTip', { cls: { 'background-color': '#E6E6E6' }, delay: 300 });
                        $('#tt').datagrid('selectRow', 0);
                    },
                    onLoadError: function () {
                        msgShow('系统提示', '正在加载中！', 'warning');
                        return false;
                    },
                    loadFilter: function (data) {
                        if (data.IsError) {
                            alert("登陆失效,请重新登录！");
                            if (window == top) { window.location.href = '../Login.aspx'; } else { top.location.href = '../Login.aspx'; }
                            return {
                                total: 0,
                                rows: []
                            };
                            //msgShow('系统提示', '正在加载中！', 'warning');
                        } else {
                            return data;
                        }
                    }
                });
            }

            function Audit() {
                $('#audittable').datagrid({
                    onLoadSuccess: function (data) {
                        $('#audittable').datagrid('doCellTip', { cls: { 'background-color': '#E6E6E6' }, delay: 300 });
                        $('#audittable').datagrid('selectRow', 0);
                    },
                    onLoadError: function () {
                        msgShow('系统提示', '正在加载中！', 'warning');
                        return false;
                    },
                    loadFilter: function (data) {
                        if (data.IsError) {
                            alert("登陆失效,请重新登录！");
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
            }

            function Invalid() {
                $('#Invalidtable').datagrid({
                    onLoadSuccess: function (data) {
                        $('#Invalidtable').datagrid('doCellTip', { cls: { 'background-color': '#E6E6E6' }, delay: 300 });
                        $('#Invalidtable').datagrid('selectRow', 0);
                    },
                    onLoadError: function () {
                        msgShow('系统提示', '正在加载中！', 'warning');
                        return false;
                    },
                    loadFilter: function (data) {
                        if (data.IsError) {
                            alert("登陆失效,请重新登录！");
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
            }

            $('#btnsendok').click(function () {
                var InvalidPurchNo = $('#txtInvalidPurchNo').val();
                var invalidRemark = $('#txtInvalidRemark').val();

                if (invalidRemark == '') {
                    msgShow('系统提示', '请输入作废原因！', 'warning');
                    return false;
                }
                var guid = "";
                close();
                $.messager.confirm("系统提示", "确定是否要作废？", function (data) {
                    if (!data) {
                        return false;
                    }
                    else {
                        guid = $('#txtbchGuid').val();
                        if (guid == null) {
                            return false;
                        }
                        $.ajax({
                            url: "/data/getUnauditPurch.aspx/Invalid",
                            type: "POST",
                            data: "{'guid':'" + guid + "','InvalidPurchNo':'" + InvalidPurchNo + "','invalidRemark':'" + invalidRemark + "'}",
                            dataType: 'json',
                            contentType: "application/json; charset=utf-8",
                            error: function (err) {
                                msgShow('系统提示', '操作失败！', 'error');
                            },
                            success: function (data) {
                                //msgShow('系统提示', data.d, 'info');
                                //$('#tt').datagrid('reload');
                                //$('#orderlist').datagrid('loadData', { total: 0, rows: [] });
                                var tabindex = $("#<%=tabindex.ClientID%>").val();
                                switch (tabindex) {
                                    case "0":
                                        $("#content").tabs("select", 0);
                                        UnAudit();
                                        break;
                                    case "1":
                                        $("#content").tabs("select", 1);
                                        Audit();
                                        break;
                                    case "2":
                                        $("#content").tabs("select", 2);
                                        Invalid();
                                        break;
                                    default:
                                        $("#content").tabs("select", 0);
                                        UnAudit();
                                        break;
                                }
                            }});
                        return false;
                    }
                });
            })

            $('#btncancel').click(function () {
                $('#txtInvalidPurchNo').val("");
                $('#txtInvalidRemark').val("");
                $('#txtbchGuid').val("");
                close();
            })

            $('#tt').datagrid({
                onLoadSuccess: function (data) {
                    $('#tt').datagrid('doCellTip', { cls: { 'background-color': '#E6E6E6' }, delay: 300 });
                    $('#tt').datagrid('selectRow', 0);
                },
                onLoadError: function () {
                    //alert("登录失效,请重新登录！");
                    //if (window == top) { window.location.href = '../Login.aspx'; } else { top.location.href = '../Login.aspx'; }
                    msgShow('系统提示', '正在加载中！', 'warning');
                    return false;
                },
                loadFilter: function (data) {
                    if (data.IsError) {
                        alert("登录失效,请重新登录！");
                        if (window == top) { window.location.href = '../Login.aspx'; } else { top.location.href = '../Login.aspx'; }
                        return {
                            total: 0,
                            rows: []
                        };
                        //msgShow('系统提示', '正在加载中！', 'warning');
                    } else {
                        return data;
                    }
                }
            });
        });
        //设置登录窗口
        function openwid() {
            $("#import_panel").panel('open');
            $("#import_panel").show();
            $('#logis').window({
                title: '填写作废原因',
                width: 350,
                modal: true,
                shadow: true,
                closed: true,
                height: 250,
                onBeforeClose: function () {
                    $('#txtInvalidPurchNo').val("");
                    $('#txtInvalidRemark').val("");
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
                    var select = $('#audittable').datagrid('getSelected');
                    if (!select) {
                        return false;
                    }
                    $.ajax({
                        url: "/data/print.aspx/PrintPurch",
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
                                if (window == top) {
                                    window.location.href = '../Login.aspx';
                                } else {
                                    top.location.href = '../Login.aspx';
                                }
                                return false;
                            }
                            LODOP = getLodop(document.getElementById('LODOP_OB'), document.getElementById('LODOP_EM'));
                            LODOP.SET_PRINT_PAGESIZE(3, 0, 0, "A4");
                            LODOP.SET_PRINT_STYLE("FontSize", 18);
                            LODOP.SET_PRINT_STYLE("Bold", 1);
                            LODOP.ADD_PRINT_HTM(4, 0, 500, 1200, data.d);
                            LODOP.SET_SHOW_MODE("NP_NO_RESULT", true);
                            LODOP.SET_PRINT_STYLEA(0, "HtmWaitMilSecs", 200);
                            if (LODOP.CVERSION) {  //用CVERSION属性判断是否云打印
                                LODOP.On_Return = function (TaskID, Value) {
                                    if (Value == "1") {
                                        $.ajax({
                                            url: "/data/getAuditPurch.aspx/UpdatePrint",
                                            type: "POST",
                                            data: "{'guid':'" + select.Guid + "'}",
                                            dataType: 'json',
                                            contentType: "application/json; charset=utf-8",
                                            error: function (err) {
                                            },
                                            success: function (data) {
                                                $('#audittable').datagrid('reload');
                                            }
                                        });
                                        return;
                                    }
                                };
                                LODOP.PREVIEW();
                                return;
                            };

                        }
                    });
                }
            }, '-',
            {
                text: '作废',
                iconCls: 'icon-cancel',
                handler: function () {
                    var select = $('#audittable').datagrid('getSelected');
                    if (!select) {
                        return false;
                    }
                    $('#txtbchGuid').val(select.Guid);
                    $('#logis').window('open');
                    $('#txtInvalidPurchNo').val(select.PurchNo);
                }
            }
        ];

        var Untoolbar = [
            {
                text: '接单',
                iconCls: 'icon-ok',
                handler: function () {
                    var select = $('#tt').datagrid('getSelected');
                    if (!select) {
                        return false;
                    }
                    $.messager.confirm("系统提示", "确定是否要接单？", function (data) {
                        if (!data) {
                            return false;
                        }
                        $.ajax({
                            url: "/data/getUnauditPurch.aspx/Audit",
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
                                if (data.d == "登陆失效") {
                                    if (window == top) {
                                        msgShow('系统提示', data.d, 'error');
                                        window.location.href = '../Login.aspx';
                                    } else {
                                        msgShow('系统提示', data.d, 'error');
                                        top.location.href = '../Login.aspx';
                                    }
                                    return false;
                                }
                                else {
                                    $('#tt').datagrid('reload');
                                }
                            }
                        });
                    }
            )
                }
            }, '-',
            {
                text: '作废',
                iconCls: 'icon-cancel',
                handler: function () {
                    var select = $('#tt').datagrid('getSelected');
                    if (!select) {
                        return false;
                    }
                    $('#txtbchGuid').val(select.Guid);
                    $('#logis').window('open');
                    $('#txtInvalidPurchNo').val(select.PurchNo);
                }
            }
        ];

        function clearNoNum(obj) {
            obj.value = obj.value.replace(/[^\d.]/g, ""); //清除"数字"和"."以外的字符
            obj.value = obj.value.replace(/^\./g, ""); //验证第一个字符是数字而不是
            obj.value = obj.value.replace(/\.{2,}/g, "."); //只保留第一个. 清除多余的
            obj.value = obj.value.replace(".", "$#$").replace(/\./g, "").replace("$#$", ".");
            obj.value = obj.value.replace(/^(\-)*(\d+)\.(\d\d).*$/, '$1$2.$3'); //只能输入两个小数
        }
        function SelectRow(rowIndex, rowData) {
            if (typeof (rowData) == "undefined") {
                $('#orderlist').datagrid('loadData', { total: 0, rows: [] });
                return false;
            }
            var SuppPurchGuid = rowData.Guid;
            $('#txtBatchId').val(SuppPurchGuid);
            $('#orderlist').datagrid({
                url: "/data/getPurchItemList.aspx?SuppPurchGuid=" + SuppPurchGuid,
                columns: [[
                                 {
                                     field: 'Reserved2', title: '商品图片', width: '60', align: 'center', formatter: function (value, row) {
                                         var str = "";
                                         if (value != "" || value != null) {
                                             if (typeof (value) != "undefined") {
                                                 str = " <a class='various fancybox.iframe' style='margin-left:10px;' href='./showImg2.aspx?ImageSession=" + value + "' target='_blank'><img  onerror=\"this.style.display='none'\" style=\"height: 33px;width: 33px;\" alt='无' src=\"" + value + "\"/></a>";
                                             } else {
                                                 str = " <a class='various fancybox.iframe' style='margin-left:10px;' href='./showImg2.aspx?ImageSession=" + value + "' target='_blank'><img onerror=\"this.style.display='none'\" style=\"height: 33px;width: 33px;\" alt='无' /></a>";
                                             }
                                             return str;
                                         }
                                     }
                                 },
                                //{ field: 'ItemName', title: '商品名称', width: '230', sortable: true },
                                //{ field: 'SkuProperties', title: '规格名称', width: '190', sortable: true },
                                { field: 'OuterIid', title: '商品编码', width: '150', sortable: true, align: 'left' },
                                { field: 'OuterSkuId', title: '规格编码', width: '180', sortable: true, align: 'left' },
                                { field: 'Num', title: '采购数量', width: '80', sortable: true }
                ]],
            });
            $('#orderlist').datagrid({
                onLoadSuccess: function (data) {
                    $('#orderlist').datagrid('doCellTip', { cls: { 'background-color': '#E6E6E6' }, delay: 300 });
                },
                onLoadError: function () {
                    msgShow('系统提示', '正在加载中！', 'warning');
                    return false;
                },
                loadFilter: function (data) {
                    if (data.IsError) {
                        alert("登录失效,请重新登录！");
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
        }
    </script>

    <div class="easyui-panel" data-options="closed:true" id="import_panel" style="display: none; border: hidden">
        <div id="logis" class="easyui-window" title="填写作废原因" collapsible="false" minimizable="false"
            maximizable="false" icon="icon-save" style="width: 280px; height: 124px; background: #fafafa;">
            <div class="easyui-layout" fit="true">
                <div region="center" border="false" style="padding: 10px; background: #fff; border: 1px solid #ccc;">
                    <table cellpadding="3">
                        <tr>
                            <td>采购单号：</td>
                            <td>
                                <input id="txtInvalidPurchNo" type="text" class="txt01" readonly="true" />
                                <input id="txtbchGuid" type="hidden" />
                            </td>

                        </tr>
                        <tr>
                            <td>作废原因：</td>
                            <td>
                                <textarea id="txtInvalidRemark" class="txt01" style="height: 100px; width: 180px; resize: none"></textarea>
                            </td>
                        </tr>
                    </table>
                </div>
                <div region="south" border="false" style="text-align: right; height: 30px; line-height: 30px;">
                    <a id="btnsendok" class="easyui-linkbutton" icon="icon-ok" href="javascript:void(0)">确定</a> <a id="btncancel" class="easyui-linkbutton" icon="icon-cancel" href="javascript:void(0)">取消</a>
                </div>
            </div>
        </div>
    </div>

    <link href="js/jquery.fancybox.css" rel="stylesheet" />
    <script src="js/jquery.fancybox.pack.js"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            $(".various").fancybox({
                fitToView: false,
                width: '80%',
                height: '80%',
                autoSize: false,
                closeClick: false,
                openEffect: 'none',
                closeEffect: 'none'
            });
        });
    </script>
</body>
</html>
