<%@ Page Language="VB" AutoEventWireup="false" CodeBehind="Clientes.aspx.vb" Inherits="FundamicroApp.Clientes" %>

<!DOCTYPE html>
<html lang="es">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Gestión de Clientes - FUNDAMICRO</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet" />
    <link href="Content/clientes.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
        <nav class="navbar navbar-dark navbar-custom mb-4 shadow-sm">
            <div class="container-fluid">
                <span class="navbar-brand mb-0 h1 fw-bold"><i class="bi bi-people-fill me-2"></i>FUNDAMICRO</span>
                <div class="d-flex align-items-center">
                    <span class="text-light me-3">Usuario: <strong class="text-warning"><%= User.Identity.Name %></strong></span>
                    <a href="Bitacora.aspx" class="btn btn-custom-accent btn-sm me-2"><i class="bi bi-journal-text me-1"></i>Bitácora</a>
                    <asp:Button ID="btnSalir" runat="server" Text="Cerrar Sesión" CssClass="btn btn-outline-danger btn-sm" OnClick="btnSalir_Click" CausesValidation="false" />
                </div>
            </div>
        </nav>

        <div class="container">
            <div class="card card-custom">
                <div class="card-header bg-white d-flex justify-content-between align-items-center py-3 border-0">
                    <h5 class="mb-0 fw-bold text-secondary">Listado General de Clientes</h5>
                    <asp:Button ID="btnNuevo" runat="server" Text="+ Registrar Cliente" CssClass="btn btn-custom-primary btn-sm px-3" OnClick="btnNuevo_Click" />
                </div>
                <div class="card-body">
                    <asp:Label ID="lblMensaje" runat="server" CssClass="d-block mb-3 p-2 rounded text-center" Visible="false"></asp:Label>

                    <div class="table-responsive">
                        <asp:GridView ID="gvClientes" runat="server" AutoGenerateColumns="False" DataKeyNames="ClienteID, Email"
                            CssClass="table table-hover align-middle border-0" GridLines="None" OnRowCommand="gvClientes_RowCommand">
                            <Columns>
                                <asp:BoundField DataField="ClienteID" HeaderText="ID" HeaderStyle-CssClass="table-custom th" />
                                <asp:BoundField DataField="Nombres" HeaderText="Nombres" HeaderStyle-CssClass="table-custom th" />
                                <asp:BoundField DataField="Apellidos" HeaderText="Apellidos" HeaderStyle-CssClass="table-custom th" />
                                <asp:BoundField DataField="DocumentoIdentidad" HeaderText="Documento" HeaderStyle-CssClass="table-custom th" />
                                <asp:BoundField DataField="Telefono" HeaderText="Teléfono" HeaderStyle-CssClass="table-custom th" />
                                <asp:TemplateField HeaderText="Acciones" HeaderStyle-CssClass="table-custom th text-center" ItemStyle-CssClass="text-center">
                                    <ItemTemplate>
                                        <asp:LinkButton ID="lnkEdit" runat="server" CommandName="Editar" CommandArgument='<%# Container.DataItemIndex %>' CssClass="btn btn-sm btn-outline-primary me-1"><i class="bi bi-pencil-square"></i></asp:LinkButton>
                                        <asp:LinkButton ID="lnkDelete" runat="server" CommandName="Eliminar" CommandArgument='<%# Eval("ClienteID") %>' CssClass="btn btn-sm btn-outline-danger" OnClientClick="return confirm('¿Está seguro de eliminar este cliente?');"><i class="bi bi-trash-fill"></i></asp:LinkButton>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                    </div>
                </div>
            </div>
        </div>

        <asp:Panel ID="pnlFormulario" runat="server" Visible="false" CssClass="modal-overlay-custom">
            <div class="card w-50 shadow-lg border-0" style="border-radius: 1rem; overflow: hidden;">
                <div class="card-header text-white" style="background-color: #1C2540; border-bottom: 3px solid #F2BD1D;">
                    <h5 class="card-title mb-0 fw-bold"><i class="bi bi-person-vcard-fill me-2"></i>Datos del Cliente</h5>
                </div>
                <div class="card-body p-4 bg-light">
                    <asp:HiddenField ID="hfID" runat="server" />
                    <div class="row g-3">
                        <div class="col-md-6">
                            <label class="form-label text-muted small fw-bold">Nombres</label>
                            <asp:TextBox ID="txtNombres" runat="server" CssClass="form-control" Required="true"></asp:TextBox>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label text-muted small fw-bold">Apellidos</label>
                            <asp:TextBox ID="txtApellidos" runat="server" CssClass="form-control" Required="true"></asp:TextBox>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label text-muted small fw-bold">Documento Identidad</label>
                            <asp:TextBox ID="txtDoc" runat="server" CssClass="form-control" Required="true"></asp:TextBox>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label text-muted small fw-bold">Teléfono (opcional)</label>
                            <asp:TextBox ID="txtTel" runat="server" CssClass="form-control"></asp:TextBox>
                        </div>
                        <div class="col-12">
                            <label class="form-label text-muted small fw-bold">Correo Electrónico (opcional)</label>
                            <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" TextMode="Email"></asp:TextBox>
                        </div>
                    </div>
                </div>
                <div class="card-footer bg-white d-flex justify-content-end p-3 border-0">
                    <asp:Button ID="btnCancelar" runat="server" Text="Cancelar" CssClass="btn btn-secondary me-2 px-4" OnClick="btnCancelar_Click" CausesValidation="false" formnovalidate="formnovalidate" />
                    <asp:Button ID="btnGuardar" runat="server" Text="Guardar Registro" CssClass="btn btn-custom-primary px-4" OnClick="btnGuardar_Click" />
                </div>
            </div>
        </asp:Panel>
    </form>
</body>
</html>
