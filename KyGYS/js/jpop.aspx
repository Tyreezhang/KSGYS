<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="jpop.aspx.cs" Inherits="UltraFAS_KY_LKFN.js.jpop" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <script src="jquery-1.8.2.min.js"></script>
    <link href="jquery.fancybox.css" rel="stylesheet" />
    <script src="jquery.fancybox.pack.js"></script>
    <title></title>
  <script type="text/javascript">
      $(document).ready(function () {
          $(".various").fancybox({
              //maxWidth: 800,
              //maxHeight: 600,
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
</head>
<body>
    <div id="dialog" >
        <iframe id="myIframe" src=""></iframe>
    </div>
    <form id="form1" runat="server">
        <div>
            <table style="width: 350px; margin-left: 10px;" border="1;" cellspacing="0;" bordercolor="#D5E3F2">
                <tbody>
                    <tr>
                        <th>商品名称</th>
                        <th>规格名称</th>
                        <th>真皮</th>
                        <th>仿皮</th>
                        <th>仿真皮</th>
                        <th>环保皮</th>
                        <th>商标</th>
                        <th>数量</th>
                        <th>备注</th>
                        <th style="width: 50px">查看</th>
                    </tr>
                    <tr>
                        <td>6008改气动</td>
                        <td>1.5*1.9</td>
                        <td>珠光白真皮</td>
                        <td>珠光白仿皮</td>
                        <td>古铜金仿真</td>
                        <td>哑光米黄17环保皮</td>
                        <td>333</td>
                        <td>1</td>
                        <td></td>
                        <td>
                            <%--<a class="various fancybox.iframe" style="margin-left: 10px;" href="http://www.keyisoft.cn:9200/showImg.aspx?ImageSession=1364180e-6ea2-4859-a0d6-44c9e3be0049" target="_blank">图片</a>--%>
                            <a class="various fancybox.iframe" href="../showImg2.aspx?ImageSession=1465877c-36ac-43b9-a898-4ba5e86886a1">查看图片</a>
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>
    </form>
</body>
</html>
