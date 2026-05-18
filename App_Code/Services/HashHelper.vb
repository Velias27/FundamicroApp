Imports System.Security.Cryptography
Imports System.Text

Namespace Services
    Public Class HashHelper
        Public Shared Function GenerarSHA256(ByVal textoPlano As String) As String
            Using sha256Hash As SHA256 = SHA256.Create()
                Dim bytes As Byte() = sha256Hash.ComputeHash(Encoding.UTF8.GetBytes(textoPlano))
                Dim builder As New StringBuilder()
                For i As Integer = 0 To bytes.Length - 1
                    builder.Append(bytes(i).ToString("x2"))
                Next
                Return builder.ToString()
            End Using
        End Function
    End Class
End Namespace