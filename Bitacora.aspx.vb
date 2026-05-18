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
End Class