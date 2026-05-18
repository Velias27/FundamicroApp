Imports FundamicroApp.Services

Partial Class _Default
    Inherits System.Web.UI.Page
    Private ReadOnly svc As New ClienteService()

    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
        If Not User.Identity.IsAuthenticated Then Response.Redirect("Login.aspx")
        If Not IsPostBack Then CargarGrid()
    End Sub

    Private Sub CargarGrid()
        gvClientes.DataSource = svc.ObtenerClientes()
        gvClientes.DataBind()
    End Sub

    Protected Sub btnSalir_Click(sender As Object, e As EventArgs)
        System.Web.Security.FormsAuthentication.SignOut()
        Response.Redirect("Login.aspx")
    End Sub

    Protected Sub btnNuevo_Click(sender As Object, e As EventArgs)
        Limpiar()
        hfID.Value = "0"
        pnlFormulario.Visible = True
    End Sub

    Protected Sub gvClientes_RowCommand(sender As Object, e As GridViewCommandEventArgs)
        If e.CommandName = "Editar" Then
            Dim index As Integer = Convert.ToInt32(e.CommandArgument)
            Dim row As GridViewRow = gvClientes.Rows(index)
            hfID.Value = gvClientes.DataKeys(index).Value.ToString()
            txtNombres.Text = Server.HtmlDecode(row.Cells(1).Text)
            txtApellidos.Text = Server.HtmlDecode(row.Cells(2).Text)
            txtDoc.Text = Server.HtmlDecode(row.Cells(3).Text)
            Dim tel As String = Server.HtmlDecode(row.Cells(4).Text)
            txtTel.Text = If(tel = "&nbsp;" OrElse tel.Trim() = "", "", tel)
            pnlFormulario.Visible = True
        ElseIf e.CommandName = "Eliminar" Then
            svc.EliminarCliente(Convert.ToInt32(e.CommandArgument), User.Identity.Name)
            lblMensaje.Text = "Cliente eliminado. Acción registrada en bitácora."
            CargarGrid()
        End If
    End Sub

    Protected Sub btnGuardar_Click(sender As Object, e As EventArgs)
        Dim id As Integer = Convert.ToInt32(hfID.Value)
        Dim accion As String = If(id = 0, "AGREGAR", "EDITAR")
        svc.GuardarCliente(id, txtNombres.Text, txtApellidos.Text, txtDoc.Text, txtEmail.Text, txtTel.Text, User.Identity.Name, accion)
        pnlFormulario.Visible = False
        lblMensaje.Text = "Operación exitosa. Acción registrada en bitácora por: " & User.Identity.Name
        CargarGrid()
    End Sub

    Protected Sub btnCancelar_Click(sender As Object, e As EventArgs)
        pnlFormulario.Visible = False
    End Sub

    Private Sub Limpiar()
        txtNombres.Text = "" : txtApellidos.Text = "" : txtDoc.Text = "" : txtTel.Text = "" : txtEmail.Text = ""
    End Sub
End Class