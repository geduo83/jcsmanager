<!-- #include file="Inc/Const.Asp" -->
<% 
'�жϵ�½
Jcs.CheckManger()
 %>
<HTML><HEAD><TITLE>ϵͳ����</TITLE>
<META http-equiv=Content-Type content="text/html; charset=gb2312">
<LINK href="/skin/Css/Style.css" type=text/css rel=stylesheet>
<STYLE type=text/css>
BODY {
	MARGIN: 0px 0px; 
	BACKGROUND-COLOR: #ffffff;
	background: url(/Skin/images/desk.gif) center no-repeat;
}
</STYLE>
<Script language="JavaScript">
<!--
window.onload = getMsg;
window.onresize = resizeDiv;
window.onerror = function(){}
//������ʾʹ��(asilas����)
var divTop,divLeft,divWidth,divHeight,docHeight,docWidth,objTimer,i = 0;
function getMsg()
{
    try{
    divTop = parseInt(document.getElementById("eMeng").style.top,10)
    divLeft = parseInt(document.getElementById("eMeng").style.left,10)
    divHeight = parseInt(document.getElementById("eMeng").offsetHeight,10)
    divWidth = parseInt(document.getElementById("eMeng").offsetWidth,10)
    docWidth = document.body.clientWidth;
    docHeight = document.body.clientHeight;
    document.getElementById("eMeng").style.top = parseInt(document.body.scrollTop,10) + docHeight + 10;// divHeight
    document.getElementById("eMeng").style.left = parseInt(document.body.scrollLeft,10) + docWidth - divWidth
    document.getElementById("eMeng").style.visibility="visible"
    objTimer = window.setInterval("moveDiv()",10)
    }
    catch(e){}
}

function resizeDiv()
{
    i+=1
    if(i>300) closeDiv()    //�ͻ��벻���Զ���ʧ���û����Լ��ر������������
    try{
    divHeight = parseInt(document.getElementById("eMeng").offsetHeight,10)
    divWidth = parseInt(document.getElementById("eMeng").offsetWidth,10)
    docWidth = document.body.clientWidth;
    docHeight = document.body.clientHeight;
    document.getElementById("eMeng").style.top = docHeight - divHeight + parseInt(document.body.scrollTop,10)
    document.getElementById("eMeng").style.left = docWidth - divWidth + parseInt(document.body.scrollLeft,10)
    }
    catch(e){}
}

function moveDiv()
{
    try
    {
    if(parseInt(document.getElementById("eMeng").style.top,10) <= (docHeight - divHeight + parseInt(document.body.scrollTop,10)))
    {
    window.clearInterval(objTimer)
    objTimer = window.setInterval("resizeDiv()",1)
    }
    divTop = parseInt(document.getElementById("eMeng").style.top,10)
    document.getElementById("eMeng").style.top = divTop - 1
    }
    catch(e){}
}
function closeDiv()
{
    document.getElementById('eMeng').style.visibility='hidden';
    if(objTimer) window.clearInterval(objTimer)
}
-->
</Script>
</HEAD>
<BODY>
<!--��ܰ��ʾ���뿪ʼ-->

<DIV id=eMeng style="BORDER-RIGHT: #455690 1px solid; BORDER-TOP: #a6b4cf 1px solid; Z-INDEX:99999; LEFT: 0px; VISIBILITY: hidden; BORDER-LEFT: #a6b4cf 1px solid; WIDTH: 180px; BORDER-BOTTOM: #455690 1px solid; POSITION: absolute; TOP: 0px; HEIGHT: 116px; BACKGROUND-COLOR: #c9d3f3">
    <TABLE style="BORDER-TOP: #ffffff 1px solid; BORDER-LEFT: #ffffff 1px solid" cellSpacing=0 cellPadding=0 width="100%" bgColor=#AFDCF3 border=0>
    <TBODY>
        <TR bgColor=#6699cc>
            <TD style="font-size: 12px; background-image: url('msgTopBg.gif'); color: #0f2c8c" width=30 height=24></TD>
            <TD style="font-weight: normal; font-size: 12px; background-image: url('msgTopBg.gif'); color: #ffffff; padding-left: 4px; padding-top: 4px" vAlign=center width="100%"> ���ƽ̨��ܰ��ʾ��</TD>
            <TD style="background-image: url('msgTopBg.gif'); padding-right: 2px; padding-top: 2px" vAlign=center align=right width=19><span title=�ر� style="CURSOR: hand;color:white;font-size:12px;font-weight:bold;margin-right:4px;" onclick=closeDiv() >��</span><!--<IMG title=�ر� style="CURSOR: hand" onclick=closeDiv() hspace=3 src="msgClose.jpg">--></TD>
        </TR>
        <TR>
            <TD style="background-image: url('/skins/images/windty_bg.jpg'); padding-right: 1px; padding-bottom: 1px" colSpan=3 height=90>
                <DIV style="BORDER-RIGHT: #b9c9ef 1px solid; PADDING-RIGHT: 13px; BORDER-TOP: #728eb8 1px solid; PADDING-LEFT: 13px; FONT-SIZE: 12px; PADDING-BOTTOM: 13px; BORDER-LEFT: #728eb8 1px solid; WIDTH: 100%; COLOR: #1f336b; PADDING-TOP: 18px; BORDER-BOTTOM: #b9c9ef 1px solid; HEIGHT: 100%">����ⱨֽ2�ڣ���δ�����������ڷ���������<BR>
                <DIV align=center style="word-break:break-all"><a href="Give_TaskPaper.Asp" target="_blank">
                <font color=#FF0000>���������������</font></a></DIV>

                </DIV>
            </TD>
        </TR>
    </TBODY>
    </TABLE>
</DIV>
<!--��ܰ��ʾ�������-->
<TABLE height="100%" cellSpacing=0 cellPadding=0 width="100%" border=0>
  <TBODY>
  <TR>
    <TD vAlign=top height="50%">
      <TABLE class=topdashed cellSpacing=0 cellPadding=0 width="100%" 
        border=0><TBODY>
        <TR>
          <TD align=right height=23>
            <TABLE cellSpacing=0 cellPadding=0 width="100%" border=0>
              <TBODY>
              <TR>
                <TD>&nbsp;</TD></TR></TBODY></TABLE></TD></TR></TBODY></TABLE>
      <TABLE cellSpacing=0 cellPadding=0 width="90%" align=center border=0>
        <TBODY>
        <TR>
          <TD height=10>
            <DIV align=right></DIV></TD></TR>
        <TR>
          <TD height=25>&nbsp;</TD></TR></TR></TBODY></TABLE></TD></TR>
  <TR>
    <TD vAlign=bottom height="50%">
      <TABLE cellSpacing=0 cellPadding=0 width="90%" align=center border=0>
        <TBODY>
        <TR>
          <TD align=right height=25>ϵͳ�����������Ƽ�<A href="http://www.7fbbs.com/" 
            target=_blank><SPAN class=STYLE1>(www.joyhua.com)</SPAN> </A></TD></TR>
        <TR>
          <TD align=right height=30>����֧��QQ��398830351 Email��Huangli-029@163.com</TD></TR></TBODY></TABLE></TD></TR>
  <TR>
    <TD>
      <DIV 
      style="COLOR: #003300; TEXT-ALIGN: right">----------------------------------------------------------------------------------------------------------------------------</DIV>
      <DIV style="HEIGHT: 30px; TEXT-ALIGN: right">Copyright 
      (c) 2009 <A href="http://www.joyhua.com/" target=_blank><FONT 
      color=#ff6600>www.joyhua.com</FONT></A>. All Rights Reserved . 
  </DIV></TD></TR></TBODY></TABLE></BODY></HTML>