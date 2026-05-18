<%@ Page Language="VB" AutoEventWireup="false" CodeBehind="Bitacora.aspx.vb" Inherits="FundamicroApp.Bitacora" %>
<!DOCTYPE html>
<html lang="es">
<head runat="server">
    <title>Bitácora de Acciones</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
</head>
<body class="bg-light">
    <form id="form1" runat="server">
        <nav class="navbar navbar-dark bg-dark mb-4 px-3">
            <span class="navbar-brand">Fundamicro - Auditoría del Sistema</span>
            <div>
                <a href="Default.aspx" class="btn btn-outline-light btn-sm me-2">Volver a Clientes</a>
                <asp:Button ID="btnSalir" runat="server" Text="Cerrar Sesión" CssClass="btn btn-danger btn-sm" OnClick="btnSalir_Click" CausesValidation="false" />
            </div>
        </nav>
        
        <div class="container bg-white p-4 shadow-sm rounded">
            <h5 class="mb-4 text-primary">Registro de Actividades (Bitácora)</h5>
            
            <div class="table-responsive">
                <asp:GridView ID="gvBitacora" runat="server" AutoGenerateColumns="False" CssClass="table table-bordered table-striped table-hover text-sm">
                    <Columns>
                        <asp:BoundField DataField="BitacoraID" HeaderText="Folio" />
                        <asp:BoundField DataField="Accion" HeaderText="Tipo de Acción">
                            <ItemStyle CssClass="fw-bold" />
                        </asp:BoundField>
                        <asp:BoundField DataField="ClienteID" HeaderText="ID Cliente" />
                        <asp:BoundField DataField="DetalleCambio" HeaderText="Detalles del Movimiento" />
                        <asp:BoundField DataField="Username" HeaderText="Usuario Responsable" />
                        <asp:BoundField DataField="FechaHora" HeaderText="Fecha y Hora" DataFormatString="{0:dd/MM/yyyy HH:mm:ss}" />
                    </Columns>
                </asp:GridView>
            </div>
        </div>
    </form>
</body>
</html>