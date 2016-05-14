<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Index.aspx.cs" Inherits="KyGYS.Index" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="renderer" content="webkit|ie-comp|ie-stand" />
    <title>供应商系统</title>
    <link href="style/default.css" rel="stylesheet" />
    <link href="jquery-easyui-1.4.2/themes/default/easyui2.css" rel="stylesheet" />
    <link href="jquery-easyui-1.4.2/themes/icon.css" rel="stylesheet" />
    <script src="jquery-easyui-1.4.2/jquery-1.4.2.min.js"></script>
    <script src="jquery-easyui-1.4.2/jQuery.easyui.js"></script>
    <script src="jquery-easyui-1.4.2/outlook2.js"></script>
    <script src="jquery-easyui-1.4.2/locale/easyui-lang-zh_CN.js"></script>

    <script type="text/javascript">
        $(document).ready(function () {
            var ismanager = document.getElementById("<%= ismanager.ClientID %>").value;
            if (ismanager == "True") {
                var _menus = {
                    "menus": [
                         {
                             "menuid": "1", "icon": "icon-sys", "menuname": "订单管理",
                             "menus": [{ "menuname": "未发货订单", "icon": "icon-nav", "url": "./UnSendGoodsList.aspx" },
                                 { "menuname": "已发货订单", "icon": "icon-nav", "url": "./SendGoodsList.aspx" }
                             ]
                         },
                         {
                             "menuid": "2", "icon": "icon-sys", "menuname": "系统管理",
                             "menus": [
                                     { "menuname": "用户管理", "icon": "icon-users", "url": "./Userlist.aspx" },
                                     { "menuname": "别名设置", "icon": "icon-users", "url": "./OtherNamelist.aspx" }
                             ]
                         }
                    ]
                };
            }
            else {
                var _menus = {
                    "menus": [
                         {
                             "menuid": "1", "icon": "icon-sys", "menuname": "订单管理",
                             "menus": [{ "menuname": "未发货订单", "icon": "icon-nav", "url": "./UnSendGoodsList.aspx" },
                                 { "menuname": "已发货订单", "icon": "icon-nav", "url": "./SendGoodsList.aspx" }
                             ]
                         }
                    ]
                };
            }
            //初始化左侧
            function InitLeftMenu() {

                $(".easyui-accordion").empty();
                var menulist = "";

                $.each(_menus.menus, function (i, n) {
                    menulist += '<div title="' + n.menuname + '"  icon="' + n.icon + '" style="overflow:auto;">';
                    menulist += '<ul>';
                    $.each(n.menus, function (j, o) {
                        menulist += '<li><div><a target="mainFrame" way="' + o.url + '" ><span class="icon ' + o.icon + '" ></span>' + o.menuname + '</a></div></li> ';
                    })
                    menulist += '</ul></div>';
                })

                $(".easyui-accordion").append(menulist);

                function createFrame(url) {
                    var s = '<iframe name="mainFrame" scrolling="auto" frameborder="0"  src="' + url + '" style="width:100%;height:100%;"></iframe>';
                    return s;
                }
                $('.easyui-accordion li a').click(function () {
                    var tabTitle = $(this).text();
                    var url = $(this).attr("way");
                    //addTab(tabTitle, url);
                    if (!$('#tabs').tabs('exists', tabTitle)) {
                        $('#tabs').tabs('add', {
                            title: tabTitle,
                            content: createFrame(url),
                            closable: true,
                            width: $('#mainPanle').width() - 10,
                            height: $('#mainPanle').height() - 26
                        });
                    } else {
                        $('#tabs').tabs('select', tabTitle);
                    }

                }).hover(function () {
                    $(this).parent().addClass("hover");
                }, function () {
                    $(this).parent().removeClass("hover");
                });

                $(".easyui-accordion").accordion();
            }
            InitLeftMenu();
        });

        function addTab(subtitle, url) {
            if (!$('#tabs').tabs('exists', subtitle)) {
                $('#tabs').tabs('add', {
                    title: subtitle,
                    content: createFrame(url),
                    closable: true,
                    width: $('#mainPanle').width() - 10,
                    height: $('#mainPanle').height() - 26
                });
            } else {
                $('#tabs').tabs('select', subtitle);
            }
            tabClose();
        }
        function tabClose() {
            /*双击关闭TAB选项卡*/
            $(".tabs-inner").dblclick(function () {
                var subtitle = $(this).children("span").text();
                $('#tabs').tabs('close', subtitle);
            })

            $(".tabs-inner").bind('contextmenu', function (e) {
                $('#mm').menu('show', {
                    left: e.pageX,
                    top: e.pageY,
                });

                var subtitle = $(this).children("span").text();
                $('#mm').data("currtab", subtitle);

                return false;
            });
        }
        //设置登录窗口
        function openPwd() {
            $('#w').window({
                title: '修改密码',
                width: 300,
                modal: true,
                shadow: true,
                closed: true,
                height: 160,
                onBeforeClose: function () {
                    $('#txtNewPass').val("");
                    $('#txtRePass').val("");
                },
                resizable: false
            });
        }
        //关闭登录窗口
        function close() {
            $('#w').window('close');
        }



        //修改密码
        function serverLogin() {
            var newpass = $('#txtNewPass');
            var rePass = $('#txtRePass');

            if (newpass.val() == '') {
                msgShow('系统提示', '请输入密码！', 'warning');
                return false;
            }
            if (rePass.val() == '') {
                msgShow('系统提示', '请确认密码！', 'warning');
                return false;
            }

            if (newpass.val() != rePass.val()) {
                msgShow('系统提示', '密码不一致！请重新输入', 'warning');
                return false;
            }
            $.post('/data/editPwd.aspx?newpass=' + newpass.val(), function (msg) {
                msgShow('系统提示', msg, 'info');
                close();
            })

        }

        $(function () {
            openPwd();

            $('#editpass').click(function () {
                $('#w').window('open');
            });

            $('#btnok').click(function () {
                serverLogin();
            })

            $('#btncancel').click(function () {
                $('#txtNewPass').val('');
                $('#txtRePass').val('');
                close();
            })
            $('#loginOut').click(function () {
                $.messager.confirm('系统提示', '您确定要退出本次登录吗?', function (r) {

                    if (r) {
                        location.href = '../LoginOut.aspx';
                    }
                });
            })
        });
    </script>
</head>
<body class="easyui-layout" style="overflow-y: hidden" scroll="no">
    <noscript>
<div style=" position:absolute; z-index:100000; height:2046px;top:0px;left:0px; width:100%; background:white; text-align:center;">
    <img src="images/noscript.gif" alt='抱歉，请开启脚本支持！' />
</div></noscript>
    <div region="north" split="true" border="false" style="overflow: hidden; height: 30px; background: url(images/layout-browser-hd-bg.gif) #7f99be repeat-x center 50%; line-height: 20px; color: #fff; font-family: Verdana, 微软雅黑,黑体">
        <span style="float: right; padding-right: 20px;" class="head">欢迎
            <asp:Label runat="server" ID="lblusername"></asp:Label>
            <a href="javascript:void(0)" id="editpass">修改密码</a> <a href="javascript:void(0)" id="loginOut">安全退出</a></span>
        <span style="padding-left: 10px; font-size: 16px;"><%--<img src="images/blocks.gif" width="20" height="20" align="absmiddle" />--%> 客易供应商系统</span>
    </div>
    <div region="south" split="true" style="height: 30px; background: #D2E0F2;">
        <div class="footer">
            <span id="bglbl">公司官网：keyisoft.cn&nbsp;   &nbsp;电话：0757-82901710</span>
        </div>
    </div>
    <input type="hidden" runat="server" id="ismanager" />
    <div region="west" split="true" title="导航菜单" style="width: 180px;" id="west">
        <div class="easyui-accordion" fit="true" border="false">
            <!--  导航内容 -->

        </div>

    </div>
    <div id="mainPanle" region="center" style="background: #eee; overflow: hidden">
        <div id="tabs" class="easyui-tabs" fit="true" border="false">
            <div title="公告" style="padding: 20px; overflow: hidden;" id="home">

                <h1>预祝贵公司生意兴隆</h1>

            </div>
        </div>
    </div>


    <!--修改密码窗口-->
    <div id="w" class="easyui-window" title="修改密码" collapsible="false" minimizable="false"
        maximizable="false" icon="icon-save" style="width: 300px; height: 150px; padding: 5px; background: #fafafa;">
        <div class="easyui-layout" fit="true">
            <div region="center" border="false" style="padding: 10px; background: #fff; border: 1px solid #ccc;">
                <table cellpadding="3">
                    <tr>
                        <td>新密码：</td>
                        <td>
                            <input id="txtNewPass" type="password" class="txt01" /></td>
                    </tr>
                    <tr>
                        <td>确认密码：</td>
                        <td>
                            <input id="txtRePass" type="password" class="txt01" /></td>
                    </tr>
                </table>
            </div>
            <div region="south" border="false" style="text-align: right; height: 30px; line-height: 30px;">
                <a id="btnok" class="easyui-linkbutton" icon="icon-ok" href="javascript:void(0)">确定</a> <a id="btncancel" class="easyui-linkbutton" icon="icon-cancel" href="javascript:void(0)">取消</a>
            </div>
        </div>
    </div>
</body>
</html>
