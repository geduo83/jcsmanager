<!-- #include file="Const.Asp" -->

<% 
'----------定义导航
Dim Navigation
Navigation = SystemName & ">> 报刊管理" &">> 修改报刊"
'----------判断状态
Dim action,id
id = Request("ID")
If IsNull(id) Or id = "" Then 
Msg = "参数丢失，操作失败！"
Jcs.BackInfo "",0
End If 
action = LCase(Request("action"))
'Response.Write action
Select Case action
Case "sub"
	Call IsExitPress()

Case Else 
	Call MainSub()
End Select 

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>报社添加</title>
<link href="../Skin/css/style.css" rel="stylesheet" type="text/css">
<style>
body {
	background-color:#FFFFFF;
}
</style>
</head>

<body>

<%
'报社用户权限
 Jcs_Office.Officeckeck()
 Jcs_Office.GetTbClass(id)
%>

<script language="javascript">
function check()
{
	if (document.form1.officeid.value == -1)
	{
		alert('请选择报社！');
		document.form1.officeid.focus();
		return false;
	}
	if (document.form1.pressname.value == "")
	{
		alert("报刊名称没有填写！");
		document.form1.pressname.focus();
		return false;
	}
	return true;
}
</script>
<%
'-------------------------报刊添加主窗体部分开始
Sub MainSub() 
%>
<form name="form1" ACTION="?action=addpress" METHOD="post" >
<table width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#C4D8ED">
<tr>
<td><img src="../skin/images/r_1.gif" alt="" /></td>
<td width="100%" background="../skin/images/r_0.gif">
  <table cellpadding="0" cellspacing="0" width="100%">
    <tr>
      <td>&nbsp;<%= Navigation%></td>
	  <td align="right">&nbsp;</td>
    </tr>
  </table>
</td>
<td><img src="../skin/images/r_2.gif" alt="" /></td>
</tr>
<tr>
<td></td>
<td>
<table align="center" cellpadding="4" cellspacing="1" class="toptable grid" border="1">
	  <tr>
        <td width="25%" height="30" align="right">报社名称：</td>
        <td width="75%" class="category"><label>
          <%= Jcs.OfficeSelectlist(Jcs_Office.TbOfficeID)%>
        </label></td>
      </tr>	
	  <tr>
        <td width="25%" height="30" align="right">报刊名称：</td>
        <td width="75%" class="category"><input type="text" name="pressname" style="width:300px">
          &nbsp;&nbsp;</td>
      </tr>
 <tr>
        <td width="25%" height="30" align="right">报刊刊号：</td>
        <td width="75%" class="category"><input type="text" name="tbnumber" style="width:200px">
          &nbsp;&nbsp;</td>
      </tr>	 
	   <tr>
        <td width="25%" height="30" align="right">邮发代码：</td>
        <td width="75%" class="category"><input type="text" name="tbcode" style="width:200px">
          &nbsp;&nbsp;</td>
      </tr>	 
	   <tr>
        <td width="25%" height="30" align="right">总编：</td>
        <td width="75%" class="category"><input type="text" name="editor" style="width:200px">
          &nbsp;&nbsp;</td>
      </tr>	 
	   <tr>
        <td width="25%" height="30" align="right">发行周期：</td>
        <td width="75%" class="category"><input type="text" name="tbdate" style="width:200px">
          &nbsp;&nbsp;</td>
      </tr>	 
	  
      <tr>
	    <td height="30">&nbsp;</td>
        <td class="category">
		 <input type="hidden" name="actiont" value="sub">
		  <input type="submit" value=" 确认添加 " onClick="return check()" class="button">&nbsp;&nbsp;&nbsp;&nbsp;
		 
		  <input type="reset" value=" 重新填写 " class="button">		</td>
      </tr>	    
</table>
</td>
<td></td>
</tr>
<tr>
<td><img src="../skin/images/r_4.gif" alt="" /></td>
<td></td>
<td><img src="../skin/images/r_3.gif" alt="" /></td>
</tr>
</table>
</form>
</body>
</html>
<%
End Sub


'------------判断报刊名是否存在
Sub IsExitPress()
Dim pressname
pressname = Trim(Request.Form("pressname"))
If pressname = ""  Then
	Founderr = True
	Msg = "报刊名称不能为空！"
	Jcs.BackInfo "",0
	Exit Sub
End If

If Not Founderr Then
	SQL = "Select Tb_ClassName From [Tb_Class] Where Tb_ClassName = '"&pressname&"'  "
	Response.Write "1"
	Set Rs = JCS.Execute(SQL)
	If Not  Rs.Eof  Then
	Founderr = True
	Rs.Close:Set Rs = Nothing     '释放Rs
	Msg = "报刊名字已经存在！"
	Jcs.BackInfo "",0
	End If 
	'Rs.Close:Set Rs = Nothing     '释放Rs
End If 

If Not Founderr Then
Call addSavePress()
End If 
End Sub 

'-------------添加保存报刊信息
Sub addSavePress()
Dim pressname,officeid
pressname = Jcs.CheckStr(Request.Form("pressname"))
officeid = Request.Form("officeid")
SQL = "Insert Into Tb_Class (Tb_ClassName,Tb_OfficeID) Values ('"&pressname&"',"&officeid &")"
Response.Write "2"&sql
Jcs.Execute(SQL)
'Closedatabase()   '关闭数据库链接
Msg = "报刊添加成功！"
Jcs.BackInfo "Press_List.Asp",2
End Sub 
'---------------------检查报社用户权限


'修改报刊信息
Sub EditPress()
	Dim classid,pressname,officeid
	classid = Request("classid")
	pressname = Jcs.Checkstr(Request.Form("pressname"))
	officeid = Request.Form("officeid")
	SQL = "Update Tb_Class Set Tb_ClassName='"&pressname&"',Tb_OfficeID='"&officeid&"' Where Tb_ClassID=" & classid
	Jcs.Execute(SQL)
	Msg = "报刊修改成功！"
	Jcs.BackInfo "Press_List.asp",2
End Sub 
%>


