<!--#include file="../inc/func.asp" -->
<%set conn=server.CreateObject("ADODB.Connection")
  conn.open GetConnectionString
        '�ر�ע��:����N��ID�ļ�,����ÿ��ID��Ӧ���ļ����������N��TRS   Ҫ��ѭ������ ��info.dat�ļ������������
		'------1.�����Ժ�׺Ϊ"id"�ļ����������ļ���(��Ŀ¼)�����ȡTRS�ļ�,���洢�����ݿ�
		'------2.����ɾ��ID�ļ�����׺Ϊ"~ID"�ļ�		
		'��һ��(1)
		 Dim fso1, fa, f11, fc1
         Set fso1 = CreateObject("Scripting.FileSystemObject")
         'dim strFolder: strFolder= "lnrb,lswb,ssshdb,bdcb"
         dim strFolder: strFolder= "tzrb,tzwb"
         dim arrFolder : arrFolder = split(strFolder,",",-1,1)
         max  = ubound(arrFolder)
         for p = 0 to max         
			Set fa = fso1.GetFolder(server.MapPath("../../"&arrFolder(p)&"/"))  
			folerNamePaper = arrFolder(p)
			Set fc1 = fa.Files
			For Each f11 in fc1
				extName1 = fso1.GetExtensionName(server.MapPath("../../"&arrFolder(p)&"/"&f11.name))
				if extName1 = "id" then   
					baseName = fso1.GetBaseName(server.MapPath("../../"&arrFolder(p)&"/"&f11.name)) 
					if baseName<>"" then                                     
						dim rsExists : set rsExists = server.CreateObject("adodb.recordset")
						rsExists.Open "select id from tb_paper where folder='" & folerNamePaper&"/"&baseName & "'",conn,1,1
						if not rsExists.EOF then				       
						  conn.Execute("delete from tb_article where paperId=" & cint(rsExists("id")) )	
										  conn.Execute("delete from tb_paper where folder='" & folerNamePaper&"/"&baseName & "'")			    
						end if		
						'------------------------------------------------------------------------------ 
							  dim fsoy : Set fsoy = CreateObject("Scripting.FileSystemObject")	
												  If (fsoy.FileExists(server.MapPath("../../" & folerNamePaper&"/"&baseName & "/info.dat"))) Then
							  Set tf = fsoy.OpenTextFile(server.MapPath("../../" & folerNamePaper&"/"&baseName & "/info.dat"), 1)
							  proUserName = tf.ReadLine '������
												  else
													  proUserName = ""
												  end if                                              
							  paperType=folerNamePaper '��ֽ����ID(string)
							  strPublishDate = baseName
							  PublishDate = cdate(mid(strPublishDate,1,4)&"-"&mid(strPublishDate,5,2)&"-"&mid(strPublishDate,7,2)) '��������					      

							  if Trim(paperType) = "tzrb" then paperName="̩���ձ�"
								if Trim(paperType) = "tzwb" then paperName="̩����"

                             								dim strTbl : strTbl = ""
								dim strPaper : strPaper = ""
								strTbl = strTbl & "insert into tb_paper(paperType,paperName,publishDate,folder,proUserName)"
								'strTbl = strTbl & " values('" & paperType & "','" & paperName & "','" & publishDate & "','" & folerNamePaper&"/"&baseName & "','" & proUserName & "')"
								strTbl = strTbl & " values('','" & paperName & "','" & publishDate & "','" & folerNamePaper&"/"&baseName & "','" & proUserName & "')"
								conn.Execute(strTbl)	
						'------------------------------------------------------------------------------			
						'ѭ���ҳ����ļ�����������е�TRS�ļ������д���
						Set fax = fso1.GetFolder(server.MapPath("../../" &folerNamePaper&"/"&baseName & "/")) 
						Set fc1x = fax.Files
						For Each f11x in fc1x  '������ļ����������е�TRS	
						  extName1 = fso1.GetExtensionName(server.MapPath("../../" & folerNamePaper&"/"&baseName & "/"&f11x.name))					   
						  if extName1 = "trs" and len(f11x.name)=36 then		'��׺����.trs�����ļ���������36			
								dim filsPath : filsPath = server.MapPath("../../" & folerNamePaper&"/"&baseName & "/" &f11x.name)							
								Dim fso2,f2,ts,fileName
								Set fso2 = CreateObject("Scripting.FileSystemObject")     
								Set cnrs = fso2.OpenTextFile(filsPath,1)
								'��ȡ�ļ�����,�����洢�����ݿ�							
								dim zz : zz = 0	
								dim yy : yy = 0
									content =""	
								While Not cnrs.AtEndOfStream                                                                
									rsline = cstr(cnrs.ReadLine)
									if rsline = "" then
										  zz = zz + 1
									  if zz mod 2 <> 0 then                                                                      
										  startFlag = true
									  else  
										  startFlag = false
									  end if
									elseif replace(replace(rsline,"<","+"),">","+") = replace(replace("<REC>","<","+"),">","+") then  '<REC>
									zz = 0
									elseif mid(replace(replace(rsline,"<","+"),">","+"),1,5) = replace(replace("<����>=","<","+"),">","+") then  '<����>=
									zz = 0								  
									verName = mid(replace(replace(rsline,"<","+"),">","+"),6,len(replace(replace(rsline,"<","+"),">","+")))								   
									elseif mid(replace(replace(rsline,"<","+"),">","+"),1,5) = replace(replace("<����>=","<","+"),">","+") then  '<����>=
									zz = 0								  
									strDate = mid(replace(replace(rsline,"<","+"),">","+"),6,len(replace(replace(rsline,"<","+"),">","+")))								   
    								elseif mid(replace(replace(rsline,"<","+"),">","+"),1,5) = replace(replace("<���>=","<","+"),">","+") then  '<���>=
									zz = 0								  
									verOrder = mid(replace(replace(rsline,"<","+"),">","+"),6,len(replace(replace(rsline,"<","+"),">","+")))
									elseif mid(replace(replace(rsline,"<","+"),">","+"),1,5) = replace(replace("<����>=","<","+"),">","+") then  '<����>=
									zz = 0								  
									leadTitle= mid(replace(replace(rsline,"<","+"),">","+"),6,len(replace(replace(rsline,"<","+"),">","+")))
									elseif mid(replace(replace(rsline,"<","+"),">","+"),1,5) = replace(replace("<����>=","<","+"),">","+") then  '<����>=
									zz = 0								  
									title =mid(replace(replace(rsline,"<","+"),">","+"),6,len(replace(replace(rsline,"<","+"),">","+")))
									elseif mid(replace(replace(rsline,"<","+"),">","+"),1,5) = replace(replace("<����>=","<","+"),">","+") then  '<����>=
									zz = 0								  
									title1 =mid(replace(replace(rsline,"<","+"),">","+"),6,len(replace(replace(rsline,"<","+"),">","+")))
									elseif mid(replace(replace(rsline,"<","+"),">","+"),1,5) = replace(replace("<ͼ��>=","<","+"),">","+") then  '<ͼ��>=
									zz = 0								  
									images =mid(replace(replace(rsline,"<","+"),">","+"),6,len(replace(replace(rsline,"<","+"),">","+")))
									elseif mid(replace(replace(rsline,"<","+"),">","+"),1,7) = replace(replace("<ȫ������>=","<","+"),">","+") then  '<ȫ������>=
									zz = 0								  
									coordinate =mid(replace(replace(rsline,"<","+"),">","+"),8,len(replace(replace(rsline,"<","+"),">","+")))
									
									elseif mid(replace(replace(rsline,"<","+"),">","+"),1,5) = replace(replace("<����>=","<","+"),">","+") then  '<����>=
									zz = 0								  
									author =mid(replace(replace(rsline,"<","+"),">","+"),6,len(replace(replace(rsline,"<","+"),">","+")))
									
									elseif mid(replace(replace(rsline,"<","+"),">","+"),1,6) = replace(replace("<����>=","<","+"),">","+") then  '<����>=
									zz = 0								  
									content = content & replace(rsline,"<����>=","")
									else
									zz = 0
									content = content & rsline & "<br>"
									end if
    								
									if startFlag = true then				    					    
										dim rsPaper : set rsPaper = server.CreateObject("adodb.recordset")
										rsPaper.Open "select top 1 id from tb_paper order by id desc",conn,1,1
										if not rsPaper.EOF then
										  paperid=rsPaper("id") '��־id
										else
										  paperid = -1  '��ʾ������
										end if	
										content = replace(content,"<REC>","")
										content = EscapeString(content)
										strPaper = strPaper & "insert into tb_article(paperId,verName,publishDate,verOrder,leadTitle,title,title1,images,coordinate,author,content,trsFilePath,orderId)"
										strPaper = strPaper & " values (" & paperId & ",'" & verName & "','" & publishDate & "','" & verOrder & "','" & leadTitle & "','"& title & "','" & title1 & "','"&images&"','" & coordinate & "','"&author&"','" & content & "','" & folerNamePaper&"/"&baseName&"/"&f11x.name & "'," & yy & ")"              						

										conn.Execute(strPaper)
										yy =yy +1
										startFlag=false		
										content=""	
										strPaper= ""
									end if								
								Wend						
						  end if
						next
							  '�ڶ���(2) ɾ��id�ļ�
								Set fsok = CreateObject("Scripting.FileSystemObject")
								If (fsok.FileExists(server.MapPath("../../" & folerNamePaper&"/"&baseName & ".id"))) Then
									fsok.DeleteFile(server.MapPath("../../" & folerNamePaper&"/"&baseName& ".id"))
								End If
								If (fsok.FileExists(server.MapPath("../../" & folerNamePaper&"/"&baseName& ".~id"))) Then
									fsok.DeleteFile(server.MapPath("../../" & folerNamePaper&"/"&baseName& ".~id"))
								End If
    					        
					end if
				end if
			Next
		next
%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title></title>
<link href="../css/css.css" rel="stylesheet" type="text/css">
</head>
<body topmargin="0" bottommargin="0" rightmargin="0" leftmargin="0" oncontextmenu = "return false" onselectstart="return false">
<table width="100%"  border="0" cellspacing="0" cellpadding="0" ID="Table2">
  <tr>
    <td align="center" height="60" valign="middle"><font color="#ff0066">��ֽ�����ѳɹ��������ݿ⣡</font></td>
  </tr>
</table>
</body>
</html>





