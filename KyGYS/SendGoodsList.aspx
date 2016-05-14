<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SendGoodsList.aspx.cs" Inherits="KyGYS.SendGoodsList" ValidateRequest="false" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="renderer" content="webkit|ie-comp|ie-stand" />
    <title></title>
    <link href="jquery-easyui-1.4.2/themes/icon.css" rel="stylesheet" />
    <link href="jquery-easyui-1.4.2/demo/demo.css" rel="stylesheet" />
    <%--    <script type="text/javascript" src="http://code.jquery.com/jquery-1.7.1.min.js"></script>--%>
    <script src="js/jquery-1.7.min.js"></script>
    <script src="jquery-easyui-1.4.2/jQuery.easyui.min.js"></script>
    <script src="jquery-easyui-1.4.2/locale/easyui-lang-zh_CN.js"></script>
    <link href="jquery-easyui-1.4.2/themes/metro/easyui.css" rel="stylesheet" />
    <script src="js/tip.js"></script>
</head>
<body>
    <form runat="server">
        <div id="p" class="easyui-panel" style="width: 100%; height: 40px; padding: 6px;">
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

        <table title="" class="easyui-datagrid" id="tt" rownumbers="true" pagination="true" style="width: 100%; height: 309px"
            data-options="singleSelect:true,collapsible:true,url:'/data/getSendList.aspx',onSelect:SelectRow,toolbar:toolbar,method:'get',remoteSort:false,multiSort:true,pageSize:1,pageList:[10,20,50,100,200]">
            <thead>
                <tr>
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
                    <th data-options="field:'Color',width:120,align:'left',sortable:true">颜色</th>
                </tr>
            </thead>
        </table>
    </form>
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
                $.messager.confirm("系统提示", "是否修改？", function (data) {
                    if (!data) {
                        return false;
                    }
                    else {
                        guid = $('#txtbchGuid').val();
                        if (guid == null) {
                            return false;
                        }
                        $.ajax({
                            url: "/data/getSendList.aspx/UpdateLogis",
                            type: "POST",
                            data: "{'guid':'" + guid + "','logisNo':'" + logisno + "','logisName':'" + logisname + "','logisCost':'" + logiscost + "','logisMobile':'" + logismobile + "'}",
                            dataType: 'json',
                            contentType: "application/json; charset=utf-8",
                            error: function (err) {
                                msgShow('系统提示', '修改失败！', 'error');
                            },
                            success: function (data) {
                                if (data.d == "登录超时") {
                                    msgShow('系统提示', '登录失效,请重新登录！', 'warning');
                                    if (window == top) { window.location.href = '../Login.aspx'; } else { top.location.href = '../Login.aspx'; }
                                } else {
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
                onLoadSuccess: function (data) {
                    $('#tt').datagrid('doCellTip', { cls: { 'background-color': '#E6E6E6' }, delay: 300 });
                    $('#tt').datagrid('selectRow', 0);
                }
            });
            $('#tt').datagrid({
                columns: [[
                //{ field: 'ck', checkbox: true },
                //{ field: 'OrderFrom', title: '订单来源', width: '120', sortable: true },
                                                { field: 'SellerNick', title: '店铺', width: '120', sortable: true },
                //{ field: 'BuyerNick', title: '买家', width: '118', sortable: true },
                   {
                       field: 'OrderTime', width: '143', sortable: true, title: '下单时间',
                       formatter: function (value, row, index) {
                           if (typeof (value) != "undefined") {
                               value = value.replace(/\T/g, ' ');
                               value = value.substring(0, value.lastIndexOf('.'));
                           }
                           //  var unixTimestamp = new Date(value).Format("yyyy-MM-dd hh:mm:ss");
                           var unixTimestamp = value;
                           return unixTimestamp;
                       }
                   },
                   { field: 'BatchItemCount', title: '商品总数', width: '55', align: 'right', sortable: true },
                   { field: 'ReceiverName', title: '收货人', width: '120', sortable: true },
                   //{ field: 'ReceiverMobile', title: '手机', width: '120', sortable: true },
                   { field: 'ReceiverAddress', title: '收货地址', width: '200', sortable: true },
                   { field: 'LogisNo', title: '物流单号', width: '110', sortable: true },
                   { field: 'LogisName', title: '物流公司', width: '110', sortable: true },
                  { field: 'LogisCost', title: '实际运费', width: '60', sortable: true },
                  { field: 'LogisMobile', title: '物流电话', width: '100', sortable: true }
                ]],
            });
        });
        //设置登录窗口
        function openwid() {
            $('#logis').window({
                title: '填写物流信息',
                width: 350,
                modal: true,
                shadow: true,
                closed: true,
                height: 220,
                //onBeforeClose: function () {
                //    $('#txtLogisNo').val("");
                //    $('#txtLogisName').val("");
                //    $('#txtLogisCost').val("");
                //    $('#txtLogisMobile').val("");
                //},
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
        var toolbar = [{
            text: '修改物流',
            iconCls: 'icon-redo',
            handler: function () {
                var select = $('#tt').datagrid('getSelected');
                if (!select) {
                    // msgShow('系统提示', '请选择数据！', 'warning');
                    return false;
                }
                $('#txtbchGuid').val(select.Guid);
                $('#txtLogisNo').val(select.LogisNo);
                $('#txtLogisName').val(select.LogisName);
                $('#txtLogisCost').val(select.LogisCost);
                $('#txtLogisMobile').val(select.LogisMobile);
                $('#logis').window('open');
            }
        }, '-',
            {
                text: '导出',
                iconCls: 'icon-save',
                handler: function () {
                    window.location.href = "/data/export.aspx?send=1";
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
                return false;
            }
            var SuppBatchGuid = rowData.Guid;
            if ($('#txtBatchId').val() == SuppBatchGuid) {
                return false;
            }
            $('#txtBatchId').val(SuppBatchGuid);
            $('#orderlist').datagrid({
                url: "/data/getItemList.aspx?SuppBatchGuid=" + SuppBatchGuid,
                columns: [[
                                       {
                                           field: 'Reserved2', title: '商品图片', width: '60', align: 'center', formatter: function (value, row) {
                                               var str = "";
                                               if (value != "" || value != null) {
                                                   if (typeof (value) != "undefined") {
                                                       str = " <a class='various fancybox.iframe' style='margin-left:10px;' href='./showImg2.aspx?ImageSession=" + value + "' target='_blank'><img style=\"height: 33px;width: 33px;\" onerror=\"this.style.display='none' \"  alt='无' src=\"" + value + "\"/></a>";
                                                   } else {
                                                       str = " <a class='various fancybox.iframe' style='margin-left:10px;' href='./showImg2.aspx?ImageSession=" + value + "' target='_blank'><img style=\"height: 33px;width: 33px;\" onerror=\"this.style.display='none' \"  alt='无' /></a>";
                                                   }
                                                   return str;
                                               }
                                           }
                                       },
                                      { field: 'ItemName', title: '商品名称', width: '230', sortable: true },
                                      { field: 'SkuProperties', title: '规格名称', width: '190', sortable: true },
                                      { field: 'OuterIid', title: '商品编码', width: '150', sortable: true, align: 'left' },
                                      { field: 'OuterSkuId', title: '规格编码', width: '150', sortable: true, align: 'left' },
                                      { field: 'Num', title: '数量', width: '40', sortable: true },
                                      { field: 'PackageCount', title: '包件数', width: '40', sortable: true },
                                      { field: 'BusVolume', title: '体积', width: '60', sortable: true, align: 'left' },
                                      { field: 'Size', title: '尺寸', width: '70', sortable: true, align: 'left' },
                                      { field: 'Color', title: '颜色', width: '110', sortable: true, align: 'left' }
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
                        msgShow('系统提示', '登录失效,请重新登录！', 'warning');
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
    <script>
        
    </script>
    <div class="easyui-panel" data-options="closed:true" id="import_panel" style="display: none; border: hidden">
        <div id="logis" class="easyui-window" title="填写物流信息" collapsible="false" minimizable="false"
            maximizable="false" icon="icon-save" style="width: 280px; height: 124px; background: #fafafa;">
            <div class="easyui-layout" fit="true">
                <div region="center" border="false" style="padding: 10px; background: #fff; border: 1px solid #ccc;">
                    <table cellpadding="3">
                        <tr>
                            <td>物流单号：</td>
                            <td>
                                <input id="txtLogisNo" type="text" value="" class="txt01" />
                                <input id="txtbchGuid" type="hidden" />
                            </td>

                        </tr>
                        <tr>
                            <td>物流公司：</td>
                            <td>
                                <input id="txtLogisName" type="text" value="" class="txt01" />
                        </tr>
                        <tr>
                            <td>实际运费：</td>
                            <td>
                                <input id="txtLogisCost" type="text" class="txt01" value="" onkeyup="clearNoNum(this)" />
                                元</td>
                        </tr>
                        <tr>
                            <td>联系号码：</td>
                            <td>
                                <input id="txtLogisMobile" type="text" class="txt01" value="" /></td>
                        </tr>
                    </table>
                </div>
                <div region="south" border="false" style="text-align: right; height: 30px; line-height: 30px;">
                    <a id="btnsendok" class="easyui-linkbutton" icon="icon-ok" href="javascript:void(0)">确定</a> <a id="btncancel" class="easyui-linkbutton" icon="icon-cancel" href="javascript:void(0)">取消</a>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
