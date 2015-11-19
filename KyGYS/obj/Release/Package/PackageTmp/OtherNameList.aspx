<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="OtherNameList.aspx.cs" Inherits="KyGYS.OtherNameList" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
    <link href="jquery-easyui-1.4.2/themes/icon.css" rel="stylesheet" />
    <link href="jquery-easyui-1.4.2/demo/demo.css" rel="stylesheet" />
    <script type="text/javascript" src="http://code.jquery.com/jquery-1.7.1.min.js"></script>
    <script src="jquery-easyui-1.4.2/jQuery.easyui.min.js"></script>
    <script src="jquery-easyui-1.4.2/locale/easyui-lang-zh_CN.js"></script>
    <link href="jquery-easyui-1.4.2/themes/metro/easyui.css" rel="stylesheet" />
    <script src="js/tip.js"></script>
    <script>
        $(function () {
            openMapUser();
            $('#btnok').click(function () {

                if ($('#txtGuid').val() == "") {
                    operateMapUser('Add');
                }
                else {
                    operateMapUser('Edit');
                }
            })

            $('#btncancel').click(function () {
                close();
            })
        });
        //弹出信息窗口 title:标题 msgString:提示信息 msgType:信息类型 [error,info,question,warning]
        function msgShow(title, msgString, msgType) {
            $.messager.alert(title, msgString, msgType);
        }

        function operateMapUser(act) {
            var suppname = $('#txtSuppName');
            var othername = $('#txtOtherName');
            var guid = $('#txtGuid');
            if (suppname.val() == '') {
                msgShow('系统提示', '请输入供应商名称！', 'warning');
                return false;
            }
            if (othername.val() == '') {
                msgShow('系统提示', '请输入别名！', 'warning');
                return false;
            }
            $.post('/data/operateMapUser.aspx?action=' + act + '&suppname=' + suppname.val() + '&othername=' + othername.val() + '&guid=' + guid.val(), function (msg) {
                msgShow('系统提示', msg, 'info');
                suppname.val('');
                othername.val('');
                close();
                $('#tt').datagrid({
                    url: "/data/getMapUserList.aspx"
                });
            })

        }
        //设置登录窗口
        function openMapUser() {
            $('#w').window({
                width: 300,
                modal: true,
                shadow: true,
                closed: true,
                height: 200,
                resizable: false
            });
        }
        //关闭登录窗口
        function close() {
            $('#w').window('close');
        }
        var toolbar = [{
            text: '刷新',
            iconCls: 'icon-reload',
            handler: function () {
                $('#tt').datagrid({
                    url: "/data/getMapUserList.aspx"
                });
            }
        }, '-', {
            text: '新增',
            iconCls: 'icon-add',
            handler: function () {
                $('#w').window({
                    title: "新增"
                });
                $('#w').window('open');
                $('#txtSuppName').val('');
                $('#txtGuid').val('');
                $('#txtOtherName').val('');
                $("#txtSuppName").removeAttr("readonly");
            }
        }, '-', {
            text: '编辑',
            iconCls: 'icon-redo',
            handler: function () {
                var row = $('#tt').datagrid('getSelected');
                if (!row) {
                    return false;
                }
                $('#txtSuppName').val(row.SuppName);
                $('#txtGuid').val(row.Guid);
                $('#txtOtherName').val(row.UserName);
                $("#txtSuppName").attr("readonly", "readonly");
                $('#w').window({
                    title: "编辑"
                });
                $('#w').window('open');
            }
        }];
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <div style="margin: 6px 0;"></div>
        <table title="别名设置" class="easyui-datagrid" id="tt" rownumbers="true" style="width: 100%; height: 309px"
            data-options="singleSelect:true,collapsible:true,url:'/data/getMapUserList.aspx',toolbar:toolbar,method:'get',remoteSort:false,multiSort:true">
            <thead>
                <tr>
                    <th data-options="field:'SuppName',width:120,sortable:true">供应商名称</th>
                    <th data-options="field:'UserName',width:120,sortable:true">别名</th>
                </tr>
            </thead>
        </table>
        <div id="w" class="easyui-window" title="" collapsible="false" minimizable="false"
            maximizable="false" icon="icon-save" style="width: 300px; height: 150px; padding: 5px; background: #fafafa;">
            <div class="easyui-layout" fit="true">
                <div region="center" border="false" style="padding: 10px; background: #fff; border: 1px solid #ccc;">
                    <input id="txtGuid" type="hidden" />
                    <table cellpadding="3">
                        <tr>
                            <td>
                                &nbsp;
                            </td>
                        </tr>
                        <tr>
                            <td>供应商名称：</td>
                            <td>
                                <input id="txtSuppName" type="text" class="txt01" /></td>
                        </tr>
                        <tr>
                            <td>别名：</td>
                            <td>
                                <input id="txtOtherName" type="text" class="txt01" /></td>
                        </tr>
                    </table>
                </div>
                <div region="south" border="false" style="text-align: right; height: 30px; line-height: 30px;">
                    <a id="btnok" class="easyui-linkbutton" icon="icon-ok" href="javascript:void(0)">确定</a> <a id="btncancel" class="easyui-linkbutton" icon="icon-cancel" href="javascript:void(0)">取消</a>
                </div>
            </div>
        </div>
    </form>
</body>
</html>
