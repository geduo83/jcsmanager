<!-- #include file="Const.Asp" -->
<%
Response.Charset = "GB2312" '���������Ļ�����
'Response.write "<img src='../skin/Images/ajaxing2.gif'" width='10' height='10'>"
Dim ID,Result,Action
Action = Request("action")
ID = Request("ID")
Select Case Action
Case "user"
Call usercheck()
Case "keyword"
Call wordcheck()
Case "office"
Call officecheck()
End Select 
'----------------------
Sub usercheck()
If IsNull(ID) or ID = "" Then 
ResPonse.write("")
Else 
SQL = "Select UserName From [Jc_User] Where UserName = '"&ID&"'  "
	Set Rs = Jcs.Execute(SQL)
	If Not  Rs.Bof  Then
	Response.write("1") '�û����Ѿ�����
	Rs.Close:Set Rs = Nothing     '�ͷ�Rs
	Else 
Response.write("0") '�û�������ʹ��
	End If 
End If 
End Sub 
'----------------�ؼ���
Sub wordcheck()
If IsNull(ID) or ID = "" Then 
ResPonse.write("")
Else 
SQL = "Select KeyWord From [Tb_KeyWord] Where KeyWord  = '"&ID&"'  "
	Set Rs = Jcs.Execute(SQL)
	If Not  Rs.Bof  Then
	Response.write("1") '�ؼ����Ѿ�����
	Rs.Close:Set Rs = Nothing     '�ͷ�Rs
	Else 
Response.write("0") '�ؼ��ֿ���ʹ��
	End If 
End If 
End Sub 
'----------------������
Sub officecheck()
If IsNull(ID) or ID = "" Then 
ResPonse.write("")
Else 
SQL = "Select Tb_OfficeName From [Tb_Office] Where Tb_OfficeName  = '"&ID&"'  "
	Set Rs = Jcs.Execute(SQL)
	If Not  Rs.Bof  Then
	Response.write("1") '�������Ѿ�����
	Rs.Close:Set Rs = Nothing     '�ͷ�Rs
	Else 
Response.write("0") '����������ʹ��
	End If 
End If 
End Sub 
	
%>
