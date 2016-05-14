(function(win){
    varCLODOP={
        strWebPageID: "C70mt93",
        strTaskID: "",
        strHostURI: "http://localhost:8000",
        VERSION: "6.2.0.3",
        IVERSION: "6203",
        CVERSION: "2.0.4.7",
        iBaseTask: 1,
        timeThreshold: 5,
        Priority: 1,
        blIslocal: true,
        Iframes: [
            
        ],
        ItemDatas: {
            
        },
        PageData: {
            
        },
        defStyleJson: {
            
        },
        PageDataEx: {
            
        },
        ItemCNameStyles: {
            
        },
        blWorking: false,
        blNormalItemAdded: false,
        blTmpSelectedIndex: null,
        Caption: null,
        Color: null,
        CompanyName: null,
        Border: null,
        Inbrowse: null,
        webskt: null,
        SocketEnable: false,
        SocketOpened: false,
        NoClearAfterPrint: false,
        On_Return_Remain: false,
        On_Return: null,
        Result: null,
        iTrySendTimes: 0,
        blOneByone: false,
        Printers: {
            "default": "1",
            "list": [
                {
                    "name": "Microsoft Print to PDF",
                    "DriverName": "Microsoft Print To PDF",
                    "PortName": "PORTPROMPT:",
                    "Orientation": "1",
                    "PaperSize": "9",
                    "PaperLength": "2970",
                    "PaperWidth": "2100",
                    "Copies": "1",
                    "DefaultSource": "15",
                    "PrintQuality": "600",
                    "Color": "2",
                    "Duplex": "1",
                    "FormName": "A4",
                    "Comment": "",
                    "DriverVersion": "1539",
                    "DCOrientation": "90",
                    "MaxExtentWidth": "2970",
                    "MaxExtentLength": "4318",
                    "MinExtentWidth": "1397",
                    "MinExtentlength": "2100",
                    "pagelist": [
                        {
                            "name": "信纸"
                        },
                        {
                            "name": "Tabloid"
                        },
                        {
                            "name": "法律专用纸"
                        },
                        {
                            "name": "Statement"
                        },
                        {
                            "name": "Executive"
                        },
                        {
                            "name": "A3"
                        },
                        {
                            "name": "A4"
                        },
                        {
                            "name": "A5"
                        },
                        {
                            "name": "B4 (JIS)"
                        },
                        {
                            "name": "B5 (JIS)"
                        }
                    ]
                },
                {
                    "name": "\\192.168.1.250\usbprinter1",
                    "DriverName": "EPSON LQ-675KT ESC/P2",
                    "PortName": "\\192.168.1.250\usbprinter1",
                    "Orientation": "1",
                    "PaperSize": "9",
                    "PaperLength": "2970",
                    "PaperWidth": "2100",
                    "Copies": "1",
                    "DefaultSource": "15",
                    "PrintQuality": "180",
                    "Color": "1",
                    "Duplex": "1",
                    "FormName": "A4",
                    "Comment": "",
                    "DriverVersion": "1539",
                    "DCOrientation": "270",
                    "MaxExtentWidth": "2970",
                    "MaxExtentLength": "4200",
                    "MinExtentWidth": "1397",
                    "MinExtentlength": "920",
                    "pagelist": [
                        {
                            "name": "信纸"
                        },
                        {
                            "name": "法律专用纸"
                        },
                        {
                            "name": "Statement"
                        },
                        {
                            "name": "A3"
                        },
                        {
                            "name": "A4"
                        },
                        {
                            "name": "A5"
                        },
                        {
                            "name": "B4 (JIS)"
                        },
                        {
                            "name": "B5 (JIS)"
                        },
                        {
                            "name": "德国标准 Fanfold"
                        },
                        {
                            "name": "德国法律专用纸 Fanfold"
                        },
                        {
                            "name": "信纸 Fanfold 8 1/2 x 11 英寸"
                        },
                        {
                            "name": "A4 Fanfold 210 毫米 x 11 2/3 英寸"
                        },
                        {
                            "name": "Fanfold 210 x 305 毫米"
                        },
                        {
                            "name": "Fanfold 11 x 8 1/2 英寸"
                        },
                        {
                            "name": "6 3/4 信封 6 1/2 x 3 5/8 英寸"
                        },
                        {
                            "name": "信封 #10 9 1/2 x 4 1/8 英寸"
                        },
                        {
                            "name": "信封 DL 220 x 110 毫米"
                        },
                        {
                            "name": "信封 C5 229 x 162 毫米"
                        },
                        {
                            "name": "卡片 148 x 105 毫米"
                        }
                    ]
                }
            ]
        },
        Browser: (function(){
            varua=navigator.userAgent;varisOpera=Object.prototype.toString.call(window.opera)=="[object Opera]";return{
                IE: !!window.attachEvent&&!isOpera,
                Opera: isOpera,
                WebKit: ua.indexOf("AppleWebKit/")>-1,
                Gecko: ua.indexOf("Gecko")>-1&&ua.indexOf("KHTML")===-1,
                MobileSafari: /Apple.*Mobile/.test(ua)
            }
        })(),
        GetTaskID: function(){
            if(!this.strTaskID||this.strTaskID==""){
                vardt=newDate();this.iBaseTask=this.iBaseTask+1;this.strTaskID=""+dt.getHours()+dt.getMinutes()+dt.getSeconds()+"_"+this.iBaseTask;
            };returnthis.strWebPageID+this.strTaskID;
        },
        DoInit: function(){
            this.strTaskID="";if(this.NoClearAfterPrint)return;this.ItemDatas={
                "count": 0
            };this.PageData={
                
            };this.ItemCNameStyles={
                
            };this.defStyleJson={
                "beginpage": 0,
                "beginpagea": 0
            };this.blNormalItemAdded=false;
        },
        OpenWebSocket: function(){
            if(!window.WebSocket)return;this.SocketEnable=true;try{
                if(!this.webskt||this.webskt.readyState==3){
                    if(!window.WebSocket&&window.MozWebSocket)window.WebSocket=window.MozWebSocket;this.webskt=newWebSocket('ws: //127.0.0.1: 8000/c_webskt/');this.webskt.onopen=function(e){
                        CLODOP.SocketOpened=true;
                    };this.webskt.onmessage=function(e){
                        CLODOP.blOneByone=false;varstrResult=e.data;CLODOP.Result=strResult;try{
                            variPos=strResult.indexOf("=");varstrFTaskID=null;if(iPos>=0&&iPos<30){
                                strFTaskID=strResult.slice(0,
                                iPos);strResult=strResult.slice(iPos+1);
                            };if(strFTaskID.indexOf("ErrorMS")>-1){
                                alert(strResult);return;
                            };if(CLODOP.On_Return){
                                if(strResult=="true"||strResult=="false")CLODOP.On_Return(strFTaskID,
                                strResult=="true");elseCLODOP.On_Return(strFTaskID,
                                strResult);if(!CLODOP.On_Return_Remain)CLODOP.On_Return=null;
                            };
                        }catch(err){
                            
                        };
                    };this.webskt.onclose=function(e){
                        if(!CLODOP.SocketOpened){
                            CLODOP.SocketEnable=false;return;
                        };setTimeout(CLODOP.OpenWebSocket(),
                        2000);
                    };this.webskt.onerror=function(e){
                        
                    };
                };
            }catch(err){
                this.webskt=null;setTimeout(CLODOP.OpenWebSocket(),
                2000);
            };
        },
        wsSend: function(strData){
            if(!this.SocketEnable)return;if(this.webskt&&this.webskt.readyState==1){
                this.Result=null;this.iTrySendTimes=0;this.webskt.send(strData);returntrue;
            }else{
                alert("WebSocket没准备好，点确定继续...");this.iTrySendTimes++;if(this.iTrySendTimes<=1)setTimeout(CLODOP.wsSend(strData),
                500);elsethis.OpenWebSocket();
            };
        },
        FORMAT: function(oType,
        oValue){
            if(this.blWorking){
                alert("It's Working... just a moment.");returnnull;
            }vartResult=null;if(oType!==undefined&&oValue!==undefined){
                if(oType.replace(/^\s+|\s+$/g,
                "").toLowerCase().indexOf("time:")==0){
                    oType=oType.replace(/^\s+|\s+$/g,
                    "").slice(5);if(oValue.toLowerCase().indexOf("now")>-1)oValue=(newDate()).toString();if(oValue.toLowerCase().indexOf("date")>-1)oValue=(newDate()).toString();if(oValue.toLowerCase().indexOf("time")>-1)oValue=(newDate()).toString();varTypeYMD="ymd";if(oValue.toLowerCase().indexOf("ymd")>-1){
                        TypeYMD="ymd";oValue=oValue.slice(3);
                    };if(oValue.toLowerCase().indexOf("dmy")>-1){
                        TypeYMD="dmy";oValue=oValue.slice(3);
                    };if(oValue.toLowerCase().indexOf("mdy")>-1){
                        TypeYMD="mdy";oValue=oValue.slice(3);
                    };oValue=oValue.replace(/[
                        ^
                    ]*\+[
                        ^
                        ]*/g,
                    " ");oValue=oValue.replace(/\(.*\)/g,
                    " ");oValue=oValue.replace(/星期日|星期一|星期二|星期三|星期四|星期五|星期六/g,
                    " ");oValue=oValue.replace(/[
                        A-Za-z
                ]+day|Mon|Tue|Wed|Thu|Fri|Sat|Sun/g,
                " ");varaMonth=0;varexp=newRegExp("Oct[A-Za-z]*|十月|10月",
                "i");if(oValue.match(exp)!==null){
                    aMonth=10;oValue=oValue.replace(exp,
                    "");
                };exp=newRegExp("Nov[A-Za-z]*|十一月|11月",
                "i");if(oValue.match(exp)!==null){
                    aMonth=11;oValue=oValue.replace(exp,
                    "");
                };exp=newRegExp("Dec[A-Za-z]*|十二月|12月",
                "i");if(oValue.match(exp)!==null){
                    aMonth=12;oValue=oValue.replace(exp,
                    "");
                };exp=newRegExp("Jan[A-Za-z]*|一月|01月|1月",
                "i");if(oValue.match(exp)!==null){
                    aMonth=1;oValue=oValue.replace(exp,
                    "");
                };exp=newRegExp("Feb[A-Za-z]*|二月|02月|2月",
                "i");if(oValue.match(exp)!==null){
                    aMonth=2;oValue=oValue.replace(exp,
                    "");
                };exp=newRegExp("Mar[A-Za-z]*|三月|03月|3月",
                "i");if(oValue.match(exp)!==null){
                    aMonth=3;oValue=oValue.replace(exp,
                    "");
                };exp=newRegExp("Apr[A-Za-z]*|四月|04月|4月",
                "i");if(oValue.match(exp)!==null){
                    aMonth=4;oValue=oValue.replace(exp,
                    "");
                };exp=newRegExp("May[A-Za-z]*|五月|05月|5月",
                "i");if(oValue.match(exp)!==null){
                    aMonth=5;oValue=oValue.replace(exp,
                    "");
                };exp=newRegExp("Jun[A-Za-z]*|六月|06月|6月",
                "i");if(oValue.match(exp)!==null){
                    aMonth=6;oValue=oValue.replace(exp,
                    "");
                };exp=newRegExp("Jul[A-Za-z]*|七月|07月|7月",
                "i");if(oValue.match(exp)!==null){
                    aMonth=7;oValue=oValue.replace(exp,
                    "");
                };exp=newRegExp("Aug[A-Za-z]*|八月|08月|8月",
                "i");if(oValue.match(exp)!==null){
                    aMonth=8;oValue=oValue.replace(exp,
                    "");
                };exp=newRegExp("Sep[A-Za-z]*|九月|09月|9月",
                "i");if(oValue.match(exp)!==null){
                    aMonth=9;oValue=oValue.replace(exp,
                    "");
                };oValue=oValue.replace(/日|秒/g,
                " ");oValue=oValue.replace(/时|分/g,
                ":");varsubTime=oValue.match(/\d+: \d+: \d+/);if(subTime==null)subTime="";oValue=oValue.replace(/\d+: \d+: \d+/,
                "")+subTime;vardValue=newDate();variYear=0;variMonth=0;variDate=0;variHour=0;variMinutes=0;variSecond=0;vartmpValue=oValue;varsValue="";varMC1=0;MC2=0;MC3=0;sValue=tmpValue.match(/\d+/);if(sValue!==null){
                    MC1=parseInt(sValue[
                        0
                    ]);tmpValue=tmpValue.replace(/\d+/,
                    "");
                };sValue=tmpValue.match(/\d+/);if(sValue!==null){
                    MC2=parseInt(sValue[
                        0
                    ]);tmpValue=tmpValue.replace(/\d+/,
                    "");
                };if(aMonth<=0){
                    sValue=tmpValue.match(/\d+/);if(sValue!==null){
                        MC3=parseInt(sValue[
                            0
                        ]);tmpValue=tmpValue.replace(/\d+/,
                        "");
                    };
                };if(aMonth>0){
                    iMonth=aMonth;if(MC2<=31){
                        iYear=MC1;iDate=MC2;
                    }else{
                        iYear=MC2;iDate=MC1;
                    };
                }elseif(TypeYMD=="dmy"){
                    iDate=MC1;iMonth=MC2;iYear=MC3;
                }elseif(TypeYMD=="mdy"){
                    iMonth=MC1;iDate=MC2;iYear=MC3;
                }else{
                        iYear=MC1;iMonth=MC2;iDate=MC3;if(MC3>31){
                            iYear=MC3;iMonth=MC1;iDate=MC2;if(MC1>12){
                                iDate=MC1;iMonth=MC2
                            };
                        }else{
                            if(MC2>12){
                                iYear=MC2;iMonth=MC1;
                            }
                        };
                };varsValue=tmpValue.match(/\d+/);if(sValue!==null){
                    iHour=parseInt(sValue[
                        0
                    ]);tmpValue=tmpValue.replace(/\d+/,
                    "");
                };varsValue=tmpValue.match(/\d+/);if(sValue!==null){
                    iMinutes=parseInt(sValue[
                        0
                    ]);tmpValue=tmpValue.replace(/\d+/,
                    "");
                };varsValue=tmpValue.match(/\d+/);if(sValue!==null){
                    iSecond=parseInt(sValue[
                        0
                    ]);tmpValue=tmpValue.replace(/\d+/,
                    "");
                };if(oType.toLowerCase()=="isvalidformat")oValue=(iYear>0&&iMonth>0&&iMonth<=12&&iDate>0&&iDate<=31);else{
                    if((""+iYear).length<4)iYear=iYear+2000;dValue.setFullYear(iYear,
                    iMonth-1,
                    iDate);dValue.setHours(iHour);dValue.setMinutes(iMinutes);dValue.setSeconds(iSecond);variDay=dValue.getDay();if(oType.toLowerCase()=="weekindex")oValue=iDay;elseif(oType.toLowerCase()=="floatvalue")oValue=dValue.getTime();else{
                        varsWeek="";switch(iDay){
                        case0: sWeek="日";break;case1: sWeek="一";break;case2: sWeek="二";break;case3: sWeek="三";break;case4: sWeek="四";break;case5: sWeek="五";break;case6: sWeek="六";break;
                };oValue=oType.replace(/dddd/ig,
                "星期"+sWeek);if(/(y+)/i.test(oValue))oValue=oValue.replace(RegExp.$1,
                (iYear+"").substr(4-RegExp.$1.length));if(/(m+: )/i.test(oValue))oValue=oValue.replace(RegExp.$1,
                ("00"+iMinutes+":").substr(("00"+iMinutes+":").length-RegExp.$1.length));if(/(M+)/i.test(oValue)){
                    vardsWidth=(""+iMonth).length>RegExp.$1.length?(""+iMonth).length: RegExp.$1.length;oValue=oValue.replace(RegExp.$1,
                    ("00"+iMonth).substr(("00"+iMonth).length-dsWidth));
                }if(/(d+)/i.test(oValue)){
                    vardsWidth=(""+iDate).length>RegExp.$1.length?(""+iDate).length: RegExp.$1.length;oValue=oValue.replace(RegExp.$1,
                    ("00"+iDate).substr(("00"+iDate).length-dsWidth));
                }if(/(H+)/i.test(oValue))oValue=oValue.replace(RegExp.$1,
                ("00"+iHour).substr(("00"+iHour).length-RegExp.$1.length));if(/(n+)/i.test(oValue))oValue=oValue.replace(RegExp.$1,
                ("00"+iMinutes).substr(("00"+iMinutes).length-RegExp.$1.length));if(/(s+)/i.test(oValue))oValue=oValue.replace(RegExp.$1,
                ("00"+iSecond).substr(("00"+iSecond).length-RegExp.$1.length));
            }
        }if(CLODOP.On_Return){
                        CLODOP.On_Return(0,
                        oValue);CLODOP.On_Return=null;
};returnoValue;
}elseif(this.blIslocal||oType.indexOf("FILE:")<0){
    this.PageData[
        "format_type"
    ]=oType;this.PageData[
        "format_value"
    ]=oValue;if(this.DoPostDatas("format")==true){
        this.GetLastResult(false);tResult=this.GetTaskID();
    };
}elsealert("不能远程读写文件!");
};this.DoInit();this.blWorking=false;returntResult;
},
SET_PRINT_PAPER: function(Top,
Left,
Width,
Height,
strPrintTask){
    returnthis.PRINT_INITA(Top,
    Left,
    Width,
    Height,
    strPrintTask);
},
PRINT_INIT: function(strPrintTask){
    returnthis.PRINT_INITA(null,
    null,
    null,
    null,
    strPrintTask);
},
PRINT_INITA: function(Top,
Left,
Width,
Height,
strPrintTask){
    if(Top===undefined||Top===null)Top="";if(Left===undefined||Left===null)Left="";if(Width===undefined||Width===null)Width="";if(Height===undefined||Height===null)Height="";if(strPrintTask===undefined||strPrintTask===null)strPrintTask="";this.NoClearAfterPrint=false;this.DoInit();this.PageData[
        "top"
    ]=Top;this.PageData[
        "left"
    ]=Left;this.PageData[
        "width"
    ]=Width;this.PageData[
        "height"
    ]=Height;this.PageData[
        "printtask"
    ]=strPrintTask;
},
SET_PRINT_MODE: function(strModeType,
ModeValue){
    if(strModeType===undefined||strModeType===null)strModeType="";if(ModeValue===undefined||ModeValue===null)ModeValue="";if(strModeType==="")returnfalse;strModeType=strModeType.toLowerCase();this.PageData[
        strModeType
    ]=ModeValue;if(strModeType=="noclear_after_print")this.NoClearAfterPrint=ModeValue;if(strModeType.indexOf("window_def")>-1||strModeType.indexOf("control_printer")>-1){
        vartResult=null;if(this.DoPostDatas("onlysetprint")==true){
            this.GetLastResult(false);tResult=this.GetTaskID();
        };this.DoInit();this.blWorking=false;returntResult;
    };
},
ADD_PRINT_TEXT: function(top,
left,
width,
height,
strText){
    returnthis.AddItemArray(2,
    top,
    left,
    width,
    height,
    strText);
},
ADD_PRINT_TEXTA: function(itemName,
top,
left,
width,
height,
strText){
    returnthis.AddItemArray(2,
    top,
    left,
    width,
    height,
    strText,
    itemName);
},
ADD_PRINT_HTM: function(top,
left,
width,
height,
strHTML){
    returnthis.AddItemArray(4,
    top,
    left,
    width,
    height,
    strHTML);
},
ADD_PRINT_HTML: function(top,
left,
width,
height,
strHTML){
    returnthis.AddItemArray(1,
    top,
    left,
    width,
    height,
    strHTML);
},
ADD_PRINT_HTMLA: function(itemName,
top,
left,
width,
height,
strHTML){
    returnthis.AddItemArray(1,
    top,
    left,
    width,
    height,
    strHTML,
    itemName);
},
ADD_PRINT_BARCODE: function(top,
left,
width,
height,
BarType,
BarValue){
    returnthis.AddItemArray(9,
    top,
    left,
    width,
    height,
    BarValue,
    null,
    null,
    null,
    null,
    null,
    null,
    BarType);
},
ADD_PRINT_BARCODEA: function(ItemName,
top,
left,
width,
height,
BarType,
BarValue){
    returnthis.AddItemArray(9,
    top,
    left,
    width,
    height,
    BarValue,
    ItemName,
    null,
    null,
    null,
    null,
    null,
    BarType);
},
ADD_PRINT_RECTA: function(top,
left,
width,
height,
intPenStyle,
intPenWidth,
intColor){
    returnthis.AddItemArray(3,
    top,
    left,
    width,
    height,
    null,
    null,
    2,
    intPenStyle,
    intPenWidth,
    intColor,
    null);
},
ADD_PRINT_RECT: function(top,
left,
width,
height,
intPenStyle,
intPenWidth){
    returnthis.AddItemArray(3,
    top,
    left,
    width,
    height,
    null,
    null,
    2,
    intPenStyle,
    intPenWidth,
    null,
    null);
},
ADD_PRINT_ELLIPSEA: function(top,
left,
width,
height,
intPenStyle,
intPenWidth,
intColor){
    returnthis.AddItemArray(3,
    top,
    left,
    width,
    height,
    null,
    null,
    3,
    intPenStyle,
    intPenWidth,
    intColor,
    null);
},
ADD_PRINT_ELLIPSE: function(top,
left,
width,
height,
intPenStyle,
intPenWidth){
    returnthis.AddItemArray(3,
    top,
    left,
    width,
    height,
    null,
    null,
    3,
    intPenStyle,
    intPenWidth,
    null,
    null);
},
ADD_PRINT_SHAPE: function(ShapeType,
top,
left,
width,
height,
intPenStyle,
intPenWidth,
intColor){
    returnthis.AddItemArray(3,
    top,
    left,
    width,
    height,
    null,
    null,
    ShapeType,
    intPenStyle,
    intPenWidth,
    intColor,
    null);
},
ADD_PRINT_LINE: function(top1,
left1,
top2,
left2,
intPenStyle,
intPenWidth){
    returnthis.AddItemArray(3,
    top1,
    left1,
    top2,
    left2,
    null,
    null,
    0,
    intPenStyle,
    intPenWidth,
    null,
    "1");
},
ADD_PRINT_DNLINE: function(Top,
Left,
Width,
Height,
intPenStyle,
intPenWidth){
    returnthis.AddItemArray(3,
    Top,
    Left,
    Width,
    Height,
    null,
    null,
    1,
    intPenStyle,
    intPenWidth,
    null,
    null);
},
ADD_PRINT_DNLINEA: function(Top,
Left,
Width,
Height,
intPenStyle,
intPenWidth,
intColor){
    returnthis.AddItemArray(3,
    Top,
    Left,
    Width,
    Height,
    null,
    null,
    1,
    intPenStyle,
    intPenWidth,
    intColor,
    null);
},
ADD_PRINT_UPLINE: function(Top,
Left,
Width,
Height,
intPenStyle,
intPenWidth){
    returnthis.AddItemArray(3,
    Top,
    Left,
    Width,
    Height,
    null,
    null,
    0,
    intPenStyle,
    intPenWidth,
    null,
    null);
},
ADD_PRINT_UPLINEA: function(Top,
Left,
Width,
Height,
intPenStyle,
intPenWidth,
intColor){
    returnthis.AddItemArray(3,
    Top,
    Left,
    Width,
    Height,
    null,
    null,
    0,
    intPenStyle,
    intPenWidth,
    intColor,
    null);
},
ADD_PRINT_TABLE: function(top,
left,
width,
height,
strHTML){
    returnthis.AddItemArray(6,
    top,
    left,
    width,
    height,
    strHTML);
},
ADD_PRINT_TBURL: function(top,
left,
width,
height,
strURL){
    returnthis.AddItemArray(7,
    top,
    left,
    width,
    height,
    strURL);
},
ADD_PRINT_URL: function(top,
left,
width,
height,
strURL){
    returnthis.AddItemArray(5,
    top,
    left,
    width,
    height,
    strURL);
},
ADD_PRINT_IMAGE: function(top,
left,
width,
height,
strHTML){
    returnthis.AddItemArray(8,
    top,
    left,
    width,
    height,
    strHTML);
},
ADD_PRINT_CHART: function(top,
left,
width,
height,
strChartTypess,
strHTML){
    returnthis.AddItemArray(10,
    top,
    left,
    width,
    height,
    strHTML,
    null,
    null,
    null,
    null,
    null,
    null,
    null,
    strChartTypess);
},
SET_PRINT_PROPERTY: function(ItemNO,
intPageType,
intHorzOrient,
intVertOrient){
    this.SET_PRINT_STYLEA(ItemNO,
    "ItemType",
    intPageType);this.SET_PRINT_STYLEA(ItemNO,
    "HOrient",
    intHorzOrient);this.SET_PRINT_STYLEA(ItemNO,
    "VOrient",
    intVertOrient);
},
SET_PRINT_PROPERTYA: function(ItemName,
intPageType,
intHorzOrient,
intVertOrient){
    this.SET_PRINT_PROPERTY(ItemName,
    intPageType,
    intHorzOrient,
    intVertOrient);
},
SET_PRINT_STYLE: function(strStyleName,
StyleValue){
    if(strStyleName===undefined||strStyleName===null)strStyleName="";if(StyleValue===undefined||StyleValue===null)StyleValue="";if(strStyleName==="")returnfalse;strStyleName=strStyleName.toLowerCase();this.defStyleJson[
        strStyleName
    ]=StyleValue;
},
SET_PRINT_STYLEA: function(ItemNo,
strKey,
Value){
    if(ItemNo===undefined||ItemNo===null)ItemNo="";if(strKey===undefined||strKey===null)strKey="";if(Value===undefined||Value===null)Value="";if(ItemNo===""||strKey==="")returnfalse;if(this.ItemDatas[
        "count"
    ]<=0){
        if(this.PageData[
            "add_print_program_data"
        ]!==undefined){
            this.ItemCNameStyles[
                strKey.toLowerCase()+"-"+ItemNo
            ]=Value;returntrue;
        }else{
            returnfalse;
        };
    };strKey=strKey.toLowerCase();if(strKey=="type")returnfalse;varblResult=false;if(ItemNo==0){
        ItemNo=this.ItemDatas[
            "count"
        ];
    }for(varvItemNOinthis.ItemDatas){
        varItemName=this.ItemDatas[
            vItemNO
    ][
            "itemname"
    ];if((ItemNo==vItemNO)||(ItemNo==ItemName)||((typeofItemNo==="string")&&(typeofItemName==="string")&&(ItemNo.toUpperCase()==ItemName.toUpperCase()))){
            this.ItemDatas[
                vItemNO
    ][
                strKey
    ]=Value;blResult=true;
    };
};if(blResult)returntrue;returnfalse;
},
SET_PRINT_TEXT_STYLE: function(ItemNO,
strFontName,
intSize,
intBold,
intItalic,
intUnderline,
intAlignment){
    this.SET_PRINT_STYLEA(ItemNO,
    "fontname",
    strFontName);this.SET_PRINT_STYLEA(ItemNO,
    "fontsize",
    intSize);this.SET_PRINT_STYLEA(ItemNO,
    "bold",
    intBold);this.SET_PRINT_STYLEA(ItemNO,
    "italic",
    intItalic);this.SET_PRINT_STYLEA(ItemNO,
    "underline",
    intUnderline);this.SET_PRINT_STYLEA(ItemNO,
    "alignment",
    intAlignment);
},
SET_PRINT_TEXT_STYLEA: function(ItemNO,
strFontName,
intSize,
intBold,
intItalic,
intUnderline,
intAlignment,
Color){
    this.SET_PRINT_TEXT_STYLE(ItemNO,
    strFontName,
    intSize,
    intBold,
    intItalic,
    intUnderline,
    intAlignment);this.SET_PRINT_STYLEA(ItemNO,
    "fontcolor",
    Color);
},
SET_PRINT_TEXT_STYLEB: function(ItemNO,
strFontName,
intSize,
intBold,
intItalic,
intUnderline,
intAlignment,
Color){
    this.SET_PRINT_TEXT_STYLEA(ItemNO,
    strFontName,
    intSize,
    intBold,
    intItalic,
    intUnderline,
    intAlignment,
    Color);
},
NEWPAGE: function(){
    this.NewPage();
},
NewPage: function(){
    varblSomeNormal=false;varnoItemType;for(varvItemNOinthis.ItemDatas){
        if(vItemNO=="count")noItemType=false;elsenoItemType=true;for(varvItemxxinthis.ItemDatas[
            vItemNO
    ]){
            if(vItemxx=="itemtype"){
                noItemType=false;if((this.ItemDatas[
                    vItemNO
    ][
                    vItemxx
    ]==0)||(this.ItemDatas[
                    vItemNO
    ][
                    vItemxx
    ]==4)){
                    blSomeNormal=true;break;
    };
};
};if(noItemType)blSomeNormal=true;if(blSomeNormal)break;
};if(blSomeNormal)this.defStyleJson[
    "beginpage"
]=this.defStyleJson[
    "beginpage"
]+1;
},
NEWPAGEA: function(){
    this.NewPageA();
},
NewPageA: function(){
    varblSomeNormal=false;varnoItemType;for(varvItemNOinthis.ItemDatas){
        if(vItemNO=="count")noItemType=false;elsenoItemType=true;for(varvItemxxinthis.ItemDatas[
            vItemNO
    ]){
            if(vItemxx=="itemtype"){
                noItemType=false;if((this.ItemDatas[
                    vItemNO
    ][
                    vItemxx
    ]==0)||(this.ItemDatas[
                    vItemNO
    ][
                    vItemxx
    ]==4)){
                    blSomeNormal=true;break;
    };
};
};if(noItemType)blSomeNormal=true;if(blSomeNormal)break;
};if(blSomeNormal)this.defStyleJson[
    "beginpagea"
]=this.defStyleJson[
    "beginpagea"
]+1;
},
PREVIEW: function(sView,
iW,
iH){
    if(this.blWorking){
        alert("It's Working... just a moment.");returnnull;
    }vartResult=null;if((!sView)&&(this.blIslocal)){
        if(this.DoPostDatas("preview")==true){
            this.Result=null;this.GetLastResult(true);tResult=this.GetTaskID();
        };
    }else{
        if(this.DoPostDatas("cpreview")==true){
            this.DoCPreview(sView,
            iW,
            iH);tResult=this.GetTaskID();
        };
    };this.DoInit();this.blWorking=false;returntResult;
},
PRINT: function(sView,
iW,
iH){
    if(this.blWorking){
        alert("It's Working... just a moment.");returnnull;
    }vartResult=null;if(this.DoPostDatas("print")==true)tResult=this.GetTaskID();this.DoInit();this.blWorking=false;returntResult;
},
GET_PRINTER_COUNT: function(){
    if(this.Printers===undefined)return0;else{
        returnthis.Printers[
            "list"
        ].length;
    };
},
GET_PRINTER_NAME: function(intNO){
    if(this.Printers===undefined)return"";else{
        if(typeofintNO=="string"&&intNO.indexOf(":")>-1){
            varstrPPname=intNO.slice(intNO.indexOf(":")+1);intNO=intNO.slice(0,
            intNO.indexOf(":"));if(intNO==-1)returnthis.Printers[
                "list"
            ][
                this.Printers[
                    "default"
            ]
            ][
                strPPname
            ];elsereturnthis.Printers[
                "list"
            ][
                intNO
            ][
                strPPname
            ];
        }else{
            if(intNO==-1)returnthis.Printers[
                "list"
            ][
                this.Printers[
                    "default"
            ]
            ].name;elseif(intNO>=0&&intNO<this.Printers[
                "list"
            ].length)returnthis.Printers[
                "list"
            ][
                intNO
            ].name;elsereturn"Printer NO. overflow";
        };
    };
},
GET_PAGESIZES_LIST: function(PNameInx,
Split){
    if(this.Printers===undefined)return"";else{
        if(PNameInx==-1)PNameInx=this.Printers[
            "list"
        ][
            this.Printers[
                "default"
        ]
        ].name;for(varintNOinthis.Printers[
            "list"
        ]){
            if(PNameInx==intNO||PNameInx==this.Printers[
                "list"
        ][
                intNO
        ].name){
                varstrList="";for(variPNOinthis.Printers[
                    "list"
        ][
                    intNO
        ][
                    "pagelist"
        ]){
                    if(strList==="")strList=this.Printers[
                        "list"
        ][
                        intNO
        ][
                        "pagelist"
        ][
                        iPNO
        ].name;elsestrList=strList+Split+this.Printers[
                        "list"
        ][
                        intNO
        ][
                        "pagelist"
        ][
                        iPNO
        ].name;
        };returnstrList;
};
};return"";
};
},
SET_PRINTER_INDEX: function(strName){
    if(this.Printers===undefined)returnfalse;else{
        if(strName==-1)this.PageData[
            "printerindex"
        ]=this.Printers[
            "default"
        ];else{
            for(varvNOinthis.Printers[
                "list"
            ]){
                if((this.Printers[
                    "list"
            ][
                    vNO
            ].name==strName)||(vNO==strName)){
                    this.PageData[
                        "printerindex"
            ]=vNO;returntrue;
            };
    };returnfalse;
};
};
},
SET_PRINTER_INDEXA: function(strName){
    returnthis.SET_PRINTER_INDEX(strName);
},
PRINT_DESIGN: function(){
    if(this.blWorking){
        alert("It's Working... just a moment.");returnnull;
    }vartResult=null;if(this.blIslocal){
        if(this.DoPostDatas("print_design")==true){
            this.Result=null;this.GetLastResult(true);tResult=this.GetTaskID();
        };
    }elsealert("不能远程打印设计!");this.DoInit();this.blWorking=false;returntResult;
},
PRINT_SETUP: function(){
    if(this.blWorking){
        alert("It's Working... just a moment.");returnnull;
    }vartResult=null;if(this.blIslocal){
        if(this.DoPostDatas("print_setup")==true){
            this.Result=null;this.GetLastResult(true);tResult=this.GetTaskID();
        };
    }elsealert("不能远程打印维护!");this.DoInit();this.blWorking=false;returntResult;
},
SET_PRINT_PAGESIZE: function(intOrient,
PageWidth,
PageHeight,
strPageName){
    if(intOrient!==undefined&&intOrient!==null)this.PageData[
        "orient"
    ]=intOrient;if(PageWidth!==undefined&&PageWidth!==null)this.PageData[
        "pagewidth"
    ]=PageWidth;if(PageHeight!==undefined&&PageHeight!==null)this.PageData[
        "pageheight"
    ]=PageHeight;if(strPageName!==undefined&&strPageName!==null)this.PageData[
        "pagename"
    ]=strPageName;
},
SET_PRINT_COPIES: function(intCopies){
    if(intCopies!==undefined&&intCopies!==null){
        this.PageData[
            "printcopies"
        ]=intCopies;returntrue;
    };
},
SELECT_PRINTER: function(blPrint){
    this.SelectBox.create(388,
    240,
    !blPrint);returntrue;
},
PRINTA: function(blPrintB,
sView){
    if(this.blWorking){
        alert("It's Working... just a moment.");returnnull;
    }vartResult=null;if(!sView&&this.blIslocal){
        this.Result=null;if(blPrintB){
            if(this.DoPostDatas("printb")==true){
                this.GetLastResult(false);tResult=this.GetTaskID();
            };
        }else{
            if(this.DoPostDatas("printa")==true){
                this.GetLastResult(true);tResult=this.GetTaskID();
            };
        };this.DoInit();this.blWorking=false;
    }else{
        this.SELECT_PRINTER(true);
    };returntResult;
},
PRINTAOK: function(iPrintIndex,
iPrintCopies,
iStartNO,
iEndNO,
onlySelect){
    this.SET_PRINTER_INDEX(iPrintIndex);this.SET_PRINT_COPIES(iPrintCopies);if(iStartNO!==undefined&&iStartNO!==0)this.SET_PRINT_MODE("PRINT_START_PAGE",
    iStartNO);if(iEndNO!==undefined&&iEndNO!==0)this.SET_PRINT_MODE("PRINT_END_PAGE",
    iEndNO);if(!onlySelect)this.PRINT();else{
        this.blTmpSelectedIndex=iPrintIndex;if(CLODOP.On_Return){
            CLODOP.On_Return(0,
            iPrintIndex);if(!CLODOP.On_Return_Remain)CLODOP.On_Return=null;
        };
    };
},
SET_LICENSES: function(strCompanyName,
strLicense,
strLicenseA,
strLicenseB){
    if((strCompanyName=='THIRDLICENSE')&&(strLicense=="")){
        if(strLicenseA&&strLicenseA!=="")this.PageDataEx[
            "licensec"
        ]=strLicenseA;if(strLicenseB&&strLicenseB!=="")this.PageDataEx[
            "licensed"
        ]=strLicenseB;
    }elseif((strCompanyName=='LICENSETETCODE')&&(strLicense=="")&&(strLicenseB=="")){
        if(strLicenseA&&strLicenseA!=="")this.PageDataEx[
            "Licensetetcode"
        ]=strLicenseA;
    }else{
        if(strCompanyName&&strCompanyName!=="")this.PageDataEx[
            "companyname"
        ]=strCompanyName;if(strLicense&&strLicense!=="")this.PageDataEx[
            "license"
        ]=strLicense;if(strLicenseA&&strLicenseA!=="")this.PageDataEx[
            "licensea"
        ]=strLicenseA;if(strLicenseB&&strLicenseB!=="")this.PageDataEx[
            "licenseb"
        ]=strLicenseB;
};
},
PRINTB: function(){
    this.PRINTA(true);
},
PREVIEWA: function(){
    this.PREVIEW();
},
PREVIEWB: function(){
    this.PREVIEW();
},
ADD_PRINT_SETUP_BKIMG: function(strContent){
    if(strContent!==undefined&&strContent!==null){
        this.PageData[
            "setup_bkimg"
        ]=strContent;returntrue;
    };
},
SET_PREVIEW_WINDOW: function(intDispMode,
intToolMode,
blDirectPrint,
oWidth,
oHeight,
strPButtonCaptoin){
    if(intDispMode!==undefined&&intDispMode!==null)this.PageData[
        "pvw_dispmode"
    ]=intDispMode;if(intToolMode!==undefined&&intToolMode!==null)this.PageData[
        "pvw_toolmode"
    ]=intToolMode;if(blDirectPrint!==undefined&&blDirectPrint!==null)this.PageData[
        "pvw_directprint"
    ]=blDirectPrint;if(oWidth!==undefined&&oWidth!==null)this.PageData[
        "pvw_width"
    ]=oWidth;if(oHeight!==undefined&&oHeight!==null)this.PageData[
        "pvw_height"
    ]=oHeight;if(strPButtonCaptoin!==undefined&&strPButtonCaptoin!==null)this.PageData[
        "pvw_puttoncaptoin"
    ]=strPButtonCaptoin;
},
SET_PREVIEW_MODE: function(ModeValue){
    if(ModeValue!==undefined)this.PageData[
        "pvw_preview_mode"
    ]=ModeValue;
},
SET_SHOW_MODE: function(strModeType,
ModeValue){
    if(strModeType===undefined||strModeType===null)strModeType="";if(ModeValue===undefined||ModeValue===null)ModeValue="";if(strModeType==="")returnfalse;strModeType=strModeType.toLowerCase();this.PageData[
        'shwmod_'+strModeType
    ]=ModeValue;
},
SAVE_TO_FILE: function(strFileName){
    if(this.blWorking){
        alert("It's Working... just a moment.");returnnull;
    }vartResult=null;if(this.blIslocal){
        if(strFileName){
            this.PageData[
                "stf_file_name"
            ]=strFileName;if(this.DoPostDatas("savetofile")==true){
                this.GetLastResult(false);tResult=this.GetTaskID();
            };
        };
    }elsealert("不能远程写文件!");this.DoInit();this.blWorking=false;returntResult;
},
SET_SAVE_MODE: function(strModeType,
ModeValue){
    if(strModeType===undefined||strModeType===null)strModeType="";if(ModeValue===undefined||ModeValue===null)ModeValue="";if(strModeType==="")returnfalse;strModeType=strModeType.toLowerCase();this.PageData[
        'stfmod_'+strModeType
    ]=ModeValue;
},
SEND_PRINT_RAWDATA: function(strRawData){
    if(this.blWorking){
        alert("It's Working... just a moment.");returnnull;
    }vartResult=null;if(strRawData!==undefined){
        this.PageData[
            "raw_print_data"
        ]=strRawData;if(this.DoPostDatas("sendrawdata")==true){
            this.GetLastResult(false);tResult=this.GetTaskID();
        };
    };this.DoInit();this.blWorking=false;returntResult;
},
WRITE_FILE_TEXT: function(WriteMode,
strFileName,
strText){
    if(this.blWorking){
        alert("It's Working... just a moment.");returnnull;
    }vartResult=null;if(this.blIslocal){
        if(strFileName!==undefined&&strText!==undefined){
            this.PageData[
                "write_file_mode"
            ]=WriteMode;this.PageData[
                "write_file_name"
            ]=strFileName;this.PageData[
                "write_file_text"
            ]=strText;if(this.DoPostDatas("writefiletext")==true){
                this.GetLastResult(false);tResult=this.GetTaskID();
            };
        };
    }elsealert("不能远程写文件!");this.DoInit();this.blWorking=false;returntResult;
},
GET_DIALOG_VALUE: function(oType,
oPreValue){
    if(this.blWorking){
        alert("It's Working... just a moment.");returnnull;
    }vartResult=null;if(oType!==undefined&&oPreValue!==undefined){
        if(this.blIslocal){
            this.PageData[
                "dialog_type"
            ]=oType;this.PageData[
                "dialog_value"
            ]=oPreValue;if(this.DoPostDatas("dialog")==true){
                this.GetLastResult(true);tResult=this.GetTaskID();
            };
        }elsealert("不能远程读写文件!");
    };this.DoInit();this.blWorking=false;returntResult;
},
WRITE_PORT_DATA: function(strPortName,
strData){
    if(this.blWorking){
        alert("It's Working... just a moment.");returnnull;
    }vartResult=null;if(strPortName!==undefined&&strData!==undefined){
        this.PageData[
            "write_port_name"
        ]=strPortName;this.PageData[
            "write_port_data"
        ]=strData;if(this.DoPostDatas("writeportdata")==true){
            this.GetLastResult(false);tResult=this.GetTaskID();
        };
    };this.DoInit();this.blWorking=false;returntResult;
},
READ_PORT_DATA: function(strPortName){
    if(this.blWorking){
        alert("It's Working... just a moment.");returnnull;
    }vartResult=null;if(strPortName!==undefined){
        this.PageData[
            "read_port_name"
        ]=strPortName;if(this.DoPostDatas("readportdata")==true){
            this.GetLastResult(false);tResult=this.GetTaskID();
        };
    };this.DoInit();this.blWorking=false;returntResult;
},
GET_SYSTEM_INFO: function(InfoType){
    if(this.blWorking){
        alert("It's Working... just a moment.");returnnull;
    }vartResult=null;if(InfoType!==undefined){
        this.PageData[
            "system_info_type"
        ]=InfoType;if(this.DoPostDatas("getsysteminfo")==true){
            this.GetLastResult(false);tResult=this.GetTaskID();
        };
    };this.DoInit();this.blWorking=false;returntResult;
},
GET_FILE_TEXT: function(strFileName){
    if(this.blWorking){
        alert("It's Working... just a moment.");returnnull;
    }vartResult=null;if(this.blIslocal){
        if(strFileName!==undefined){
            this.PageData[
                "get_file_name"
            ]=strFileName;if(this.DoPostDatas("getfiletext")==true){
                this.GetLastResult(false);tResult=this.GetTaskID();
            };
        };
    }elsealert("不能远程读文件!");this.DoInit();this.blWorking=false;returntResult;
},
IS_FILE_EXIST: function(strFileName){
    if(this.blWorking){
        alert("It's Working... just a moment.");returnnull;
    }vartResult=null;if(this.blIslocal){
        if(strFileName!==undefined){
            this.PageData[
                "file_exist_name"
            ]=strFileName;if(this.DoPostDatas("isfileexist")==true){
                this.GetLastResult(false);tResult=this.GetTaskID();
            };
        };
    }elsealert("不能远程读文件!");this.DoInit();this.blWorking=false;returntResult;
},
GET_FILE_TIME: function(strFileName){
    if(this.blWorking){
        alert("It's Working... just a moment.");returnnull;
    }vartResult=null;if(this.blIslocal){
        if(strFileName!==undefined){
            this.PageData[
                "file_time_name"
            ]=strFileName;if(this.DoPostDatas("getfiletime")==true){
                this.GetLastResult(false);tResult=this.GetTaskID();
            };
        };
    }elsealert("不能远程读文件!");this.DoInit();this.blWorking=false;returntResult;
},
GET_PRINT_INIFFNAME: function(strPrintTaskName){
    if(this.blWorking){
        alert("It's Working... just a moment.");returnnull;
    }vartResult=null;if(this.blIslocal){
        if(strPrintTaskName!==undefined){
            this.PageData[
                "iniff_task_name"
            ]=strPrintTaskName;if(this.DoPostDatas("getiniffname")==true){
                this.GetLastResult(false);tResult=this.GetTaskID();
            };
        };
    }elsealert("不能远程读文件!");this.DoInit();this.blWorking=false;returntResult;
},
GET_VALUE: function(ValueType,
ValueIndex){
    if(this.blWorking){
        alert("It's Working... just a moment.");returnnull;
    }vartResult=null;if(ValueType!==undefined&&ValueIndex!==undefined){
        this.PageData[
            "get_value_type"
        ]=ValueType;this.PageData[
            "get_value_index"
        ]=ValueIndex;if(this.DoPostDatas("dogetvalue")==true){
            this.GetLastResult(false);tResult=this.GetTaskID();
        };
    };this.DoInit();this.blWorking=false;returntResult;
},
ADD_PRINT_DATA: function(DataType,
oValue){
    if(DataType!==undefined&&oValue!==null){
        if(DataType.toLowerCase().indexOf("programdata")>-1){
            this.PageData[
                "add_print_program_data"
            ]=oValue;returntrue;
        };
    };
},
SHOW_CHART: function(){
            
},
DO_ACTION: function(){
            
},
Create_Printer_List: function(oElement){
    while(oElement.childNodes.length>0){
        varchildren=oElement.childNodes;for(vari=0;i<children.length;i++)oElement.removeChild(children[
            i
        ]);
    };variCount=this.GET_PRINTER_COUNT();for(vari=0;i<iCount;i++){
        varoption=document.createElement('option');option.innerHTML=this.GET_PRINTER_NAME(i);option.value=i;oElement.appendChild(option);
    };
},
Create_PageSize_List: function(oElement,
printIndex){
    while(oElement.childNodes.length>0){
        varchildren=oElement.childNodes;for(vari=0;i<children.length;i++)oElement.removeChild(children[
            i
        ]);
    };varstrPageSizeList=CLODOP.GET_PAGESIZES_LIST(printIndex,
    "\n");varOptions=newArray();Options=strPageSizeList.split("\n");for(variinOptions){
        varoption=document.createElement('option');option.innerHTML=Options[
            i
    ];option.value=Options[
            i
    ];oElement.appendChild(option);
    };
},
AddItemArray: function(type,
top,
left,
width,
height,
strContent,
itemname,
ShapeType,
intPenStyle,
intPenWidth,
intColor,
isLinePosition,
BarType,
strChartTypess){
    if(top===undefined||left===undefined||width===undefined||height===undefined||strContent===undefined){
        returnfalse;
    };varsCount=this.ItemDatas[
        "count"
    ];sCount++;varoneItem={
                
    };for(varvstyleinthis.defStyleJson){
        oneItem[
            vstyle
    ]=this.defStyleJson[
            vstyle
    ];
    };oneItem[
        "type"
    ]=type;oneItem[
        "top"
    ]=top;oneItem[
        "left"
    ]=left;oneItem[
        "width"
    ]=width;oneItem[
        "height"
    ]=height;if((strContent!==undefined)&&(strContent!=null))oneItem[
        "content"
    ]=strContent;if((itemname!==undefined)&&(itemname!=null))oneItem[
        "itemname"
    ]=itemname+"";if((ShapeType!==undefined)&&(ShapeType!=null))oneItem[
        "shapetype"
    ]=ShapeType;if((intPenStyle!==undefined)&&(intPenStyle!=null))oneItem[
        "penstyle"
    ]=intPenStyle;if((intPenWidth!==undefined)&&(intPenWidth!=null))oneItem[
        "penwidth"
    ]=intPenWidth;if((intColor!==undefined)&&(intColor!=null))oneItem[
        "fontcolor"
    ]=intColor;if((isLinePosition!==undefined)&&(isLinePosition!=null))oneItem[
        "lineposition"
    ]="1";if((BarType!==undefined)&&(BarType!=null))oneItem[
        "fontname"
    ]=BarType;if((strChartTypess!==undefined)&&(strChartTypess!=null))oneItem[
        "charttypess"
    ]=strChartTypess;oneItem[
        "beginpage"
    ]=this.defStyleJson[
        "beginpage"
    ];oneItem[
        "beginpagea"
    ]=this.defStyleJson[
        "beginpagea"
    ];this.ItemDatas[
        "count"
    ]=sCount;this.ItemDatas[
        sCount
    ]=oneItem;this.blNormalItemAdded=true;returntrue;
},
RemoveIframes: function(){
    varobody=document.body||document.getElementsByTagName("body")[
        0
    ]||document.documentElement;try{
        for(vari=0;i<this.Iframes.length;i++){
            varnow=(newDate()).getTime();if((now-this.Iframes[
                i
            ][
                "time"
            ])>this.timeThreshold*60000){
                obody.removeChild(this.Iframes[
                    i
                ][
                    "iframe"
                ]);this.Iframes.splice(i,
                1);
            };
        };
    }catch(err){
                
    };
},
AddInputElement: function(odocument,
oform,
name,
value){
    if(value!==undefined){
        varoinput=odocument.createElement("input");oinput.name=name;oinput.type="hidden";oinput.value=value;oform.appendChild(oinput);
    };
},
wsDoPostDatas: function(afterPostAction){
    varstrData="charset=丂\f";strData=strData+"tid="+this.GetTaskID()+"\f";strData=strData+"act="+afterPostAction+"\f";strData=strData+"browseurl="+window.location.href+"\f";for(varvModeinthis.PageDataEx){
        strData=strData+vMode+"="+this.PageDataEx[
            vMode
    ]+"\f";
    };varPrintModeNamess="";for(varvModeinthis.PageData){
        strData=strData+vMode+"="+this.PageData[
            vMode
    ]+"\f";PrintModeNamess=PrintModeNamess+";"+vMode;
    };if(PrintModeNamess!=="")strData=strData+"printmodenames="+PrintModeNamess+"\f";varStyleClassNamess="";for(varvClassStyleinthis.ItemCNameStyles){
        strData=strData+vClassStyle+"="+this.ItemCNameStyles[
            vClassStyle
    ]+"\f";StyleClassNamess=StyleClassNamess+";"+vClassStyle;
    };if(StyleClassNamess!=="")strData=strData+"printstyleclassnames="+StyleClassNamess+"\f";strData=strData+"itemcount="+this.ItemDatas[
        "count"
    ]+"\f";for(varvItemNOinthis.ItemDatas){
        varItemStyless="";for(varvItemxxinthis.ItemDatas[
            vItemNO
    ]){
            strData=strData+vItemNO+"_"+vItemxx+"="+this.ItemDatas[
                vItemNO
    ][
                vItemxx
    ]+"\f";if(vItemxx!="beginpage"&&vItemxx!="beginpagea"&&vItemxx!="type"&&vItemxx!="top"&&vItemxx!="left"&&vItemxx!="width"&&vItemxx!="height")ItemStyless=ItemStyless+";"+vItemxx;
    };strData=strData+vItemNO+"_itemstylenames"+"="+ItemStyless+"\f";
    };this.wsSend("post:"+strData);returntrue;
    },
        DoPostDatas: function(afterPostAction){
    try{
        if(this.blOneByone==true){
            alert("有窗口已打开,先关闭它(持续如此时请刷新页面)!");returnfalse;
    };this.blWorking=true;if(this.blTmpSelectedIndex!==null)this.SET_PRINTER_INDEX(this.blTmpSelectedIndex);if(this.SocketEnable){
            returnthis.wsDoPostDatas(afterPostAction);
    };this.RemoveIframes();varobody=document.body||document.getElementsByTagName("body")[
            0
    ]||document.documentElement;varoiframe=document.createElement("iframe");oiframe.setAttribute("src",
        "about:blank");oiframe.setAttribute("style",
        "display:none");oiframe.height=0;obody.appendChild(oiframe);varcontentdocument=oiframe.contentWindow.document;contentdocument.write("<form action='"+this.strHostURI+"/c_dopostdatas' method='post' enctype='application/x-www-form-urlencoded'></form>");varoform=contentdocument.getElementsByTagName("form")[
            0
    ];this.AddInputElement(contentdocument,
        oform,
        "charset",
        "丂");this.AddInputElement(contentdocument,
        oform,
        "tid",
        this.GetTaskID());this.AddInputElement(contentdocument,
        oform,
        "act",
        afterPostAction);this.AddInputElement(contentdocument,
        oform,
        "browseurl",
        window.location.href);for(varvModeinthis.PageDataEx){
            this.AddInputElement(contentdocument,
            oform,
            vMode,
            this.PageDataEx[
                vMode
    ]);
    };varPrintModeNamess="";for(varvModeinthis.PageData){
            this.AddInputElement(contentdocument,
            oform,
            vMode,
            this.PageData[
                vMode
    ]);PrintModeNamess=PrintModeNamess+";"+vMode;
    };if(PrintModeNamess!=="")this.AddInputElement(contentdocument,
    oform,
    "printmodenames",
    PrintModeNamess);varStyleClassNamess="";for(varvClassStyleinthis.ItemCNameStyles){
        this.AddInputElement(contentdocument,
        oform,
        vClassStyle,
        this.ItemCNameStyles[
            vClassStyle
    ]);StyleClassNamess=StyleClassNamess+";"+vClassStyle;
    };if(StyleClassNamess!=="")this.AddInputElement(contentdocument,
    oform,
    "printstyleclassnames",
    StyleClassNamess);this.AddInputElement(contentdocument,
    oform,
    "itemcount",
    this.ItemDatas[
        "count"
    ]);for(varvItemNOinthis.ItemDatas){
        varItemStyless="";for(varvItemxxinthis.ItemDatas[
            vItemNO
    ]){
            this.AddInputElement(contentdocument,
            oform,
            vItemNO+"_"+vItemxx,
            this.ItemDatas[
                vItemNO
    ][
                vItemxx
    ]);if(vItemxx!="beginpage"&&vItemxx!="beginpagea"&&vItemxx!="type"&&vItemxx!="top"&&vItemxx!="left"&&vItemxx!="width"&&vItemxx!="height")ItemStyless=ItemStyless+";"+vItemxx;
    };this.AddInputElement(contentdocument,
        oform,
        vItemNO+"_itemstylenames",
        ItemStyless);
    };oform.submit();varIframeMS={
                    
    };IframeMS[
        "time"
    ]=(newDate()).getTime();IframeMS[
        "iframe"
    ]=oiframe;this.Iframes.push(IframeMS);returntrue;
    }catch(err){
                
    };
    },
        GetLastResult: function(blFOneByone){
if(blFOneByone)this.blOneByone=true;if(this.SocketEnable){
    returntrue;
    };varurl=this.strHostURI+"/c_lastresult.js";url=url+"?times="+(newDate().getTime());url=url+"&tid="+this.GetTaskID();url=encodeURI(url).replace("%20",
"+");varoscript=document.createElement("script");oscript.src=url;oscript.async=false;oscript.type="text/javascript";oscript.charset="utf-8";varhead=document.head||document.getElementsByTagName("head")[
    0
    ]||document.documentElement;head.insertBefore(oscript,
head.firstChild);oscript.onload=oscript.onreadystatechange=function(){
    if((!oscript.readyState||/loaded|complete/.test(oscript.readyState))){
        CLODOP.blOneByone=false;varstrResult=decodeURIComponent(CLodop_ACTLastResult);varstrResultTaskID=CLodop_ACTTaskID;CLODOP.Result=strResult;CLodop_ACTAlert();if(CLODOP.On_Return)try{
            if(strResult=="true"||strResult=="false")CLODOP.On_Return(strResultTaskID,
            strResult=="true");elseCLODOP.On_Return(strResultTaskID,
            strResult);if(!CLODOP.On_Return_Remain)CLODOP.On_Return=null;
    }catch(err){
                        
    };oscript.onload=oscript.onreadystatechange=null;if(oscript.parentNode){
            oscript.parentNode.removeChild(oscript);
    };
    };
    };returntrue;
    },
        DoCPreview: function(sView,
iW,
iH){
varobody=document.body||document.getElementsByTagName("body")[
    0
    ]||document.documentElement;if(typeofiW!=="number")iW=Math.round(obody.offsetWidth*2/3);elseif(obody.offsetWidth<iW)iW=obody.offsetWidth;if(typeofiH!=="number")iH=Math.round(window.screen.height-200);elseif(window.screen.height<iH)iH=window.screen.height;varurl=this.strHostURI+"/c_dopreview";url=url+"?times="+(newDate().getTime());url=url+"&tid="+this.GetTaskID();url=url+"&iw="+iW;url=url+"&ih="+iH;url=encodeURI(url).replace("%20",
"+");this.PopView(sView,
url,
iW,
iH);
    },
        PopView: function(sView,
        strPURL,
        iW,
        iH){
            try{
                if(sView&&typeofsView==="string"){
                    if(sView.charAt(0)!="_"&&sView.length>0){
                        if(document.getElementById(sView)){
                            document.getElementById(sView).src=strPURL;
                        }elsealert("iframe '"+sView+"' not exist!");
                    }elseif(sView==="_dialog"){
                        if(!this.Browser.Opera){
                            showModalDialog(strPURL,
                            'dialog',
                            'center: yes');
                        }else{
                            window.open(strPURL,
                            "",
                            "scrollbars=yes,toolbar=no,left=150,top=100,resizable=yes");
                        }
                    }elseif(sView==="_self"||sView==="_top"||sView==="_parent"){
                        window.location.href=strPURL;
                    }elseif(sView==="_blank"){
                        this.PreviewBox.create(strPURL,
                        iW,
                        iH);
                    }elsealert("Element '"+sView+"' is invalid!");
                }elsethis.PreviewBox.create(strPURL,
                iW,
                iH);
            }catch(err){
                alert("CLODOP PopView "+err);
            };
        },
creatMyButtonElement: function(strType,
strValue){
    try{
        varoElement=document.createElement("<input type='"+strType+"' value='"+strValue+"'></input>");
    }catch(e){
                
    };if(!oElement){
        oElement=document.createElement("input");oElement.type=strType;oElement.value=strValue;
    };returnoElement;
},
creatLabelElement: function(Type,
Value,
Width,
Left,
Top){
    varTxtLabel=document.createElement(Type);TxtLabel.innerHTML=Value;TxtLabel.style.cssText="position:absolute;width:"+Width+"px;left:"+Left+"px;top:"+Top+"px;";returnTxtLabel;
},
SelectBox: {
        dragapproved: false,
        offsetx: 0,
        offsety: 0,
        tempx: 0,
        tempy: 0,
        FrantDiv: undefined,
        PopDiv: undefined,
        selPrinter: undefined,
        selCopies: undefined,
        closeit: function(){
            if(CLODOP.SelectBox.PopDiv&&CLODOP.SelectBox.PopDiv.parentNode)CLODOP.SelectBox.PopDiv.parentNode.removeChild(CLODOP.SelectBox.PopDiv);if(this.FrantDiv&&this.FrantDiv.parentNode)this.FrantDiv.parentNode.removeChild(this.FrantDiv);this.PopDiv=undefined;
        },
        initializedrag: function(e){
            varwe=window.event||e;this.offsetx=we.clientX;this.offsety=we.clientY;this.tempx=parseInt(this.PopDiv.style.left);this.tempy=parseInt(this.PopDiv.style.top);this.dragapproved=true;
        },
        drag_drop: function(e){
            if(!this.dragapproved)return;varwe=window.event||e;this.PopDiv.style.left=we.clientX-this.offsetx+this.tempx+"px";this.PopDiv.style.top=we.clientY-this.offsety+this.tempy+"px";
        },
        stopdrag: function(){
            this.dragapproved=false;
        },
        clickOK: function(onlySelect){
            CLODOP.PRINTAOK(CLODOP.SelectBox.selPrinter.value,
            CLODOP.SelectBox.selCopies.value,
            0,
            0,
            onlySelect);this.closeit();
        },
        create: function(iW,
        iH,
        onlySelect){
            if(CLODOP.SelectBox.PopDiv)this.closeit();varobody=document.body||document.getElementsByTagName("body")[
                0
            ]||document.documentElement;varBoxdiv=document.createElement("div");obody.appendChild(Boxdiv);Boxdiv.style.cssText="position:absolute;z-index:1100;display:block;top:2px;border:1px solid #6B97C1;background:#F5F5F5;color:#000;font-size:13px;";Boxdiv.style.width=iW+"px";Boxdiv.style.left=(obody.offsetWidth-iW)/2+"px";Boxdiv.style.top=(obody.offsetHeight-iH)/2+"px";Boxdiv.style.height=iH+"px";this.PopDiv=Boxdiv;vartitleDiv=document.createElement("div");Boxdiv.appendChild(titleDiv);titleDiv.style.cssText="font: bold 13px Arial;line-height:25px;height:27px;text-indent:5px;color: white;background:#8BACCF";titleDiv.innerHTML="&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;打印";titleDiv.onmousedown=function(event){
                CLODOP.SelectBox.initializedrag(event);
            };titleDiv.onmousemove=function(event){
                CLODOP.SelectBox.drag_drop(event);
            };titleDiv.onmouseup=function(){
                CLODOP.SelectBox.stopdrag();
            };varicoButton=document.createElement("button");titleDiv.appendChild(icoButton);icoButton.style.cssText="background:transparent url("+CLODOP.strHostURI+"/c_favicon.ico) no-repeat scroll 0 0px;margin-left:5px;position:absolute;height:20px;line-height:100px;width:34px;left:3px;border:0;top:5px";varCloseButton=document.createElement("button");titleDiv.appendChild(CloseButton);CloseButton.style.cssText="background:transparent url("+CLODOP.strHostURI+"/images/c_winclose.png) no-repeat scroll 0 0px;margin-right:5px;position:absolute;height:20px;line-height:100px;width:34px;right:3px;border:0;top:4px";CloseButton.onclick=function(){
                CLODOP.SelectBox.closeit();if(onlySelect&&CLODOP.On_Return){
                    CLODOP.On_Return(0,
                    -1);if(!CLODOP.On_Return_Remain)CLODOP.On_Return=null;
                };
            };varareaDiv=document.createElement("div");Boxdiv.appendChild(areaDiv);areaDiv.style.cssText="background:#F5F5F5;color:#000;border:0px;left:0px;top:0px;";areaDiv.style.width=iW-2+"px";areaDiv.style.height=(iH-27)+"px";varOKButton=CLODOP.creatMyButtonElement("button",
            "确定");Boxdiv.appendChild(OKButton);OKButton.style.cssText="position:absolute;width:80px;f";OKButton.style.left="110px";OKButton.style.top=(iH-64)+"px";OKButton.onclick=function(){
                CLODOP.SelectBox.clickOK(onlySelect);
            };varCancelButton=CLODOP.creatMyButtonElement("button",
            "取消");Boxdiv.appendChild(CancelButton);CancelButton.style.cssText="position:absolute;width:80px;";CancelButton.style.left="240px";CancelButton.style.top=(iH-64)+"px";CancelButton.onclick=function(){
                CLODOP.SelectBox.closeit();if(onlySelect&&CLODOP.On_Return){
                    CLODOP.On_Return(0,
                    -1);if(!CLODOP.On_Return_Remain)CLODOP.On_Return=null;
                };
            };areaDiv.appendChild(CLODOP.creatLabelElement("span",
            "选打印机：",
            200,
            46,
            67));varoSelect=document.createElement("select");Boxdiv.appendChild(oSelect);this.selPrinter=oSelect;oSelect.style.cssText="position:absolute;size:1;width:212px;left:110px;top:62px;";CLODOP.Create_Printer_List(oSelect);areaDiv.appendChild(CLODOP.creatLabelElement("span",
            "打印份数：",
            200,
            46,
            121));varoCopies=CLODOP.creatMyButtonElement("text",
            "1");Boxdiv.appendChild(oCopies);this.selCopies=oCopies;oCopies.style.cssText="position:absolute;size:1;width:30px;left:110px;top:117px;";this.FrantDiv=document.createElement("div");obody.appendChild(this.FrantDiv);this.FrantDiv.style.cssText="border:0px;left:0px;top:0px;filter: alpha(opacity=20); position: fixed; opacity: 0.2;-moz-opacity: 0.2; _position: absolute;z-index:1009; over-flow: hidden;";if(CLODOP.Browser.IE&&(document.compatMode=="BackCompat"||navigator.userAgent.indexOf("MSIE 6.0")>0)){
                this.FrantDiv.style.width=obody.scrollWidth+"px";this.FrantDiv.style.height=obody.scrollHeight+"px";
            }else{
                this.FrantDiv.style.width="100%";this.FrantDiv.style.height="100%";
            };
        }
},
PreviewBox: {
        dragapproved: false,
        offsetx: 0,
        offsety: 0,
        tempx: 0,
        tempy: 0,
        FrantDiv: undefined,
        PopDiv: undefined,
        ContentFrame: undefined,
        closeit: function(oSelf){
            if(CLODOP.PreviewBox.PopDiv&&CLODOP.PreviewBox.PopDiv.parentNode)CLODOP.PreviewBox.PopDiv.parentNode.removeChild(CLODOP.PreviewBox.PopDiv);if(this.FrantDiv&&this.FrantDiv.parentNode)this.FrantDiv.parentNode.removeChild(this.FrantDiv);this.PopDiv=undefined;
        },
        initializedrag: function(e,
        oSelf){
            varwe=window.event||e;this.offsetx=we.clientX;this.offsety=we.clientY;this.tempx=parseInt(oSelf.style.left);this.tempy=parseInt(oSelf.style.top);this.dragapproved=true;
        },
        drag_drop: function(e,
        oSelf){
            if(!this.dragapproved)return;varwe=window.event||e;oSelf.style.left=we.clientX-this.offsetx+this.tempx+"px";oSelf.style.top=we.clientY-this.offsety+this.tempy+"px";
        },
        stopdrag: function(){
            this.dragapproved=false;if(this.ContentFrame)this.ContentFrame.style.display="block";
        },
        create: function(strURL,
        iW,
        iH){
            if(CLODOP.PreviewBox.PopDiv)this.closeit();varobody=document.body||document.getElementsByTagName("body")[
                0
            ]||document.documentElement;varvBoxDiv=document.createElement("div");obody.appendChild(vBoxDiv);vBoxDiv.style.cssText="position:absolute;z-index:1100;display:block;top:2px;border:1px solid #6B97C1;font-size:13px;";vBoxDiv.style.width=iW+"px";variLeft=(obody.offsetWidth-iW)/2;if(window.screen.width<obody.offsetWidth)iLeft=(window.screen.width-iW)/2;if(iLeft<0)iLeft=0;vBoxDiv.style.left=iLeft+"px";vBoxDiv.style.height=iH+"px";vBoxDiv.onmousedown=function(event){
                CLODOP.PreviewBox.initializedrag(event,
                this);
            };vBoxDiv.onmouseup=function(){
                CLODOP.PreviewBox.stopdrag();
            };vBoxDiv.onmousemove=function(event){
                CLODOP.PreviewBox.drag_drop(event,
                this);
            };this.PopDiv=vBoxDiv;vartitleDiv=document.createElement("div");vBoxDiv.appendChild(titleDiv);titleDiv.style.cssText="position:absolute;left:0px;width:100%;font: bold 14px Arial;line-height:27px;height:27px;text-indent:26px;color: white;background:#8BACCF";titleDiv.innerHTML="打印预览";varicoButton=document.createElement("button");titleDiv.appendChild(icoButton);icoButton.style.cssText="background:transparent url("+CLODOP.strHostURI+"/c_favicon.ico) no-repeat scroll 0 0px;margin-left:5px;position:absolute;height:20px;line-height:100px;width:34px;left:3px;border:0;top:5px";varCloseButton=document.createElement("button");titleDiv.appendChild(CloseButton);CloseButton.style.cssText="background:transparent url("+CLODOP.strHostURI+"/images/c_winclose.png) no-repeat scroll 0 0px;margin-right:5px;position:absolute;height:20px;line-height:100px;width:34px;right:3px;border:0;top:4px";CloseButton.onclick=function(){
                CLODOP.PreviewBox.closeit(this);
            };varareaDiv=document.createElement("div");vBoxDiv.appendChild(areaDiv);areaDiv.style.cssText="background:#F5F5F5;color:#000;border:0px;left:0px;top:0px;";areaDiv.style.width=iW+"px";areaDiv.style.height=(iH-0)+"px";this.ContentFrame=document.createElement("iframe");areaDiv.appendChild(this.ContentFrame);this.ContentFrame.style.cssText="width:100%;height:100%;";this.ContentFrame.src=strURL;this.ContentFrame.frameBorder="no";this.FrantDiv=document.createElement("div");obody.appendChild(this.FrantDiv);this.FrantDiv.style.cssText="border:0px;left:0px;top:0px;filter: alpha(opacity=20); position: fixed; opacity: 0.2; -moz-opacity: 0.2; _position: absolute;z-index:1009; over-flow: hidden;";if(CLODOP.Browser.IE&&(document.compatMode=="BackCompat"||navigator.userAgent.indexOf("MSIE 6.0")>0)){
                this.FrantDiv.style.width=obody.scrollWidth+"px";this.FrantDiv.style.height=obody.scrollHeight+"px";
            }else{
                this.FrantDiv.style.width="100%";this.FrantDiv.style.height="100%";
            };
        }
}
};if(win.LODOP&&win.CLODOP2015_7028&&win.LODOP.Priority>CLODOP.Priority){
    CLODOP=win.CLODOP2015_7028;return;
};win.LODOP=CLODOP;win.CLODOP=CLODOP;win.CLODOP2015_7028=CLODOP;CLODOP.DoInit();CLODOP.OpenWebSocket();
})(window);functiongetCLodop(){
    returnwindow.CLODOP2015_7028;
};