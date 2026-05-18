<%@ Page Language="VB" AutoEventWireup="false" CodeBehind="Login.aspx.vb" Inherits="FundamicroApp.Login" %>
<!DOCTYPE html>
<html lang="es">
<head runat="server">
    <title>Login - Fundamicro</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
</head>
<body class="bg-light d-flex align-items-center vh-100">
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-md-4">
                <div class="card shadow-sm p-4">
                    <h4 class="text-center mb-4">Acceso al Sistema</h4>
                    <form id="form1" runat="server">
                        <asp:Label ID="lblError" runat="server" CssClass="text-danger mb-3 d-block"></asp:Label>
                        <div class="mb-3">
                            <label>Usuario</label>
                            <asp:TextBox ID="txtUsuario" runat="server" CssClass="form-control" Required="true"></asp:TextBox>
                        </div>
                        <div class="mb-3"> 
                            <label>Contraseña</label>
                            <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control" TextMode="Password" Required="true"></asp:TextBox>
                        </div>
                        <asp:Button ID="btnLogin" runat="server" Text="Entrar" CssClass="btn btn-primary w-100" OnClick="btnLogin_Click" />
                    </form>
                </div>
            </div>
        </div>
    </div>
</body>
</html>