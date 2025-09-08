<%@ Page Title="Order List" Language="C#" MasterPageFile="~/Dashboard.Master" AutoEventWireup="true" CodeBehind="orderList.aspx.cs" Inherits="SarinasHandicraft.dashboard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="/Assets/css/orderlist-style.css" />
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<div class="dashboard-container">
    <br />
    <br />
    <br />
    <div class="card shadow-sm">
        <div class="card-header d-flex justify-content-between align-items-center">
            <h4 class="card-title">Order List</h4>
        </div>

        <div class="card-body">
            <asp:Literal ID="Message" Text="" runat="server"></asp:Literal>
            <div class="table-responsive">
                <asp:GridView ID="OrderGridView" runat="server" class="table table-hover table-striped"
                    AutoGenerateColumns="False" CellPadding="10" ForeColor="#333" GridLines="None" OnRowDataBound="OnRowDataBound">
                    <Columns>
                        <asp:BoundField DataField="id" HeaderText="ID" ReadOnly="True" SortExpression="id" />
                        <asp:BoundField DataField="Customer_Name" HeaderText="Customer Name" SortExpression="Customer_Name" />
                        <asp:BoundField DataField="Created_Date" HeaderText="Ordered Date" SortExpression="Created_Date" />
                        <asp:BoundField DataField="Total" HeaderText="Total" SortExpression="Total" />
                        <asp:BoundField DataField="Last_Updated_Date" HeaderText="Last Update" SortExpression="Last_Updated_Date" />
                        <asp:BoundField DataField="status" HeaderText="Status" SortExpression="status" />
                        <asp:BoundField DataField="Address" HeaderText="Address" SortExpression="Address" />
                        <asp:BoundField DataField="PaymentType" HeaderText="Payment Type" SortExpression="PaymentType" />
                        <asp:TemplateField HeaderText="Action">
                            <ItemTemplate>
                                <asp:LinkButton Text="View" ID="Id" class="btn btn-sm btn-primary me-1"
                                    data-bs-toggle="modal" data-bs-target="#viewOrderModal" runat="server"
                                    data-id='<%# DataBinder.Eval(Container.DataItem, "Id") %>'
                                    data-name='<%# DataBinder.Eval(Container.DataItem, "Customer_Name") %>'
                                    data-total='<%# DataBinder.Eval(Container.DataItem, "Total") %>'
                                    data-createdDate='<%# DataBinder.Eval(Container.DataItem, "Created_Date") %>'
                                    data-status='<%# DataBinder.Eval(Container.DataItem, "Status") %>'
                                    data-details='<%# DataBinder.Eval(Container.DataItem, "Order_Details") %>'></asp:LinkButton>

                                <asp:LinkButton Text="Update" ID="Name" class="btn btn-sm btn-warning"
                                    data-bs-toggle="modal" data-bs-target="#orderUpdateModal" runat="server"
                                    data-id='<%# DataBinder.Eval(Container.DataItem, "Id") %>'
                                    data-status='<%# DataBinder.Eval(Container.DataItem, "Status") %>'
                                    Visible='<%# (Eval("Status").ToString() == "DELIVERED" || Eval("Status").ToString() == "CANCELLED")? false: true %>'></asp:LinkButton>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </div>
        </div>
    </div>

    <!-- View Order Modal -->
    <div class="modal fade" id="viewOrderModal" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered modal-lg">
            <div class="modal-content shadow-sm">
                <div class="modal-header">
                    <h5 class="modal-title">View Order</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <div class="order-details-grid mb-3">
                        <div><strong>Order ID:</strong> <asp:Label ID="Order_Id" runat="server" CssClass="fw-bold"></asp:Label></div>
                        <div><strong>Customer Name:</strong> <asp:Label ID="Customer_Name" runat="server" CssClass="fw-bold"></asp:Label></div>
                        <div><strong>Created Date:</strong> <asp:Label ID="Created_Date" runat="server" CssClass="fw-bold"></asp:Label></div>
                        <div><strong>Total:</strong> <asp:Label ID="Order_Total" runat="server" CssClass="fw-bold"></asp:Label></div>
                        <div><strong>Status:</strong> <asp:Label ID="Order_Status" runat="server" CssClass="fw-bold"></asp:Label></div>
                    </div>

                    <hr />

                    <h6>Order Items</h6>
                    <div class="table-responsive">
                        <table id="orderDetails" class="table table-bordered table-hover w-100">
                            <thead class="table-light">
                                <tr>
                                    <th>ID</th>
                                    <th>Item</th>
                                    <th>Image</th>
                                    <th>Quantity</th>
                                    <th>Unit Price</th>
                                    <th>Total Price</th>
                                </tr>
                            </thead>
                            <tbody></tbody>
                        </table>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                </div>
            </div>
        </div>
    </div>

    <!-- Update Order Modal -->
    <div class="modal fade" id="orderUpdateModal" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content shadow-sm">
                <div class="modal-header">
                    <h5 class="modal-title">Update Order Status</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <asp:HiddenField ID="hiddenOrderId" runat="server" />
                    <div class="mb-3">
                        <label>Order ID</label>
                        <asp:Label ID="EditOrderId" runat="server" class="fw-bold"></asp:Label>
                    </div>
                    <div class="mb-3">
                        <label>Status</label>
                        <asp:DropDownList ID="editOrderStatus" runat="server" class="form-select">
                            <asp:ListItem Text="Pending" Value="PENDING"></asp:ListItem>
                            <asp:ListItem Text="Processing" Value="PROCESSING"></asp:ListItem>
                            <asp:ListItem Text="Delivered" Value="DELIVERED"></asp:ListItem>
                            <asp:ListItem Text="Cancelled" Value="CANCELLED"></asp:ListItem>
                        </asp:DropDownList>
                    </div>
                </div>
                <div class="modal-footer">
                    <asp:Button ID="UpdateOrder" runat="server" CssClass="btn btn-primary" Text="Update" OnClick="Update_Order" />
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                </div>
            </div>
        </div>
    </div>

</div>

<script type="text/javascript" src="/Assets/js/jquery-3.4.1.min.js"></script>
<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

<script>
$(function () {
    // Populate View Modal
    $('#viewOrderModal').on('shown.bs.modal', function (e) {
        var button = $(e.relatedTarget);
        var details = JSON.parse(button.attr("data-details"));

        $('#<%= Order_Id.ClientID %>').html(button.attr("data-id"));
        $('#<%= Customer_Name.ClientID %>').html(button.attr("data-name"));
        $('#<%= Order_Total.ClientID %>').html(button.attr("data-total"));
        $('#<%= Created_Date.ClientID %>').html(button.attr("data-createdDate"));
        $('#<%= Order_Status.ClientID %>').html(button.attr("data-status"));

        var tbody = '';
        $.each(details, function (i, item) {
            tbody += '<tr>';
            tbody += '<td>' + item.Id + '</td>';
            tbody += '<td>' + item.Item_Name + '</td>';
            tbody += '<td><img src="' + item.Item_Image.replace("~","") + '" width="80" /></td>';
            tbody += '<td>' + item.Quantity + '</td>';
            tbody += '<td>' + item.Unit_Price + '</td>';
            tbody += '<td>' + item.Total_Price + '</td>';
            tbody += '</tr>';
        });
        $('#orderDetails tbody').html(tbody);
    });

    // Populate Update Modal
    $('#orderUpdateModal').on('shown.bs.modal', function (e) {
        var button = $(e.relatedTarget);
        var id = button.attr("data-id");
        var status = button.attr("data-status");

        $('#<%= hiddenOrderId.ClientID %>').val(id);
        $('#<%= EditOrderId.ClientID %>').html(id);
        $('#<%= editOrderStatus.ClientID %>').val(status);
    });
});
</script>
</asp:Content>
