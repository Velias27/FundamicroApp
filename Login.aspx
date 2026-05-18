<%@ Page Language="VB" AutoEventWireup="false" CodeBehind="Login.aspx.vb" Inherits="FundamicroApp.Login" %>

<!DOCTYPE html>
<html lang="es">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Acceso al Sistema - FUNDAMICRO</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet" />

    <link href="Content/login.css" rel="stylesheet" />
</head>
<body class="d-flex align-items-center justify-content-center">
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-12 col-md-8 col-lg-5">

                <div class="card login-card">

                    <div class="login-header">
                        <i class="bi bi-shield-lock-fill" style="font-size: 3.5rem;"></i>
                        <h3 class="mt-3 mb-0 fw-bold">FUNDAMICRO</h3>
                        <p class="mb-0 text-white-50">Sistema de Gestión de Clientes</p>
                    </div>

                    <div class="login-body">
                        <h5 class="text-center mb-4 fw-light text-secondary">Ingresa tus credenciales</h5>

                        <form id="form1" runat="server">
                            
                            <div class="form-floating mb-3">
                                <asp:TextBox ID="txtUsuario" runat="server" CssClass="form-control" placeholder="Usuario" Required="true" autocomplete="off"></asp:TextBox>
                                <label for="txtUsuario" class="text-muted"><i class="bi bi-person-fill me-2"></i>Usuario</label>
                            </div>

                            <div class="form-floating mb-4">
                                <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control" TextMode="Password" placeholder="Contraseña" Required="true"></asp:TextBox>
                                <label for="txtPassword" class="text-muted"><i class="bi bi-key-fill me-2"></i>Contraseña</label>
                            </div>

                            <asp:Label ID="lblError" runat="server" CssClass="text-danger mb-3 d-block text-center fw-bold"></asp:Label>

                            <asp:Button ID="btnLogin" runat="server" Text="Iniciar Sesión" CssClass="btn w-100 btn-login fw-bold" OnClick="btnLogin_Click" />
                        </form>
                    </div>
                </div>

                <div class="text-center mt-3">
                    <small class="text-muted">© <%= DateTime.Now.Year %> Fundamicro. Todos los derechos reservados.</small>
                </div>

            </div>
        </div>
    </div>
</body>
</html>
