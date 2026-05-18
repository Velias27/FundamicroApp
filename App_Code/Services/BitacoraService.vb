Imports System.Data
Imports System.Data.SqlClient
Imports System.Configuration

Namespace Services
    Public Class BitacoraService
        Private ReadOnly connString As String = ConfigurationManager.ConnectionStrings("FundamicroConn").ConnectionString

        Public Function ObtenerBitacora() As DataTable
            Dim dt As New DataTable()
            Using conn As New SqlConnection(connString)
                ' Ordenamos por fecha descendente para ver lo más reciente primero
                Dim query As String = "SELECT BitacoraID, Accion, ClienteID, DetalleCambio, Username, FechaHora FROM Bitacora ORDER BY FechaHora DESC"
                Using cmd As New SqlCommand(query, conn)
                    Using adapter As New SqlDataAdapter(cmd)
                        adapter.Fill(dt)
                    End Using
                End Using
            End Using
            Return dt
        End Function
    End Class
End Namespace