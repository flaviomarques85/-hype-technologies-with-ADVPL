#Include "TOTVS.CH"
#Include "RESTFUL.CH"
#Include "protheus.ch"
#Include "aarray.ch"
#Include "json.ch" 
//----------------------------------------------------------------------------- 
/*/{Protheus.doc} APILOGIN
Serviço Rest de Validacao de usuario e senha

{server}/rest/APILOGIN?usuario=admin&senha=
/*/ 
//----------------------------------------------------------------------------- 
                      
 
WSRESTFUL APILOGIN DESCRIPTION "Valida Usuario e Senha"
 
    WSDATA USUARIO  AS STRING
    WSDATA SENHA 	AS STRING
    
    WSMETHOD GET DESCRIPTION "Valida Usuario e Senha" WSSYNTAX "/JLOGIN || /JLOGIN/"
 
END WSRESTFUL
 


//WSMETHOD GET WSRECEIVE USUARIO,SENHA WSSERVICE JLOGIN
WSMETHOD GET WSSERVICE APILOGIN
    Local lRetFun  := .T.
    Local aBody    := { }
    
    // define o tipo de retorno do método
    ::SetContentType("application/json")  //--::aURLParms
    //--Obtem o conteudo do corpo
    aBody := FromJson(::GetContent())

    cUser := Lower(AllTrim( aBody[# 'user'] ))
    cPass := AllTrim( aBody[# 'password'] )                                        
    PswOrder(2)
    
	If Empty(cUser) .Or. Empty(cPass) .Or. !PswSeek(cUser) .Or. !PswName(cPass)
	   
	   SetRestFault(400,"Usuario ou senha invalidos.")
	   lRetFun := .F. 
	   
	Else
        //Gerar um webTonken  e devolver ao client Side

	   ::SetResponse('{"Response":"OK"}')
   
	EndIf
	
Return(lRetFun)
