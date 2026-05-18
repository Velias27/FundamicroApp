Imports FundamicroApp.Services

Partial Class Bitacora
    Inherits System.Web.UI.Page
    Private ReadOnly svc As New BitacoraService()

    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
        If Not User.Identity.IsAuthenticated Then Response.Redirect("Login.aspx")
        If Not IsPostBack Then CargarGrid()
    End Sub

    Private Sub CargarGrid()
        gvBitacora.DataSource = svc.ObtenerBitacora()
        gvBitacora.DataBind()
    End Sub

    Protected Sub btnSalir_Click(sender As Object, e As EventArgs)
        System.Web.Security.FormsAuthentication.SignOut()
        Response.Redirect("Login.aspx")
    End Sub

    Protected Function GetBadgeClass(accion As String) As String
        Select Case accion.ToUpper()
            Case "AGREGAR"
                Return "badge-accion badge-agregar"
            Case "EDITAR"
                Return "badge-accion badge-editar"
            Case "ELIMINAR"
                Return "badge-accion badge-eliminar"
            Case Else
                Return "badge-accion bg-secondary text-white"
        End Select
    End Function
    Protected Sub gvBitacora_RowCommand(sender As Object, e As GridViewCommandEventArgs)
        If e.CommandName = "VerDetalle" Then
            ' Obtenemos el índice de la fila donde se hizo clic
            Dim index As Integer = Convert.ToInt32(e.CommandArgument)
            ' Extraemos el detalle completo directo desde la memoria (DataKeys)
            Dim detalleCompleto As String = gvBitacora.DataKeys(index).Values("DetalleCambio").ToString()
            ' Lo asignamos al Literal del modal y mostramos el panel
            litDetalleCompleto.Text = detalleCompleto
            pnlModalDetalle.Visible = True
        End If
    End Sub

    Protected Sub btnCerrarModal_Click(sender As Object, e As EventArgs)
        ' Ocultamos el panel al hacer clic en Cerrar
        pnlModalDetalle.Visible = False
    End Sub
End Class