<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="UserList.aspx.cs" Inherits="KyGYS.UserList" %>

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
            openUser();
            $('#btnok').click(function () {

                if ($('#txtGuid').val() == "") {
                    operateUser('Add');
                }
                else {
                    operateUser('Edit');
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

        function operateUser(act) {
            var username = $('#txtUserName');
            var pwd = $('#txtNPwd');
            var txtTel  = $('#txtTel');
            var guid = $('#txtGuid');
            if (username.val() == '') {
                msgShow('系统提示', '请输入帐号！', 'warning');
                return false;
            }
            if (pwd.val() == '') {
                msgShow('系统提示', '请输入密码！', 'warning');
                return false;
            }
            $.post('/data/operateUser.aspx?action='+act+'&username=' + username.val() + '&pwd=' + pwd.val() + '&Tel=' + txtTel.val()+'&guid='+guid.val(), function (msg) {
                msgShow('系统提示', msg, 'info');
                username.val('');
                pwd.val('');
                txtTel.val('');
                close();
                $('#tt').datagrid({
                    url: "/data/getUserList.aspx"
                });
            })

        }
        //设置登录窗口
        function openUser() {
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
                    url: "/data/getUserList.aspx"
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
                $('#txtUserName').val('');
                $('#txtGuid').val('');
                $("#txtUserName").removeAttr("readonly");
            }
        }, '-', {
            text: '编辑',
            iconCls: 'icon-redo',
            handler: function () {
                var row = $('#tt').datagrid('getSelected');
                if (!row) {
                    return false;
                }
                $('#txtUserName').val(row.UserName);
                $('#txtGuid').val(row.Guid);
                $("#txtUserName").attr("readonly", "readonly");
                $('#w').window({
                    title: "编辑"
                });
                $('#w').window('open');
            }
        }, '-', {
            text: '作废',
            iconCls: 'icon-cancel',
            handler: function () {
                var row = $('#tt').datagrid('getSelected');
                if (!row) {
                    return false;
                }
                $.messager.confirm("系统提示", "您确定要作废吗？", function (data) {
                    if (!data) {
                        return false;
                    }
                    else {
                        var guid = row.Guid;
                    }
                    $.ajax({
                        url: "/data/getUnSendList.aspx/SetIsDel",
                        type: "POST",
                        data: "{'guid':'" + guid + "'}",
                        dataType: 'json',
                        contentType: "application/json; charset=utf-8",
                        error: function (err) {
                            msgShow('系统提示', '作废失败！', 'error');
                        },
                        success: function (data) {
                            msgShow('系统提示', data.d, 'info');
                            $('#tt').datagrid('reload');
                        }
                    });
                    return false;
                }
                )
            }
        }];
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <div style="margin: 6px 0;"></div>
        <table title="用户管理" class="easyui-datagrid" id="tt" rownumbers="true" style="width: 100%; height: 309px"
            data-options="singleSelect:true,collapsible:true,url:'/data/getUserList.aspx',toolbar:toolbar,method:'get',remoteSort:false,multiSort:true">
            <thead>
                <tr>
                    <th data-options="field:'UserName',width:120,sortable:true">帐号</th>
                    <th data-options="field:'Tel',width:120,sortable:true">手机</th>
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
                            <td>帐号：</td>
                            <td>
                                <input id="txtUserName"  type="text" class="txt01" /></td>
                        </tr>
                        <tr>
                            <td>密码：</td>
                            <td>
                                <input id="txtNPwd"  type="password" class="txt01" /></td>
                        </tr>
                        <tr>
                            <td>手机：</td>
                            <td>
                                <input id="txtTel"  type="text" class="txt01" /></td>
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
