<!-- #include file="Const.Asp" -->
<% 'ǿ����������·��ʷ���������ҳ�棬�����Ǵӻ����ȡҳ��
Response.Buffer = True
Response.Expires = -1
Response.ExpiresAbsolute = Now() - 1
Response.Expires = 0
Response.CacheControl = "no-cache"
'�жϵ�½
Jcs.CheckManger()
'----------���嵼��
Dim Navigation
Navigation = SystemName & ">> ����" &">> ���йؼ���"
'----------�ж�״̬
Dim action
action = LCase(Request("actiont"))
Select Case action
Case "search"     '��ѯ
Navigation = SystemName & ">> �ؼ��ֹ���" &">> �ؼ��ֲ�ѯ"
If Request("actiondel") = "sub" Then 
Call DelKeyWord()	
Else 
Call MainSub()
End If 
Case "sub"      'ɾ��
Call DelKeyWord()
Case "lock"     '����
Call LockKeyWord()
Case Else 
If Request("actiondel") = "sub" Then 
Call DelKeyWord()	
Else 
Call MainSub()
End If 
End Select 
'-------------------------�ؼ����б������岿�ֿ�ʼ
Sub MainSub()
%>

<html>
<head>
<title>�ؼ��ֲ�ѯ</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link href="../skin/css/style.css" rel="stylesheet" type="text/css">
<style>
body {
	background-color:#FFFFFF;
}
</style>
</HEAD>

<BODY>
<script>
function CheckAll(form)  {
  for   (var i=0;i<form.elements.length;i++)    {
    var e = form.elements[i];
    if (e.name != 'chkall')       e.checked = form.chkall.checked; 
   }
  }
</script>
<% '----������ԱȨ��
  Jcs_Manger.Manageckeck()

'ȡ�õ�ǰҳ��
%>
<table width="100%" border="0" cellpadding="0" cellspacing="2" align="center">
<form name="form2">
  <input type="hidden" name="actiont" value="search">
  <tr> 
    <td width="5%" height="30">&nbsp;</td>
	<td width="95%" align="right">
	  �ؼ��ֲ�ѯ��
	    
	    <input type="text" name="keyword" size="20" value="">
	  <input type="submit" value=" ��ѯ " class="button">&nbsp;	</td>
  </tr>
</form>  
</table>
<table width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#C4D8ED">
<tr>
<td><img src="../skin/images/r_1.gif" alt="" /></td>
<td width="100%" background="../skin/images/r_0.gif">
  <table cellpadding="0" cellspacing="0" width="100%">
    <tr>
      <td>&nbsp;<%= Navigation %></td>
	  <td align="right">&nbsp;</td>
    </tr>
  </table>
</td>
<td><img src="../skin/images/r_2.gif" alt="" /></td>
</tr>
<tr>
<td></td>
<td>
<form name="form3"  METHOD="post" >
 
<table align="center" cellpadding="4" cellspacing="1" class="toptable grid" border="1">
  <tr align="center">
    <td width="11%" height="30" class="category">
	 ���
	   <a href="?action=order&orderid=KID&Orderby=0"><img src="../skin/images/up2.gif" border="0" hspace="2" align="absmiddle"></a><a href="?action=order&orderid=KID&Orderby=1"><img src="../skin/images/down2.gif" border="0" hspace="2" align="absmiddle"></a></td>
    <td width="33%" class="category">
	  �ؼ�������
	  <a href="?action=order&orderid=KeyWord&Orderby=0"><img src="../skin/images/up2.gif" border="0" hspace="2" align="absmiddle"></a><a href="?action=order&orderid=KeyWord&Orderby=1"><img src="../skin/images/down2.gif" border="0" hspace="2" align="absmiddle"></a> </td>
  
	<td width="25%" class="category">
	 ����ʱ��
	   <a href="?action=order&orderid=AddDate&Orderby=0"><img src="../skin/images/up2.gif" border="0" hspace="2" align="absmiddle"></a><a href="?action=order&orderid=AddDate&Orderby=1"><img src="../skin/images/down2.gif" border="0" hspace="2" align="absmiddle"></a> </td>
	

    <td class="category" width="9%">�޸�</td>

	
    <td class="category" width="13%">ɾ��</td>
	
	
	<td class="category" width="9%">״̬</td>
  </tr>
  <% 
 Dim Ds,i,Count,Page,Pagesize,Cmd,FieldName(0),FieldValue(0),MaxPage,keyword,keystr,OrderBy,OrderField
 
 keyword = Jcs.Checkstr(Request("keyword"))
keystr = "(DeleteFlag = 0 Or DeleteFlag = 2 ) And  KeyWord Like  '%"&keyword&"%'"
'-----
OrderBy = 1
OrderField = "KID"
If Request.QueryString("action") = "order" Then 
If Not IsNull(Request.QueryString("orderid")) Then OrderField = Jcs.Checkstr(Request.QueryString("orderid"))
Response.Write(Request.QueryString("orderby"))
Response.Write(Request.QueryString("orderid"))
If Not IsNull(Request.QueryString("orderby")) Then OrderBy = Jcs.Checkstr(Request.QueryString("orderby"))
End If

Page = Request("Page")
If Page = "" Or IsNumeric(Page) = 0 Then Page = 1
Pagesize = 2
SQL = "Select Count(KID) From [Tb_KeyWord] Where (DeleteFlag = 0 Or DeleteFlag = 2)  And "& keystr
Count = Jcs.Execute(SQL)(0)
If Count <= 0 Then
Response.Write "<tr align=""center"" onMouseOver=""this.className='highlight'"" onMouseOut=""this.className=''""><td colspan=""10"" height=""25"" align=""center"" style=""color:red""><b>û���ҵ��ؼ���</b></td></tr>"
Else
MaxPage = Count\Pagesize
If Count Mod Pagesize <> 0 Then MaxPage = MaxPage + 1
If Int(Page) > MaxPage Then Page = MaxPage
Set Cmd = Server.CreateObject("ADODB.Command")
Set Cmd.ActiveConnection=Conn
Cmd.CommandText="PageList"
Cmd.CommandType=4
Cmd.Prepared = True
Cmd("@Tablename") = "Tb_KeyWord"
Cmd("@Fields") = "KID,KeyWord,AddDate,DeleteFlag"
Cmd("@OrderBy") = OrderField
Cmd("@Pagesize")= Pagesize
Cmd("@PageIndex") = Page
Cmd("@OrderType") = OrderBy
Cmd("@Where") = keystr
Set Rs = Cmd.Execute
If Not (Rs.Bof And Rs.Eof) Then Ds = Rs.GetRows(-1)
Rs.Close:Set Rs = Nothing
For i = 0 To UBound(Ds,2)

Response.Write("<tr onMouseOver=""this.className='highlight'"" onMouseOut=""this.className=''"" ><td align=""center"" height=""25"">"&Ds(0,i)&"</td><td align=""center"">"&Ds(1,i)&"</td><td align=""center"">"&Ds(2,i)&"</td>")
Response.Write("<td align=""center""><a href=""KeyWord_Edit.Asp?id="& Ds(0,i)& """><img src=""../skin/images/res.gif"" border=""0"" hspace=""2"" align=""absmiddle"">�޸�</a></td>")
Response.Write("<td align=""center""><input type=""checkbox"" name=""ID"" value=" &Ds(0,i)& " style=""border:0""></td><td align=""center"">"&LockStat(Ds(0,i))&"</td></tr>")

 Next:Response.Flush

' Closedatabase()   '�ر����ݿ�����
 %>
  <tr>
    <td colspan="10" height="30" class="category">
	<table cellpadding=0 cellspacing=0 width="100%">
	<tr>
	<td width="49%" align="left" style="color:#FF0000;">&nbsp;
	  ״̬�����"����"����ùؼ��ֱ����ã����"����"����ָ�������
	  </td>  
	<td width="31%" align="right">
	  <%Response.write(Jcs.PageList( Page,Pagesize,Count,FieldName,FieldValue) )%>	  &nbsp;</td>
	 
    <td width="20%" align="right"><input name="chkall" type="checkbox" id="chkall" value="select" onClick="CheckAll(this.form)" style="border:0"> <input type="hidden" name="page" value="<%=Request("Page")%>">
      ȫѡ <input type="hidden" name="actiondel" value="sub">
        <input name="submit" type="submit" class="button" onClick="return confirm('�˲����޷��ָ������������أ�����\n\nȷ��Ҫɾ����ѡ��Ļ�Ա��')" value="ɾ ��"></td>
	</tr>
 
  </table></td></tr>
</table>
</form>
</td>
<td></td>
</tr>
<tr>
<td><img src="../skin/images/r_4.gif" alt="" /></td>
<td></td>
<td><img src="../skin/images/r_3.gif" alt="" /></td>
</tr>
 <% end if %>
</table>
</body>
</html>
<% 
End Sub 

'----------ɾ���ؼ���
Sub DelKeyWord()
Dim ID,i,J,page,KeyWordname
page = Jcs.Checkstr(Request("page"))
J = 0
ID =  Jcs.Checkstr(Request("ID"))
ID = Split(ID,",")
For i = 0 To UBound(ID)
SQL = "Update [Tb_KeyWord] Set DeleteFlag =  1 Where KID = " & ID(i)
Jcs.Execute(SQL)
J = J + 1
'---д������־
Jcs_Manger.GetKeyWord ID(i)
KeyWordname = Jcs_Manger.KeyWord
Jcs.WriteLog KeyWordname,"ɾ���ؼ���"
Jcs_Manger.ClearKeyWord
Next 

'Closedatabase()   '�ر����ݿ�����
If J > 0 Then 
 Msg = "ɾ���ɹ���"
 Else 
 Msg = "����Ҫѡ��һ��Ҫɾ������"
End If 
 Jcs.BackInfo "?page="&page,2
End Sub 
'------------------�ж�����״̬
Function LockStat(ByVal id)
Dim LockStr
 Jcs_Manger.GetKeyWord(id)
LockStr = Jcs_Manger.KDeleteFlag

Select Case LockStr
Case 1
LockStat = "<a href=?actiont=lock >��ɾ��</a>"
Case 2
LockStat = "<a href=?actiont=lock&ID="& id &"&page="&Request("Page")&" title=����ָ�ʹ��>�ѽ���</a>"
Case Else 
LockStat = "<a href=?actiont=lock&ID="& id &"&page="&Request("Page")&" title=�������>����</a>"
End Select 
End Function 

'-----------------������ͨ�ؼ���
Sub LockKeyWord()
Dim id,delflag,mothed,KeyWordname,page
page = Jcs.Checkstr(Request("page"))
id =  Jcs.Checkstr(Request("ID"))
If IsNull(id)  Then 
 Msg = "��������"
 Founderr = True
Jcs.BackInfo "",0
End If 

Jcs_Manger.GetKeyWord id
delflag = Jcs_Manger.KDeleteFlag
Select Case delflag
Case 0
SQL = "Update [Tb_KeyWord] Set DeleteFlag =  2 Where KID = " & id
mothed = "���ùؼ���"
Case 2
SQL = "Update [Tb_KeyWord] Set DeleteFlag =  0 Where KID = " & id
mothed = "�ָ�ʹ�ùؼ���"
Case Else
Founderr = True
End Select 
If Not Founderr Then 
Jcs.Execute(SQL)
'---д������־
KeyWordname = Jcs_Manger.KeyWord
Jcs.WriteLog KeyWordname,mothed
Jcs_Manger.ClearKeyWord
 Msg = mothed &"��" &KeyWordname&"���ɹ���" 
Else 
 Msg = "�ùؼ����Ѿ���ɾ��"
End If 
  Jcs.BackInfo "?page="&page,2
End Sub 

 %>