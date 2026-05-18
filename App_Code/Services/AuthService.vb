Imports System.Data.SqlClient
Imports System.Configuration
Imports System.Data

Namespace Services
    Public Class AuthService
        Private ReadOnly connString As String = ConfigurationManager.ConnectionStrings("FundamicroConn").ConnectionString

        Public Function ValidarUsuario(username As String, password As String) As Boolean
            Dim hashPassword As String = HashHelper.GenerarSHA256(password)
            Using conn As New SqlConnection(connString)
                Using cmd As New SqlCommand("sp_Usuarios_ValidarCredenciales", conn)
                    cmd.CommandType = CommandType.StoredProcedure
                    cmd.Parameters.AddWithValue("@Username", username)
                    Dim dt As New DataTable()
                    Using adapter As New SqlDataAdapter(cmd)
                        adapter.Fill(dt)
                    End Using
                    If dt.Rows.Count > 0 Then
                        Dim dbHash As String = dt.Rows(0)("PasswordHash").ToString()
                        Return dbHash.Equals(hashPassword, StringComparison.OrdinalIgnoreCase)
                    End If
                End Using
            End Using
            Return False
        End Function
    End Class
End Namespace