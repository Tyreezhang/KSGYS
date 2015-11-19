<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="KyGYS.Login" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=gb18030">
        <meta name="renderer" content="webkit|ie-comp|ie-stand"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="save" content="history">
    <link rel="shortcut icon" href="./images/logo.png">
    <title>客易供应商系统</title>
        <script src="jquery-easyui-1.4.2/jquery-1.4.2.min.js"></script>
    <script src="jquery-easyui-1.4.2/jQuery.easyui.js"></script>
    <link href="../style/one.css" rel="stylesheet" />
    <link href="../style/two.css" rel="stylesheet" />
<%--    <script type="text/javascript">
        if (/ie/gi.test(navigator.userAgent)) {
            alert("请选择非IE内核浏览器");
        }
    </script>--%>
    <style type="text/css" media="screen,print">
        .top a, .navPageBottom a {
            border-right: 1px solid #ccc;
            padding: 0 8px 0 4px;
        }

        .top .left {
            float: left;
        }

            .top .left a {
                border: none;
            }

        .navPageTop a.end, .navPageBottom a.end {
            border-right: 0;
        }

        .container {
            width: 860px;
            margin: 0 auto auto;
        }

        .content, .footer {
            clear: both;
            width: 100%;
        }

        .navPageTop {
            height: 28px;
            line-height: 200%;
            background: #eaf3ff;
            margin: 6px 0 0;
            padding: 0 6px 0 12px;
        }

            .navPageTop .naviBar {
                float: right;
                text-align: left;
            }

        .footer {
            text-align: center;
            float: left;
            margin: 20px 0 0;
        }

            .footer p {
                line-height: 200%;
                display: block;
            }

        .moreFeature {
            text-align: right;
            padding: 6px 422px 30px 0;
        }

        .panelLogin {
            min-height: 370px;
            height: auto !important;
            height: 370px;
            width: 290px;
            float: right;
            background: #f4f4f4;
            border: 1px solid #ccc;
            margin: 0 auto;
            padding: 20px 16px 0 22px;
        }

            .panelLogin h2 {
                text-align: left;
                font-size: 14px;
                margin: 0;
            }

            #VerifyArea p, .panelLogin p {
                clear: both;
                display: block;
                margin: 0 0 10px;
            }

        input {
            display: block;
            float: left;
        }

        .text {
            border: 1px solid #cad0dc;
            height: 22px;
            padding: 2px;
            width: 110px;
            width: 155px;
            font-size: 14px;
        }

        p.operate {
            padding: 0 0 0 59px;
            line-height: 110%;
        }

        .subfix {
            color: #039;
            line-height: 26px;
        }

        .btn {
            line-height: 120%;
            padding: 2px 14px;
        }

        em {
            font-style: normal;
            border-left: 1px solid #ccc;
            padding: 0 0 0 10px;
        }

        p.desc {
            margin-top: -6px;
        }

        #VerifyArea {
            display: none;
            clear: both;
            float: left;
            margin: 0;
        }

        .cLight {
            color: #888;
        }

        .copyright {
            font-size: 11px;
            clear: both;
        }

        .infobar {
            clear: both;
            margin: 6px 0 0 0;
        }

        .infobar1 {
            background: #fff9e3;
            clear: both;
            border: 1px solid #fadc80;
            line-height: 120%;
            float: none;
            margin: 8px 0;
            padding: 6px 6px 6px 6px;
        }

        .error {
            color: #f00;
        }

        ul.contentul {
            font-size: 14px;
            line-height: 26px;
            list-style: none;
            margin-top: -1px;
        }

            ul.contentul b {
                color: #000;
            }

        .clr {
            clear: both;
        }

        .featureList {
            padding: 10px 20px;
            margin: 0;
        }

            .featureList li {
                padding: 3px 0;
                color: #bbb;
            }

                .featureList li span {
                    color: #000;
                }

        .loginplan {
            text-align: left;
            width: 300px!important;
            width: 323px;
            background: #f5f5f5;
            border: 1px solid #cad0dc;
            padding: 12px;
        }

        .adplan {
            text-align: left;
            margin: 0 325px 0 0;
        }

        label {
            display: block;
            float: left;
            line-height: 24px;
        }

            label.column {
                width: 60px;
                font-size: 14px;
                text-align: left;
                padding: 0 0 0 2px;
            }

        .adimg {
            width: 146px;
            height: 168px;
        }

        .panintro {
        }

        dl.panintro {
            margin: 1px 0 0 3px;
            padding: 3px 0 0 3px;
            font: normal 14px Verdana;
            height: 171px;
        }

            dl.panintro dt {
                display: block;
                float: left;
                margin: 0 0 5px 0;
            }

            dl.panintro dd {
                display: block;
                float: left;
                margin: 42px 0 0 10px;
            }

                dl.panintro dd a {
                    font: bold 14px verdana;
                }

                dl.panintro dd div {
                    font: normal 12px Verdana;
                    margin: 14px 0 2px 0;
                    line-height: 22px;
                }

        .panintro ul {
            color: #888;
            line-height: 130%;
            margin: 5px 0 0 18px;
            padding: 0;
        }

        .moreinfo {
            margin: 10px 0 0 3px;
            clear: left;
        }

        .navPageBottom {
            height: 24px;
            line-height: 24px;
            margin-top: 20px;
        }

        .btn {
            padding: 4px 14px;
            height: 29px;
        }

        .topLink {
            height: 26px;
            padding-top: 20px;
        }
        .qqmaillogo {
            float: left;
            margin-bottom: 10px;
            padding-left: 4px;
        }

        .wd {
            width: 800px;
            clear: both;
            margin: 0 auto;
        }

        .domain_select_box {
            background-color: #fff;
            position: absolute;
            width: 110px;
            top: 24px;
            right: 22px;
            padding: 5px 0px;
            border: 1px solid #9DADC5;
            border-radius: 3px;
            box-shadow: 0 0 8px rgba(0,0,0,0.3);
            text-align: left;
        }

            .domain_select_box a {
                display: block;
                line-height: 24px;
                text-decoration: none;
                width: 100%;
                text-indent: 10px;
                overflow: hidden;
                white-space: nowrap;
                text-overflow: ellipsis;
                -o-text-overflow: ellipsis;
            }

                .domain_select_box a:hover {
                    background-color: #EAF3FF;
                }

            .domain_select_box a {
                color: #4d4d4c;
                text-decoration: none;
            }
        .domain_play_default { /*position:relative;*/
            font-size: 14px;
            line-height: 23px;
            margin-left: 0px;
            overflow: hidden;
            white-space: nowrap;
            text-overflow: ellipsis;
            -o-text-overflow: ellipsis;
            width: 106px;
            padding: 1px 10px 0 2px;
            display: inline-block;
            cursor: pointer;
            text-align: center; /*border-top:1px solid #7C7C7C;background: #ffffff url(http://rescdn.qqmail.com/bizmail/zh_CN/htmledition/images/newicon/today087793.gif) 0 -162px repeat-x;*/
        }

            .domain_play_default:hover .domain_select {
                opacity: 1;
                filter: alpha(opacity=100);
            }
    </style>
</head>
<body class="" style="background: #edf4f9">
    <form id="Form1" runat="server">
        <div name="Header">
            <div style="height: 46px; margin-top: 20px;" class="wd getuserdata" id="topDataTd">
                <a href="http://www.keyisoft.cn/">
                    <!-- Logo -->
                    <div class="qqmaillogo" style="width: 320px; height: 42px; margin-top: 0px; background: url(images/专注家装ERP.png) no-repeat;"></div>
                </a>
                <div class="topLink right addrtitle"><a href="http://www.keyisoft.cn/Solutions.html" target="_blank" style="color: #1E5494">解决方案</a> <span style="color: #798699">| </span><a href="http://sighttp.qq.com/msgrd?v=1&amp;uin=2978552889&amp;site=www.lumengsh.com&amp;menu=yes" target="_blank" style="color: #1E5494">QQ在线客服</a></div>
            </div>
        </div>
        <div class="loginContainer">
            <!-- 左侧图片 -->
            <div class="wd loginMain" style="text-align: left; min-height: 300px; background: url(images/电脑.png) no-repeat;">
                    <input type="hidden" name="sid" value=""><input type="hidden" name="uin" value=""><input type="hidden" name="domain" value="keyisoft.cn"><input type="hidden" name="logindomain" value="keyisoft.cn"><input type="hidden" name="aliastype" value="other"><input type="hidden" name="errtemplate" value="logindomain"><input type="hidden" name="loginentry" value="2"><input type="hidden" name="firstlogin" value="false"><input type="hidden" name="starttime"><input type="hidden" name="redirecturl"><input type="hidden" name="f" value="biz"><input type="hidden" name="p"><input type="hidden" name="delegate_url" value=""><input type="hidden" name="s" value=""><input type="hidden" name="ts" value="1431676353"><input type="hidden" name="from" value=""><input type="hidden" name="ppp" value=""><input type="hidden" name="chg" value="0"><div class="" style="padding: 40px 20px 30px 400px;">
                        <div class="loginPanel" style="background-color: #CBD8EA; width: 380px;">
                            <div class="loginPanelTop" style="">
                                <div class="loginPanelBottom" style="">
                                    <div class="logintitle bold" style="">登录客易供应商系统&nbsp;</div>
                                    <div class="loginContent" style="position: relative;">
                                        <div style="border-bottom: 1px solid #e6eaf5; border-top: 1px solid #7390bf; overflow: hidden; height: 0;"></div>
                                        <div style="height: 18px; overlfow: hidden; margin: 3px 0;">
                                            <div id="msgContainer" style="*width: 100%;"></div>
                                        </div>
                                        <div style="height: 25px;">
                                            <label for="uin" class="column">帐　号：</label><div class="left" style="width: 260px;">
                                                <asp:TextBox ID="txtusername" runat="server" CssClass="" Width="252" Height="24"></asp:TextBox>
                                            </div>
                                        </div>
                                        <div style="padding: 3px 0 0 63px; color: #6076a0; zoom: 1;">请填写供应商系统的完整帐号</div>
                                        <div style="height: 25px; margin: 8px 0 0 0; clear: left">
                                            <label for="pp" class="column">密　码：</label>
                                            <asp:TextBox ID="txtpwd" runat="server" CssClass="" Width="252" Height="24" TextMode="Password"></asp:TextBox>
                                        </div>
                                        <div style="margin: 8px 0px 0px; float: none; display: none;" id="VerifyArea">
                                        </div>
                                        <div style="margin: 8px 0 0 56px" id="sss">
                                            <div style="height: 25px; padding-top: 8px; *padding-top: 0; padding-left: 2px; position: relative;">
                                            </div>
                                        </div>
                                        <div style="padding: 0px 0 0 60px; clear: both;">
                                            <asp:Button OnClick="submit_Click" runat="server" Text="登  录" Width="120px" Height="30" />
                                        </div>
                                        <div style="margin: 10px 0 10px 60px; color: #868686; clear: left;"></div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                <div style="clear: both;"></div>
            </div>
            <div id="divProber" style="display: none"></div>
        </div>
        <div style="clear: both;"></div>
        <div class="wd txt_center" style="margin-top: 30px;">
            <div class="navPageBottom"><a href="http://www.keyisoft.cn/" target="_blank">关于客易</a><a href="http://www.keyisoft.cn/ContactUs.html" target="_blank" class="end">联系我们</a></div>
            <div class="copyright cLight">Copyright@ 2011 - 2015 上海客易软件有限公司</div>
        </div>
    </form>
</body>
</html>
