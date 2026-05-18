<%@ Page Language="VB" AutoEventWireup="false" CodeBehind="Default.aspx.vb" Inherits="FundamicroApp._Default" %>

<!DOCTYPE html>
<html lang="es">
<head runat="server">
    <title>Gestión de Clientes</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
</head>
<body class="bg-light">
    <form id="form1" runat="server">
        <nav class="navbar navbar-dark bg-dark mb-4 px-3">
            <span class="navbar-brand">Fundamicro - Clientes</span>
            <div>
                <a href="Bitacora.aspx" class="btn btn-outline-info btn-sm me-2">Ver Bitácora</a>
                <asp:Button ID="btnSalir" runat="server" Text="Cerrar Sesión" CssClass="btn btn-danger btn-sm" OnClick="btnSalir_Click" CausesValidation="false" />
            </div>
        </nav>
        <div class="container bg-white p-4 shadow-sm rounded">
            <div class="d-flex justify-content-between mb-3">
                <h5>Directorio de Clientes</h5>
                <asp:Button ID="btnNuevo" runat="server" Text="Nuevo Cliente" CssClass="btn btn-success" OnClick="btnNuevo_Click" />
            </div>
            <asp:Label ID="lblMensaje" runat="server" CssClass="d-block mb-2 font-weight-bold"></asp:Label>

            <asp:GridView ID="gvClientes" runat="server" AutoGenerateColumns="False" DataKeyNames="ClienteID" CssClass="table table-bordered table-striped" OnRowCommand="gvClientes_RowCommand">
                <Columns>
                    <asp:BoundField DataField="ClienteID" HeaderText="ID" />
                    <asp:BoundField DataField="Nombres" HeaderText="Nombres" />
                    <asp:BoundField DataField="Apellidos" HeaderText="Apellidos" />
                    <asp:BoundField DataField="DocumentoIdentidad" HeaderText="Documento" />
                    <asp:BoundField DataField="Telefono" HeaderText="Teléfono" />
                    <asp:TemplateField HeaderText="Acciones">
                        <ItemTemplate>
                            <asp:Button ID="btnEditar" runat="server" CommandName="Editar" CommandArgument='<%# Container.DataItemIndex %>' Text="Editar" CssClass="btn btn-primary btn-sm" />
                            <asp:Button ID="btnEliminar" runat="server" CommandName="Eliminar" CommandArgument='<%# Eval("ClienteID") %>' Text="Eliminar" CssClass="btn btn-danger btn-sm" OnClientClick="return confirm('¿Seguro que desea eliminar?');" />
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>

            <asp:Panel ID="pnlFormulario" runat="server" Visible="false" CssClass="card mt-4 border-primary">
                <div class="card-header bg-primary text-white">Formulario de Cliente</div>
                <div class="card-body row g-3">
                    <asp:HiddenField ID="hfID" runat="server" />
                    <div class="col-md-6">
                        <label>Nombres</label><asp:TextBox ID="txtNombres" runat="server" CssClass="form-control" Required="true"></asp:TextBox></div>
                    <div class="col-md-6">
                        <label>Apellidos</label><asp:TextBox ID="txtApellidos" runat="server" CssClass="form-control" Required="true"></asp:TextBox></div>
                    <div class="col-md-6">
                        <label>Documento Identidad</label><asp:TextBox ID="txtDoc" runat="server" CssClass="form-control" Required="true"></asp:TextBox></div>
                    <div class="col-md-6">
                        <label>Teléfono</label><asp:TextBox ID="txtTel" runat="server" CssClass="form-control"></asp:TextBox></div>
                    <div class="col-md-12">
                        <label>Email</label><asp:TextBox ID="txtEmail" runat="server" CssClass="form-control"></asp:TextBox></div>
                </div>
                <div class="card-footer text-end">
                    <asp:Button ID="btnCancelar" runat="server" Text="Cancelar" CssClass="btn btn-secondary" OnClick="btnCancelar_Click" CausesValidation="false" />
                    <asp:Button ID="btnGuardar" runat="server" Text="Guardar" CssClass="btn btn-primary" OnClick="btnGuardar_Click" />
                </div>
            </asp:Panel>
        </div>
    </form>
</body>
</html>
