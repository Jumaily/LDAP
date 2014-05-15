// Taha Al-jumaily -  University of KY LDAP authentication
<%
On Error Resume Next
If Request.Form("strUsername") <> "" Then
      Response.Write "Authenticating... "

      ' dim some vars
      Dim strADsPath
      Dim strUserName
      Dim strPassword
      Dim strRawName
      Dim intLen
      Dim intStart
      
      ' set the path to the active directory
      strADsPath = "WinNT://ad"
      strUserName = Request.Form("strUserName")
      strPassword = Request.Form("strPassword")
      If (not strADsPath= "") Then 
            Dim oADsObject
            Set oADsObject = GetObject(strADsPath)
            Dim strADsNamespace
            Dim oADsNamespace
            strADsNamespace = left(strADsPath, instr(strADsPath, ":"))
            Set oADsNamespace = GetObject(strADsNamespace)
            Set oADsObject = oADsNamespace.OpenDSObject(strADsPath, strUserName, strPassword, 0)
            If Not (Err.number = 0) Then
                  Response.Write "<font color='red'> failed!</font><br><br>Please be sure to enter your " & _
                        "userid in the form " & chr(34) & "mc\userid" & chr(34) & " or " & chr(34) & "ad\userid" & chr(34) & " (sans quotes)."
                  'Response.Write "Failed to bind to object <b>" & strADsPath & "</b><br>"
                  'Response.Write err.description & "<p>"
                  'Response.Write "Error number is " & err.number & "<br>"
                  Session("Auth") = ""
                  Session("UserID") = ""
            Else
                  intLen = Len(strUserName)
                  intStart = (intLen - InStr(strUserName, "\"))
                  strRawName = Right(strUserName, intStart)
                  'Response.Write "Username is: <b>" & strRawName & "</b><br>"
                  'Response.Write "Currently viewing object at <b>" & oADsObject.ADsPath & "</b><br>"
                  'Response.Write "Class is <b>" & oADsObject.Class & "</b><br>"
                  Session("Auth") =  (RandomNumber(33213202))
                  Session("UserID") = Trim(strRawName)
                  Response.Redirect("main.asp")
                  
                  Response.Write(strRawName)
            End If
      End If
End If
%>
