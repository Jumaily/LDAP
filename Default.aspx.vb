Imports System.DirectoryServices
Imports System.Xml


Partial Class _Default
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim uid = Request.QueryString("id")
        Dim namestring = ""
        If uid <> "" Then
            namestring = SearchADByAccount(uid, "LDAP://mc.uky.edu")
            If namestring = "" Then
                namestring = SearchADByAccount(uid, "LDAP://ad.uky.edu")
            End If
            Response.Write(namestring)
        End If
    End Sub



    Private Function SearchADByAccount(ByVal userid As String, ByVal domainx As String) As String

        Dim oRoot As DirectoryEntry = New DirectoryEntry(domainx)
        Dim oSearcher As DirectorySearcher = New DirectorySearcher(oRoot)
        Dim oResults As SearchResultCollection
        Dim oResult As SearchResult
        Dim search As String = userid
        Dim unamestring As String = ""

        oSearcher.Filter = "(&(objectClass=*)(cn=" & search & "))"

        oSearcher.PropertiesToLoad.Add("givenname")
        oSearcher.PropertiesToLoad.Add("sn")

        oResults = oSearcher.FindAll
        Dim RetArray As New Hashtable()
        oResults = oSearcher.FindAll

        Dim settings As New XmlWriterSettings()
        settings.Indent = True
        settings.NewLineOnAttributes = True

        For Each oResult In oResults
            If Not oResult.GetDirectoryEntry().Properties("cn").Value = "" Then
                unamestring = (oResult.GetDirectoryEntry().Properties("givenname").Value & ":" & oResult.GetDirectoryEntry().Properties("sn").Value)
            End If
        Next

        Return unamestring
    End Function

End Class
