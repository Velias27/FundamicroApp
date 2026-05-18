<%@ Page Language="VB" AutoEventWireup="false" CodeBehind="Bitacora.aspx.vb" Inherits="FundamicroApp.Bitacora" %>

<!DOCTYPE html>
<html lang="es">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Bitácora de Auditoría - FUNDAMICRO</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet" />
    <link href="Content/bitacora.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
        <nav class="navbar navbar-dark navbar-custom mb-4 shadow-sm">
            <div class="container-fluid">
                <span class="navbar-brand mb-0 h1 fw-bold"><i class="bi bi-shield-check me-2"></i>AUDITORÍA</span>
                <div class="d-flex">
                    <a href="Clientes.aspx" class="btn btn-outline-light btn-sm me-2">
                        <i class="bi bi-arrow-left me-1"></i>Gestión de Clientes
                    </a>
                </div>
            </div>
        </nav>

        <div class="container">
            <div class="card card-audit p-4">
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <h4 class="fw-bold mb-0 text-secondary">Registro de Actividades</h4>
                    <span class="badge bg-dark">Logs de Sistema</span>
                </div>

                <div class="table-responsive">
                    <asp:GridView ID="gvBitacora" runat="server" AutoGenerateColumns="False"
                        DataKeyNames="BitacoraID, DetalleCambio" OnRowCommand="gvBitacora_RowCommand"
                        CssClass="table table-hover align-middle border-0" GridLines="None">
                        <Columns>
                            <asp:BoundField DataField="BitacoraID" HeaderText="ID" HeaderStyle-CssClass="table-audit th" />

                            <asp:TemplateField HeaderText="Acción" HeaderStyle-CssClass="table-audit th">
                                <ItemTemplate>
                                    <span class='<%# GetBadgeClass(Eval("Accion").ToString()) %>'>
                                        <%# Eval("Accion") %>
                                    </span>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:BoundField DataField="ClienteID" HeaderText="ID Cliente" HeaderStyle-CssClass="table-audit th" />

                            <asp:TemplateField HeaderText="Detalles" HeaderStyle-CssClass="table-audit th">
                                <ItemTemplate>
                                    <div class="d-flex align-items-center justify-content-between">
                                        <div class="text-detail" style="max-width: 250px;">
                                            <%# Eval("DetalleCambio") %>
                                        </div>
                                        <asp:LinkButton ID="btnVer" runat="server" CommandName="VerDetalle" CommandArgument='<%# Container.DataItemIndex %>' CssClass="btn btn-sm btn-outline-info border-0 py-0" title="Ver detalle completo">
                                            <i class="bi bi-eye-fill"></i>
                                        </asp:LinkButton>
                                    </div>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:BoundField DataField="Username" HeaderText="Usuario" HeaderStyle-CssClass="table-audit th" />
                            <asp:BoundField DataField="FechaHora" HeaderText="Fecha/Hora"
                                DataFormatString="{0:dd/MM/yyyy HH:mm:ss}" HeaderStyle-CssClass="table-audit th" />
                        </Columns>
                    </asp:GridView>
                </div>
            </div>
        </div>
        <asp:Panel ID="pnlModalDetalle" runat="server" Visible="false" CssClass="modal-overlay-custom">
            <div class="card shadow-lg border-0" style="width: 650px; max-width: 90%; border-radius: 1rem; overflow: hidden;">
                <div class="card-header text-white d-flex justify-content-between align-items-center" style="background-color: #1C2540; border-bottom: 3px solid #F2BD1D;">
                    <h5 class="card-title mb-0 fw-bold"><i class="bi bi-search me-2"></i>Detalle de la Acción</h5>
                </div>
                <div class="card-body p-4 bg-light text-wrap text-break" style="max-height: 400px; overflow-y: auto;">
                    <p class="text-muted small mb-2 fw-bold">Registro de Auditoría:</p>
                    <div class="font-monospace bg-white p-3 rounded border text-secondary" style="font-size: 0.9rem;">
                        <asp:Literal ID="litDetalleCompleto" runat="server"></asp:Literal>
                    </div>
                </div>
                <div class="card-footer bg-white d-flex justify-content-end p-3 border-0">
                    <asp:Button ID="btnCerrarModal" runat="server" Text="Cerrar" CssClass="btn btn-secondary px-4" OnClick="btnCerrarModal_Click" CausesValidation="false" />
                </div>
            </div>
        </asp:Panel>
    </form>
</body>
</html>
