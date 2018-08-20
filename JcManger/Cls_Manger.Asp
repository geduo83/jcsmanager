<%
'**************************************************************
'-- File Name: Cls_Manger.Asp ����������
'-- Version: 1.0 Beta build 20090310
'-- Date: 2009-3-17
'-- Script Written By Jiangtao
'**************************************************************

Class Cls_Manger
Public Tb_OfficeName,Proprieter,Editor_in_chief,Tb_Telephone,Manager,AddDate                                    '��������
Public KID,KeyWord,KAddDate,KDeleteFlag                                                                         '�ؼ�������
Public LogID,LogType,LogContent,Ip,LogDate,LTrueName,LUserID,OfficeName,LUserClassID                            '��־����
Public NID,NoticeTitle,NoticeContent,NUserID,NAddDate,NNClicks                                                  '��������
Public UserName,TrueName,UofficeName,cndeleteflag,UserLevel,UserClassName,LastLoginTime,Logintimes,UDeleteFlag  '�û�����
Rem ----------------------------------------��ȡ������Ϣ
Public Function GetOffice(ByVal ID)
Dim Usr
If ID = "" Or IsNull(ID) Then
    Founderr = True
	Msg = "������ʧ��"
	Jcs.BackInfo "",0
	Exit Function 
End If

If Not Founderr Then
	SQL = "Select Tb_OfficeID,Tb_OfficeName,Editor_in_chief,Proprieter,Tb_Telephone,Manager,AddDate From [Tb_Office] Where Tb_OfficeID = "&ID
	Set Rs = Jcs.Execute(SQL)
	If   Rs.Bof Or Rs.Eof Then
	Founderr = True
   Msg = "������Ϣ�����ڻ��Ѿ���ɾ����"
		Jcs.BackInfo "",0
    Else 
    Usr = Rs.GetRows()
    Tb_OfficeName = Usr(1,0)
    Proprieter =  Usr(3,0)
    Editor_in_chief =  Usr(2,0)
    Tb_Telephone = Usr(4,0)
	Manager =  Usr(5,0)
    AddDate = Usr(6,0)
	
	Rs.Close:Set Rs = Nothing     '�ͷ�Rs	
	Usr = Null 
	End If
	'Closedatabase()   '�ر����ݿ�����
End If 
End Function 
Rem ----------------------------------------��ȡ�ؼ�����Ϣ
Public Function GetKeyWord(ByVal ID)
Dim Usr
If ID = "" Or IsNull(ID) Then
    Founderr = True
	Msg = "������ʧ��"
	Jcs.BackInfo "",0
	Exit Function 
End If

If Not Founderr Then
	SQL = "Select KID,KeyWord,AddDate,DeleteFlag From [Tb_KeyWord] Where KID = "&ID
	Set Rs = Jcs.Execute(SQL)
	If   Rs.Bof Or Rs.Eof Then
	Founderr = True
   Msg = "�ؼ�����Ϣ�����ڻ��Ѿ���ɾ����"
		Jcs.BackInfo "",0
    Else 
    Usr = Rs.GetRows()
    KeyWord = Usr(1,0)
    KAddDate =  Usr(2,0)
    KDeleteFlag =  Usr(3,0)
  
	Rs.Close:Set Rs = Nothing     '�ͷ�Rs
	Usr = Null 
	End If
	'Closedatabase()   '�ر����ݿ�����
End If 
End Function 
Rem ----------------------------------------��ȡ��־��Ϣ
Public Function GetLog(ByVal ID)
Dim Usr
If ID = "" Or IsNull(ID) Then
    Founderr = True
	Msg = "������ʧ��"
	Jcs.BackInfo "",0
	Exit Function 
End If

If Not Founderr Then
	SQL = "Select LogID,LogType,LogContent,Ip,LogDate,UserID,OfficeName,TrueName,UserClassID From [v_Log] Where LogID = "&ID
	Set Rs = Jcs.Execute(SQL)
	If   Rs.Bof Or Rs.Eof Then
	Founderr = True
   Msg = "��־��Ϣ�����ڻ��Ѿ���ɾ����"
		Jcs.BackInfo "",0
    Else 
    Usr = Rs.GetRows()
    LogType = Usr(1,0)
    LogContent =  Usr(2,0)
    Ip =  Usr(3,0)
	LogDate = Usr(4,0)
	LUserID =  Usr(5,0)
    OfficeName =  Usr(6,0)
	LTrueName = Usr(7,0)
	LUserClassID = Usr(8,0)
	Rs.Close:Set Rs = Nothing     '�ͷ�Rs
	Usr = Null 
	End If
	'Closedatabase()   '�ر����ݿ�����
End If 
End Function 
Rem ----------------------------------------��ȡ������Ϣ
Public Function GetNotice(ByVal ID)
Dim Usr
If ID = "" Or IsNull(ID) Then
    Founderr = True
	Msg = "������ʧ��"
	Jcs.BackInfo "",0
	Exit Function 
End If

If Not Founderr Then
	SQL = "Select NID,NoticeTitle,NoticeContent,UserID,AddDate,NClicks From [Tb_Notice] Where NID = "&ID
	Set Rs = Jcs.Execute(SQL)
	If   Rs.Bof Or Rs.Eof Then
	Founderr = True
   Msg = "������Ϣ�����ڻ��Ѿ���ɾ����"
		Jcs.BackInfo "",0
    Else 
    Usr = Rs.GetRows()
    NoticeTitle = Usr(1,0)
    NoticeContent =  Usr(2,0)
    NUserID =  Usr(3,0)
	NAddDate = Usr(4,0)
	NNClicks =  Usr(5,0)
	Rs.Close:Set Rs = Nothing     '�ͷ�Rs
	Usr = Null 
	End If
	'Closedatabase()   '�ر����ݿ�����
End If 
End Function 
Rem ----------------------------------------��ȡ�û���Ϣ
Public Function GetUserInfo(ByVal ID)
Dim Usr
If ID = "" Or IsNull(ID) Then
    Founderr = True
	Msg = "������ʧ��"
	Jcs.BackInfo "",0
	Exit Function 
End If

If Not Founderr Then
	SQL = "Select UserID,UserName,TrueName,UofficeName,cndeleteflag,UserLevel,UserClassName,LastLoginTime,Logintimes,DeleteFlag From [v_JcUser] Where UserID = "&ID
	Set Rs = Jcs.Execute(SQL)
	If   Rs.Bof Or Rs.Eof Then
	Founderr = True
   Msg = "�û���Ϣ�����ڻ��Ѿ���ɾ����"
		Jcs.BackInfo "",0
    Else 
    Usr = Rs.GetRows()
    UserName = Usr(1,0)
    TrueName =  Usr(2,0)
    UofficeName =  Usr(3,0)
    cndeleteflag = Usr(4,0)
	UserLevel = Usr(5,0)
	UserClassName =  Usr(6,0)
	LastLoginTime = Usr(7,0)
	Logintimes =  Usr(8,0)
	UDeleteFlag = Usr(9,0)
	Rs.Close:Set Rs = Nothing     '�ͷ�Rs
	Usr = Null 
	End If
	'Closedatabase()   '�ر����ݿ�����
End If 
End Function 
'---------------------������ԱȨ��
Public  Function  Manageckeck()
If Jcs.UserClassID <> 1 Then 
Response.Write("<br><center><img src=""../skin/images/note.gif"" align=""absmiddle"">&nbsp;<font color=""#FF0000"">�㲻�߱���Ȩ�ޣ��������Ա��ϵ��</font></center>")
Response.end
End If
End Function 

'--------------------------------------�г�����δ��������ı�ֽѡ��
Public Function CheckAllPaper()
Dim levelstr,i,Rstbcalss,sqltbclass,tbstr,htmlstr,officeid,sqloffice,Rsclass

	
	'��δ����Ȩ�ޣ��г�����������δ����ı�ֽѡ��
	'��ȡ����ֽ���
	sqloffice = "SELECT PaperID,PaperName,Tb_classID,UserID FROM Tb_Paper WHERE UserID = 0 "
    Set Rsclass = Jcs.Execute(sqloffice)
    If  Rsclass.eof Then 
    CheckAllPaper = "��ֽ�ѷ������"
	Else 
	i = 1
	htmlstr = "<table width=""97%"" border=""0""><tr>"
	Do While Not Rsclass.eof 

	htmlstr = htmlstr + "<td height=""30"" width=""171"">"
	htmlstr = htmlstr + Rsclass(1)
    htmlstr = htmlstr + "<input name=""userlevel"" type=""checkbox"" value="&Rsclass(0)&" /></td>"
	    
	If i Mod 4 = 0 Then htmlstr = htmlstr + "</tr><tr>"
    Rsclass.movenext 
	i = i + 1
	Loop 
	htmlstr =  htmlstr + "</tr></table>"
	i = 0
    Rsclass.Close:Set Rsclass = Nothing     '�ͷ�Rsclass
    CheckAllPaper = htmlstr
	htmlstr = Null 
    officeid = Null 
	sqloffice = Null 
	End If  

	i= Null 
	sqltbclass = Null 
	tbstr = Null 
End Function 

'--------------------------------�г��������Ա
Public Function ListAllcheckuser()
Dim levelstr,i,Rstbcalss,sqltbclass,tbstr,htmlstr,officeid,sqloffice,Rsclass

	sqloffice = "SELECT UserID,TrueName,UserClassID,UserLevel,DeleteFlag FROM Jc_User WHERE DeleteFlag = 0 And UserClassID=2 "
    Set Rsclass = Jcs.Execute(sqloffice)
    If  Rsclass.eof Then 
    ListAllcheckuser = "���������Ա"
	Else 
	i = 1
	htmlstr = "<table width=""97%"" border=""0""><tr>"
	Do While Not Rsclass.eof 

	htmlstr = htmlstr + "<td height=""30"" width=""171"">"
	htmlstr = htmlstr + Rsclass(1)
    htmlstr = htmlstr + "<input name=""UserList"" type=""radio"" value="&Rsclass(0)&" /></td>"
	    
	If i Mod 4 = 0 Then htmlstr = htmlstr + "</tr><tr>"
    Rsclass.movenext 
	i = i + 1
	Loop 
	htmlstr =  htmlstr + "</tr></table>"
	i = 0
    Rsclass.Close:Set Rsclass = Nothing     '�ͷ�Rsclass
    ListAllcheckuser = htmlstr
	htmlstr = Null 
    officeid = Null 
	sqloffice = Null 
	End If  

	i= Null 
	sqltbclass = Null 
	tbstr = Null 
End Function 

'--------------------------------ͳ�������δ��������ı�ֽ
Public Function CountPaper()
Dim Rs
SQL = "SELECT COUNT(PaperID) AS papercount FROM Tb_Paper WHERE (deleted = 0) AND (UserID = 0)"
Set Rs = Jcs.Execute(SQL)
If Not Rs.eof Then CountPaper = Rs(0)
Rs.Close:Set Rs = Nothing     '�ͷ�Rs
End function 
'ͳ�Ʒ����������
Rem ----------------------------��ձ������б�����Ϣ
Public Function ClearOffice()
   Tb_OfficeName = Null 
   Proprieter = Null
   Editor_in_chief = Null 
   Tb_Telephone = Null 
   Manager = Null 
   AddDate =Null 
End Function 
Rem ----------------------------��չؼ������б�����Ϣ
Public Function ClearKeyWord()
   KeyWord = Null 
   KAddDate = Null
   KDeleteFlag = Null 

End Function 
Rem ----------------------------�����־���б�����Ϣ
Public Function ClearLog()
   LogType = Null
   LogContent = Null
   Ip =  Null
   LogDate = Null
   LUserID =  Null
   OfficeName =  Null
  
End Function 
Rem ----------------------------��չ������б�����Ϣ
Public Function ClearNotice()
   NoticeTitle  = Null
   NoticeContent = Null
   NUserID =  Null
   NAddDate = Null
   NNClicks =  Null
End Function 
Rem ----------------------------��������û�������Ϣ
Public Function ClearUserInfo()
    UserName = Null 
    TrueName =  Null 
    UofficeName =  Null 
	UserLevel = Null 
	UserClassName =  Null 
	LastLoginTime = Null 
	Logintimes =  Null 
	UDeleteFlag = Null 
End Function 
Rem ----------------���嵼��
Public Function SetNav()
End Function 
End Class

%>