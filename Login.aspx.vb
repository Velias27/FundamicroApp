
Imports FundamicroApp.Services

Partial Class Login
    Inherits System.Web.UI.Page

    Protected Sub btnLogin_Click(sender As Object, e As EventArgs)
        Dim auth As New AuthService()

        If auth.ValidarUsuario(txtUsuario.Text.Trim(), txtPassword.Text.Trim()) Then
            FormsAuthentication.SetAuthCookie(txtUsuario.Text.Trim(), False)
            Response.Redirect("Clientes.aspx", False)
        Else
            lblError.Text = "Credenciales incorrectas."
        End If
    End Sub
End Class