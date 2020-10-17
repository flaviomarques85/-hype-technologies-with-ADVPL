#Include "TOTVS.CH"
#Include "RESTFUL.CH"
#Include "protheus.ch"

//----------------------------------------------------------------------------- 
/*/{Protheus.doc} JLOGIN
Serviço Rest de Validacao de usuario e senha

{server}/rest/JLOGIN?usuario=admin&senha=
/*/ 
//----------------------------------------------------------------------------- 
                      
 
WSRESTFUL JLOGIN DESCRIPTION "Valida Usuario e Senha"
 
    WSDATA USUARIO  AS STRING
    WSDATA SENHA 	AS STRING
    
    WSMETHOD GET DESCRIPTION "Valida Usuario e Senha" WSSYNTAX "/JLOGIN || /JLOGIN/{USUARIO,SENHA}"
 
END WSRESTFUL
 


WSMETHOD GET WSRECEIVE USUARIO,SENHA WSSERVICE JLOGIN
    Local lRetFun  := .T.
    
    // define o tipo de retorno do método
    ::SetContentType("application/json")  //--::aURLParms
                                            
    PswOrder(2)
    
	If Empty(::USUARIO) .Or. Empty(::SENHA) .Or. !PswSeek(::USUARIO) .Or. !PswName(::SENHA)
	   
	   SetRestFault(400,"Usuario ou senha invalidos.")
	   lRetFun := .F. 
	   
	Else
        //Gerar um webTonken  e devolver ao client Side

	   ::SetResponse('{"Response":"OK"}')
   
	EndIf
	
Return(lRetFun)
