<!--#include file="func2.aspx"-->
<%@ Import namespace="System.IO" %>
<%@ Import namespace="System.Data" %>
<%@ Import Namespace="SPic"%>
<%@ Import Namespace="System.Xml"%>
<%@ Page aspcompat="true" validateRequest="false" Language="vb" Debug="true" %>

<%
On error resume next
Dim conn = dbOpen()
Dim rs = Server.CreateObject("ADODB.Recordset")

Dim strFolder as string = "SLB"
Dim dirs,cfg_dirs As String() 
Dim arrFolder
Dim max,p,i,j,n as integer
Dim dateFolder,paper_path as string
Dim sr As StreamReader
Dim producer,paperType,paperName as string
Dim PublishDate
Dim sql as string

dim Reader as XmlTextReader 
dim cfg_ds as DataSet
cfg_ds = new DataSet()
Dim cfg_Table As DataTable
Dim cfg_Row As DataRow
Dim cfg_Column As DataColumn
dim xml_ds as DataSet
xml_ds = new DataSet()
Dim xml_Table As DataTable
Dim xml_Row As DataRow
Dim xml_Column As DataColumn

dim paperId,trsFilePath,verOrder,verName,width,height,wide,deleted,author,images,video,coordinate,perVerImgUrl,important
dim leadTitle as string
dim title  as string
dim title1  as string
dim content  as string

dim Img as System.Drawing.Image
Dim fi
dim fs as FileStream
dim sc as new SPic.SmallPic

dim Rsimportant = Server.CreateObject("ADODB.Recordset")
dim ImportantArray
dim ArrayNum
arrFolder = split(strFolder,",",-1,1)
max  = ubound(arrFolder)
for p = 0 to max     
	'���*.id�ļ�
	dirs = Directory.GetFiles(server.mappath("/"&arrFolder(p)&"/"), "*.id") 
	for i = 0 to dirs.length-1
		producer=""
		paperName="�����㲥���ӱ�"
		paperType=""
		dateFolder=mid(dirs(i),InStrRev(dirs(i),"\")+1,8)
		paper_path = server.mappath("/"&arrFolder(p)&"/") & dateFolder+"\"
		if Directory.Exists (paper_path)  then
			'��ȡinfo.dat�������ߵ�����
			If File.Exists(paper_path+"info.dat") Then
				sr = New StreamReader(paper_path+"info.dat",System.Text.Encoding.GetEncoding("GB2312"))
				producer = sr.ReadLine()	'������
				sr.close()
			end if
			'��ֽ��������
			'PublishDate = cdate(mid(dateFolder,1,4)&"-"&mid(dateFolder,5,2)&"-"&mid(dateFolder,7,2)) '��������
			PublishDate = mid(dateFolder,1,4)&"-"&mid(dateFolder,5,2)&"-"&mid(dateFolder,7,2) '��������
			paperType=Trim(arrFolder(p))
			if paperType = "SLB" then paperName="�����㲥���ӱ�"&PublishDate
			'ɾ���ظ�����
			sql = "select * from tb_paper where folder = '"+paperType+"/"+dateFolder+"'"
			rs.open(sql,conn,0,1)
			if not rs.eof then
				sql = "delete from tb_paper where folder = '"+paperType+"/"+dateFolder+"'"
				conn.execute(sql)
				'=========================================
				'�޸��ˣ�wangsongtao���ڣ�20070209
				'���ܣ�������ù�Ҫ�ŵ����±���
					sql="select title from tb_article where PaperID = " & cint(rs("PaperID").value) &" and important=1 "
					Rsimportant.open(sql,conn,0,1)
					if not Rsimportant.eof then
					ImportantArray=Rsimportant.getrows()
					end if
					Rsimportant.close
				'========================================
				sql = "delete from tb_article where paperId = " & cint(rs("PaperID").value)
				conn.execute(sql)
			end if
			rs.close()
			'
			'tb_paper�������¼�¼
			sql = "insert into tb_paper (paperType,paperName,publishDate,folder,proUserName,Tb_OfficeID,Tb_classID) values ('"+paperType+"','" + paperName + "','" + publishDate + "','" + paperType+"/"+dateFolder + "','" + producer + "',3,3)"
			conn.execute (sql)
			sql = "select top 1 * from tb_paper where paperType='"+paperType+"' and publishDate = '"+publishDate+"'"
			rs.open(sql,conn,0,1)
			paperId=4
			if not rs.eof then paperId = rs("paperId").value
			rs.close()
			cfg_dirs = Directory.GetFiles(paper_path, "*.cfg") 
			
			dim new_cfgFile as string
			new_cfgFile=""
			for j = 0 to cfg_dirs.length-1
				'ȡ���µ�.cfg�ļ�
				new_cfgFile = cfg_dirs(j)
				if new_cfgFile <> "" then
					if file.GetCreationTime(new_cfgFile) <= file.GetCreationTime(cfg_dirs(j)) then 
						new_cfgFile = cfg_dirs(j)
					end if
				end if
			next
			
			'for j = 0 to cfg_dirs.length-1
				'response.write (right(cfg_dirs(0),36))
			if new_cfgFile <> "" then				
				cfg_ds.ReadXml(new_cfgFile)
				For Each cfg_Table in cfg_ds.Tables
				  For Each cfg_Row In cfg_Table.Rows
					For Each cfg_Column in cfg_Table.Columns
						trsFilePath = ""
						perVerImgUrl = ""
						verOrder = ""
						verName = ""
						width = ""
						height = ""
						wide = ""
						n = 0
						if cfg_Column.ColumnName="XML" then
							perVerImgUrl = cfg_Row("Image")		'������������ͼ
                  			'��������ͼ����ͼ���ߴ磺390*520
							fi = New FileInfo(paper_path + perVerImgUrl)
							fs = fi.OpenRead()
							Img = System.Drawing.Image.FromStream(fs)
							sc.spic(Img, paper_path + "b_" + perVerImgUrl, 390, 520, System.Drawing.Imaging.ImageFormat.Jpeg)
							sc.spic(Img, paper_path + "s_" + perVerImgUrl, 105, 174, System.Drawing.Imaging.ImageFormat.Jpeg)
							fs.Close()
							perVerImgUrl = "b_" + perVerImgUrl
							
							
							trsFilePath = cfg_Row(cfg_Column)	  '�������ڵ�xml�ļ���
							trsFilePath = paperType+"/"+dateFolder+"/"+trsFilePath
							If File.Exists(server.mappath("/"+paperType+"/"+dateFolder+"/"&cfg_Row(cfg_Column))) Then
							
							Reader = new XmlTextReader(server.mappath("/"+paperType+"/"+dateFolder+"/"&cfg_Row(cfg_Column)))
							while Reader.read()
								if Reader.NodeType = XmlNodeType.Element	'��ȡ�ڵ��ֵ
									if reader.Name = "PageInfo" then	'��ȡPageInfo�ڵ������ֵ
										verOrder = reader.GetAttribute("PageNo")	  '���
										verName = reader.GetAttribute("PageName")	  '����
										width = reader.GetAttribute("Width")	  'Width
										height = reader.GetAttribute("Height")	  'Height
										wide = reader.GetAttribute("Wide")	  'Wide
									end if
									if reader.Name = "Article" then		'��ȡArticle�ڵ������ֵ
										deleted = reader.GetAttribute("Deleted")	  'Deleted
									end if
									If reader.MoveToContent() = XmlNodeType.Element And reader.Name = "IntroTitle" Then	'��ȡIntroTitle�ڵ��ֵ
										leadTitle = reader.ReadString()
										leadTitle = trim(replace(leadTitle,vbcrlf,"<br>"))
										leadTitle = trim(left(leadTitle,len(leadTitle)-4))
										leadTitle = trim(right(leadTitle,len(leadTitle)-4))
									End If
									If reader.MoveToContent() = XmlNodeType.Element And reader.Name = "Title" Then	'��ȡTitle�ڵ��ֵ
										title = reader.ReadString()
										title = trim(replace(title,vbcrlf,"<br>"))
										title = trim(left(title,len(title)-4))
										title = trim(right(title,len(title)-4))
									End If
									If reader.MoveToContent() = XmlNodeType.Element And reader.Name = "SubTitle" Then	'��ȡSubTitle�ڵ��ֵ
										title1 = reader.ReadString()
										title1 = trim(replace(title1,vbcrlf,"<br>"))
										title1 = trim(left(title1,len(title1)-4))
										title1 = trim(right(title1,len(title1)-4))
									End If
									If reader.MoveToContent() = XmlNodeType.Element And reader.Name = "Author" Then	  '��ȡAuthor�ڵ��ֵ
										author = reader.ReadString()
									End If
									If reader.MoveToContent() = XmlNodeType.Element And reader.Name = "Content" Then	  '��ȡContent�ڵ��ֵ
										content = reader.ReadString()
										content = trim(replace(content,vbcrlf,"<br>"))
										content = trim(left(content,len(content)-4))
										content = trim(right(content,len(content)-4))
									End If
									If reader.MoveToContent() = XmlNodeType.Element And reader.Name = "Image" Then	  '��ȡImage�ڵ������ֵ
										if images <> "" then 
											images = images + ";" + reader.GetAttribute("Name") 
										else
											images = reader.GetAttribute("Name")
										end if
										'������ͼ
										fi = New FileInfo(paper_path + Reader.GetAttribute("Name"))
										fs = fi.OpenRead()
										Img = System.Drawing.Image.FromStream(fs)
										sc.spic(Img, paper_path + "m_" + Reader.GetAttribute("Name"), 410, 270, System.Drawing.Imaging.ImageFormat.Jpeg)
										fs.Close()
									End If
									If reader.MoveToContent() = XmlNodeType.Element And reader.Name = "Video" Then	  '��ȡVideo�ڵ������ֵ
										video = reader.GetAttribute("Name")	  
									End If
									If reader.MoveToContent() = XmlNodeType.Element And reader.Name = "Point" Then	  '��ȡPoint�ڵ������ֵ
										if coordinate <> "" then
											coordinate = coordinate + ";" + reader.GetAttribute("X") + "," + reader.GetAttribute("Y")
										else
											coordinate = reader.GetAttribute("X") + "," + reader.GetAttribute("Y")
										end if
									End If
								end if
								
								if Reader.NodeType = XmlNodeType.EndElement and reader.name = "Article" then
									'=============================================
									'�����:wangsongtao����2007-02-11
									if isArray(ImportantArray) then
										for ArrayNum=0 to ubound(ImportantArray,2)
											if trim(title.tostring) = trim(ImportantArray(0,ArrayNum).tostring) then
												important = 1
												exit for
											else
												important = 0
											end if
										next
									else
										important = 0
									end if
									'=============================================
									'һƪ�������
									sql = ""
									sql = "insert into tb_article(paperId,verName,publishDate,verOrder,leadTitle,title,title1,images,coordinate,author,content,trsFilePath,orderId,width,height,wide,video,perVerImgUrl,important)"
									sql = sql + " values (" + paperId.tostring + ",'" + verName + "','" + publishDate + "','" + verOrder + "','" + leadTitle + "','"+ title + "','" + title1 + "','"+images+"','" + coordinate + "','"+author+"','" + content + "','" + trsFilePath + "'," + n.tostring + ","+width.tostring+","+height.tostring+",'"+wide.tostring+"','"+video+"','"+perVerImgUrl+"',"+important.tostring+")"       
									conn.execute(sql)
									
									'һƪ����������ر������
									deleted = ""
									leadTitle = ""
									title = ""
									title1 = ""
									author = ""
									content = ""
									images = ""
									video = ""
									coordinate = ""
									'============================�����:wangsongtao ����2007-02-11
									important = "" '����Ҫ��
									'============================
									n = n+1
									
								end if
							end while
							Reader.close()
							end if		
						end if
						
					Next cfg_Column
				  Next cfg_Row
			  Next cfg_Table
			  cfg_ds.clear()
				  
			   '������ͼ
			  'response.write(paper_path+"page_01.jpg")
			  fi = New FileInfo(paper_path+"page_01.jpg")
			  fs = fi.OpenRead()
			  Img = System.Drawing.Image.FromStream(fs)
			  sc.spic(Img, paper_path + "page_01_s.jpg", 180, 260, system.drawing.imaging.imageformat.jpeg)
			  sc.spic(Img, paper_path + "page_index.jpg", 360, 595, system.drawing.imaging.imageformat.jpeg)
			  sc.spic(Img, paper_path + "page_list.jpg", 140, 200, system.drawing.imaging.imageformat.jpeg)
			  sc.spic(Img, paper_path + "s_ge_01.jpg", 105, 140, system.drawing.imaging.imageformat.jpeg)
			  fs.close()
			  
			  File.Delete(dirs(i))
			  File.Delete(server.mappath("/"&arrFolder(p)&"/")+dateFolder+".~id")
                          '2007��5��30�����  ��־��
                          'Ŀ�ģ�ɾ��.id�ļ����ٽ���һ��.id2�ļ���
                          if not File.Exists(left(dirs(i),len(dirs(i))-2) + "id2") then fs = File.Create (left(dirs(i),len(dirs(i))-2) + "id2")
                          fs.close()	
			end if
			'next
		end if  
	next
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
    <td align="center" height="30" valign="middle"><font color="#ff0066">��ֽ�����ѳɹ��������ݿ⣡</font></td>
  </tr>
</table>
</body>
</html>





