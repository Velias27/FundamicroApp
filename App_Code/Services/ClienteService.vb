Imports System.Data
Imports System.Data.SqlClient
Imports System.Configuration

Namespace Services
    Public Class ClienteService
        Private ReadOnly connString As String = ConfigurationManager.ConnectionStrings("FundamicroConn").ConnectionString

        Public Function ObtenerClientes() As DataTable
            Dim dt As New DataTable()
            Using conn As New SqlConnection(connString)
                Dim query As String = "SELECT * FROM Clientes ORDER BY ClienteID DESC"
                Using cmd As New SqlCommand(query, conn)
                    Using adapter As New SqlDataAdapter(cmd)
                        adapter.Fill(dt)
                    End Using
                End Using
            End Using
            Return dt
        End Function

        Public Sub GuardarCliente(id As Integer, nombres As String, apellidos As String, doc As String, email As String, tel As String, usuario As String, accion As String)
            Using conn As New SqlConnection(connString)
                Using cmd As New SqlCommand("sp_Clientes_Guardar", conn)
                    cmd.CommandType = CommandType.StoredProcedure
                    cmd.Parameters.AddWithValue("@ClienteID", id)
                    cmd.Parameters.AddWithValue("@Nombres", nombres)
                    cmd.Parameters.AddWithValue("@Apellidos", apellidos)
                    cmd.Parameters.AddWithValue("@DocumentoIdentidad", doc)
                    cmd.Parameters.AddWithValue("@Email", email)
                    cmd.Parameters.AddWithValue("@Telefono", tel)
                    cmd.Parameters.AddWithValue("@Username", usuario)
                    cmd.Parameters.AddWithValue("@Accion", accion)
                    conn.Open()
                    cmd.ExecuteNonQuery()
                End Using
            End Using
        End Sub

        Public Sub EliminarCliente(id As Integer, usuario As String)
            Using conn As New SqlConnection(connString)
                Using cmd As New SqlCommand("sp_Clientes_Eliminar", conn)
                    cmd.CommandType = CommandType.StoredProcedure
                    cmd.Parameters.AddWithValue("@ClienteID", id)
                    cmd.Parameters.AddWithValue("@Username", usuario)
                    conn.Open()
                    cmd.ExecuteNonQuery()
                End Using
            End Using
        End Sub
    End Class
End Namespace