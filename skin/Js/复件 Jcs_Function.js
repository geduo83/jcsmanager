// �齭�� 2009/03/31 js����
function ValidatorTrim(s) { 
    var m = s.match(/^\s*(\S+(\s+\S+)*)\s*$/); 
    return (m == null) ? "" : m[1]; 
} 
// �Ƿ�Ϊ������
function isUnsignedInteger(strInteger){  
    var  newPar=/^\d+$/  
    alert(newPar.test(strInteger));
} 
// �Ƿ�Ϊ����
function isInteger(strInteger){  
    // /^(-|\+)?\d+$/ 
    var  newPar=/^(- |\+)?\d+$/;
    return newPar.test(strInteger); 
}  
//�û���������֤
//���������֤

// Grid ����
function openWinows(url)
{
    var objWindow = window.open(url);
    if(objWindow){ }else{window.location.href = url;}
}
// ��ȡѡ�е� CheckBox ����ֵ
function GetChkItems(){ 
    var Items = new Array();
    for(var i=0;i<document.all("ItemChk").length;i++)
    { 
        if(document.all("ItemChk")(i).checked) 
        Items[Items.length] = document.all("ItemChk")(i).id; 
    }
    return Items;
}
// CheckBox ȫѡ��ȫ��ȡ��     SetCheck
function SelectAll(){  // if(document.all[i].name=="ITEMTR") itemsi chkParams \\var m = document.getElementById("K").value;
    for(i=0;i<document.all("ItemChk").length;i++)
    {
        if(document.all("itemsi").checked)
        {
            document.all("ItemChk")(i).checked=true;
        }
        else
        {
            document.all("ItemChk")(i).checked=false;
        }
    }
}
// ʹCheckBoxֻ֧�ֵ�ѡ
function SetCheckBoxClear(objID){  
    var cbx = document.all("ItemChk"); 
    for(var i=0; i<cbx.length; i++)     
    {         
        if(cbx[i].type=="checkbox" && cbx[i].value == objID)         
        {             
            cbx[i].checked = true; 
        }
        else
        {
            cbx[i].checked = false; 
        }
    } 
    //objCheckBox.checked = true; 
}
// �ı䱳����ɫ
function ChangeBGColor(ObjGrid)
{
    var Items = new Array();
    for(var i=0;i<document.all("YGVtr").length;i++){ 
    document.all("YGVtr")(i).style.backgroundColor='';document.all("YGVtr")(i).style.color='';}
    ObjGrid.style.backgroundColor='#336699';ObjGrid.style.color='#ffffff';
    //ObjGrid.style.backgroundColor='#99ccff';ObjGrid.style.color='#ffffff';
}
// ת����������
function ChangeUrl(objUrl,objName)
{
    if(objUrl.length > 0)
    {
        if(objUrl.indexOf("Url=true")>1)
        {
            window.location.href = objUrl;
        }
        else
        {
            var objID = document.getElementById('selectRowID').value;
            var objFuncNo = document.getElementById('tbFuncNo').value;
            var objParams = document.getElementById('selectRowPara').value;
            if(CheckChangeParams(objFuncNo,objParams)>0)
            {
                if(isInteger(objID))
                {
                    window.location.href = objUrl + "&k="+objID+"&oNa="+objName;
                }
                else
                {
                    alert("����ʧ�ܣ������ȴ��б��е��ѡ������Ҫ��������Ŀ��");
                }
            }
        }
        
    }
}
// ת���������󣬰���ѡ���Ķ���
function ChangeUrlMultCheck(objUrl,objName)
{
    if(objUrl.length > 0)
    {
        if(objUrl.indexOf("Url=true")>1)
        {
            window.location.href = objUrl;
        }
        else
        {
            var objArrayIDs = new Array();
            var selectIDs = "";
            var objFuncNo = document.getElementById('tbFuncNo').value;
            var objParams = document.getElementById('selectRowPara').value;
            if(CheckChangeParams(objFuncNo,objParams)>0)
            {
                objArrayIDs = GetChkItems();
                if(objArrayIDs.length>0)
                {
                    for(i=0;i<objArrayIDs.length;i++)
	                {
		                if(i==objArrayIDs.length -1){selectIDs +=objArrayIDs[i];}
		                else{selectIDs +=objArrayIDs[i] + "s" ;}
	                }
                    window.location.href = objUrl + "&k="+selectIDs+"&oNa="+objName;
                }
                else
                {
                    alert("����ʧ�ܣ������ȴ��б��е��ѡ������Ҫ��������Ŀ��");
                }
            }
        }
    }
}

// �б��ѯ
function getQueryData(searchKeys,objUrl)
{
    if(searchKeys.length > 0 && objUrl.length > 0)
    {
        searchKeys = encodeURIComponent(searchKeys);
        var sUrl = objUrl + "&searchKey="+searchKeys;
        window.location.href = sUrl;
    }
    else
    { 
        alert("����ʧ�ܣ���ѯ��������Ϊ�գ�");
    }
}


// 
function goPages(papams,menus,pages,keys,objContainer)
{
    //var k = document.getElementById("searchKey").value;
    //if (keys!=null && keys!="") keys = encodeURIComponent(keys)
    if(papams.length != 0 && pages.length != 0 && menus.length !=0)
    {
        var s = "r="+Math.random()+"&identityKeys="+papams+"&p="+pages+"&k="+keys+"&m="+menus;
        ajaxLoadPage('../getData.asp',s,"Get",objContainer,"")
    }
    else
    { 
        objContainer.value ="Loadding Failed...";
    }
}

// ��ȡ����
function getInnerData(funcNo,objContainer)
{
    if(funcNo.length > 2)
    {
        var urlParams = "r="+Math.random()+"&FuncNo="+funcNo+"&oID=&oNa=";
        switch (funcNo)
        {
            case "1.3.1":
                userLogin(funcNo,objContainer);
	            break
            default:
                ajaxLoadPage('/JcManger/UserData.Asp',urlParams,"Get",objContainer,funcNo)
        }
    }
    else
    { 
        objContainer.value ="��������ʧ�� ...";
    }
}

function getInnerDataByPara(funcNo,objContainer)
{
    if(funcNo.length > 2)
    {
        objID = document.getElementById('txtObjID').value;
        objName = document.getElementById('txtObjName').value;
        var urlParams = "r="+Math.random()+"&FuncNo="+funcNo+"&oID="+objID+"&oNa="+encodeURIComponent(objName);
        switch (funcNo)
        {
            case "1.3.1":
                userLogin(funcNo,objContainer);
	            break
            default:
                ajaxLoadPage('sysInfo/getInnerData.aspx',urlParams,"Get",objContainer,funcNo)
        }
    }
    else
    { 
        objContainer.value ="��������ʧ�� ...";
    }
}

// ����չʾ
function setInnerData(funcNo,returnText,objContainer)
{
    if(returnText.length>0)
    {
        switch (funcNo)
        {
            case "1.3.1":
                //if(returnText =="sysManageMain.aspx"){openWinows(returnText);}
                //else{objContainer.innerHTML=returnText;}
                //objContainer.innerHTML=returnText;
                window.location.href = "default.aspx";
	            break
            case "GetCardStats":
	            cStats = reTxt;
	            break
            default:
	            objContainer.innerHTML = returnText;
        }
    }
    else
    {
        openWinows("userLogin.aspx");
    }
}

// �û���¼ 
function userLogin(funcNo,objContainer)
{
    var userAcc = document.getElementById("userAccount").value;
    var userPwd = document.getElementById("userPwd").value;
    if(userAcc.length >= 2 && userPwd.length > 4)
    {
        document.getElementById("userLoginSrc").style.visibility="hidden";//visible
        userAcc = encodeURIComponent(userAcc);
        userPwd = encodeURIComponent(userPwd);
        var s = "r="+Math.random()+"&FuncNo="+funcNo+"&u="+userAcc+"&p="+userPwd;
        ajaxLoadPage('sysInfo/getInnerData.aspx',s,"Get",objContainer,funcNo)
    }
    else
    { 
        alert("�ʺŻ����벻��Ϊ��,�������볤������6λ!");
        //objContainer.value ="�ʺŻ����벻��Ϊ��,���ҳ��Ȳ���С��5���ַ�!";
    }
}

// ��ȡ�������
function getSearchData(papams,menus,pages,keys,area,traceCate,cate,orders,objContainer)
{
    if(papams.length != 0 && pages.length != 0 && menus.length !=0)
    {
        var s = "search.aspx?r="+Math.random()+"&identityKeys="+papams+"&p="+pages+"&o="+orders+"&area="+area+"&t="+traceCate+"&c="+cate+"&k="+keys;
        window.location.href = s;
    }
    else
    { 
        objContainer.value ="��������ʧ�� ...";
    }
}
// ��Ѷ�б�
function getDataList(papams,menus,pages,keys,orders,objContainer)
{
    if(papams.length != 0 && pages.length != 0 && menus.length !=0)
    {
        var s = "r="+Math.random()+"&identityKeys="+papams+"&p="+pages+"@"+orders+"@"+menus+"&k="+keys;
        ajaxLoadPage('getData.asp',s,"Get",objContainer,"")
    }
    else
    { 
        objContainer.value ="��������ʧ�� ...";
    }
}

//Email;
function isEmail(s){
	s = trim(s); 
 	var p = /^[_\.0-9a-z-]+@([0-9a-z][0-9a-z-]+\.){1,4}[a-z]{2,3}$/i; 
 	return p.test(s);
}
//Error Msg;
function ErrMsg(s){
    //var s_info = "<table width='100%' border='0' cellspacing='0' cellpadding='0' ><tr><td width='20' height='30' >&nbsp;</td><td width='800' bgcolor='#FFFFCC' style='border-bottom: 1px solid #ff9966;border-top: 1px solid #ff9966;'><font color='#CC3300'>"+s+"</font></td><td  >&nbsp;</td></tr></table>";
    var s_info = "<table width='100%' border='0' cellspacing='0' cellpadding='0' ><tr><td  bgcolor='#FFFFCC' style='border-bottom: 1px solid #ff9966;border-top: 1px solid #ff9966;'><font color='#CC3300'>"+s+"</font></td><td  >&nbsp;</td></tr></table>";
 	return s_info;
}

//����ID�õ�����
function $(ID)
{
    return document.getElementById(ID);
}

function EncodingCN(x)
{
    var ReturnMsg = "";
    if(rsCode(x,1)==239 && rsCode(x,2)==187 && rsCode(x,3)==191)
    {
        ReturnMsg = x;
    }
    else
    {
        var y=rsLength(x),z,i=1,t="";
        while(i<=y)
        {
            z=rsCode(x,i++);
            if(z<128)
            {
                t+=z;
            }
            else
            {
                t+=rsChar(z*256+rsCode(x,i++));
            }
        }
        ReturnMsg = t;
    }
    return ReturnMsg;
}

function ajaxLoadPage(url,request,method,container,funcNo)
{
    var loading_msg='�������ݣ����Ժ� ...'
	container.innerHTML=loading_msg;
    if (!window.XMLHttpRequest) {window.XMLHttpRequest=function (){return new ActiveXObject("Microsoft.XMLHTTP");}     }
	method=method.toUpperCase();
	
	var loader=new XMLHttpRequest;
	
	if (method=='GET')
	{
		urls=url.split("?");
		if (urls[1]=='' || typeof urls[1]=='undefined'){url=urls[0]+"?"+request;}
		else{url=urls[0]+"?"+urls[1]+"&"+request;}
		request=null;
	}
    //loader.setHeader("charset","gb2312");
	loader.open(method,url,true);
	//loader.setHeader("charset","gb2312");
	

	if (method=="POST")
	{
		loader.setRequestHeader("Content-Type","application/x-www-form-urlencoded;charset=gb2312");
	}

	loader.onreadystatechange=function()
	{
		if (loader.readyState==1){container.innerHTML=loading_msg + " ...";}
		if (loader.readyState==4)
		{
		    if(loader.status==200)
		    {
		        setInnerData(funcNo,loader.responseText,container);
		    }else{container.innerHTML=reTxt;loader = null;}
		}
	}
	loader.send(request);
}
// ����Ԫ��ת��Ϊ�����ִ�
function formToRequestString(form_obj)
{
	var query_string='';
	var and='';
	for (i=0;i<form_obj.length ;i++ )
	{
		e=form_obj[i];
		if (e.name!='') 
		{
			if (e.type=='select-one')
			{
				element_value=e.options[e.selectedIndex].value;
			}
			else if (e.type=='checkbox' || e.type=='radio')
			{
				if (e.checked==false){continue;}
				element_value=e.value;
			}
			else
			{
			    if(e.name=="__VIEWSTATE"){element_value="";}
			    if(e.name=="FCKeditor1")
			    {
			        var oEditor = FCKeditorAPI.GetInstance('FCKeditor1') ;
			        element_value=oEditor.GetXHTML( true );
			    }
			    else{element_value=e.value;}
			}
			query_string+=and+e.name+'='+element_value.replace(/\&/g,"%26");
			and="&"
		}
	}
	return query_string;
}

function ajaxFormSubmit(form_obj,container)
{
    ajaxLoadPage('base-processdata.aspx',formToRequestString(form_obj),form_obj.method,container,"fck");
}

// �鿴��ϸ
function view()
{
    var k = document.getElementById("ClickID").value;
    var m = document.getElementById("K").value;
    if(k.length != 0)
    {
        var url = "base-view.aspx";
        //window.location.href=url +"?k="+ k;
        openWinows(url +"?t=Ysl_&m="+m+"&k="+ k);
    }
    else
    { 
        alert("�뵥��ѡ������Ҫ�鿴�ı����У�Ȼ���ٵ�����鿴����ť������ֱ��˫��������Ҳ�ɲ鿴��");
    }
}

// ˫���鿴
function viewOnDblClick(id)
{
    var m = document.getElementById("K").value;
    var url="base-view.aspx";
    openWinows(url +"?t=Ysl_&m="+m+"&k="+ id);
}

// ����
function add()
{
    var url = "base-edit.aspx";
    var m = document.getElementById("K").value;
    openWinows(url +"?m="+m+"&act=add&k=0&t=Ysl_");
}
// �༭
function edit()
{
    var k = document.getElementById("ClickID").value;
    if(k.length != 0)
    {
        var url = "base-edit.aspx";
        var m = document.getElementById("K").value;
        openWinows(url +"?m="+m+"&t=Ysl_&act=edit&k="+ k);
        
    }
    else
    { 
        alert("�뵥��ѡ������Ҫ�༭�������У�Ȼ���ٵ�����༭����ť��");
    }
}

// ɾ��
function del()
{
    //document.form1.v_ItemChk.value =GetChkItems()
    var k = document.getElementById("ClickID").value;
    var m = document.getElementById("K").value;
    if(k.length != 0)
    {
        if(confirm("��ɾ��֮ǰ��������ȷ��һ�Σ������Ҫɾ��ѡ�е�������")==true)
        {
            ExecSCommand(k,m,"",document.getElementById("MsgInfo"));
            window.location.reload(true);
        }
    }
    else
    { 
        alert("�뵥��ѡ������Ҫɾ���������У�Ȼ���ٵ����ɾ������ť��");
    }
}
//
function   createxmlhttprequest()   
    {   
      var   xmlhttp=false;   
         try   
          {   
           xmlhttp=new   ActiveXObject('Msxm12.XMLHTTP');   
          }   
          catch(e)   
           {   
            try   
             {   
              xmlhttp=new   ActiveXObject('Microsoft.XMLHTTP');   
              }   
             catch(e)   
              {   
                try   
                 {   
                   xmlhttp=new   XmlHttpRequest();   
                 }   
                   catch(e)   
                   {   
                    }   
                 }   
              }   
             return   xmlhttp;   
          } 
  //
function   Userajaxcheck()   
 {   
  var   xmlhttp=createxmlhttprequest();   
  //var   requestid=$(requestname);   
 // xmlhttp.open('get',url+'?ID='+requestid.value+'action='+actionp);   
 xmlhttp.open('get','ajaxdata.asp?ID=jiangtao'); 
  xmlhttp.onreadystatechange=function()   
   {   
     if(xmlhttp.readyState==4)   
      {   
                            
       if(xmlhttp.status==200)   
         {   
           if(xmlhttp.responseText=="1")   
             {         
              document.getElementById("IsOkUserName").innerText='�����Ѵ���';   
             }   
              else   
             {   
              document.getElementById("IsOkUserName").innerText='����ע��';   
             }   
             }   
          }   
        }   
       xmlhttp.send(null);   
     }   
    
