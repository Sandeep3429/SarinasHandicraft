<%@ Page Title="" Language="C#" MasterPageFile="~/Home.Master" AutoEventWireup="true" CodeBehind="order.aspx.cs" Inherits="SarinasHandicraft.order" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server"><div class="content">
    <div class="row">
        <div class="col-md-12">
        <div class="card">
            <div class="card-header row">
                <div class="col-md-6">
                    <h4 class="card-title"> Order List</h4>
                    </div>
                <div class="col-md-6">
                    <div class="row pull-right">
                            
                    </div>
                </div>
            </div>
            <div class="card-body">
                <div class="table-responsive">
                    <asp:Literal ID="Message" Text="" runat="server"></asp:Literal>
                    <asp:GridView ID="OrderGridView" runat="server" class="table" AutoGenerateColumns="False" CellPadding="4" ForeColor="#51cbce" GridLines="None">
                            <Columns>
                                <asp:BoundField DataField="id" HeaderText="Id" InsertVisible="False" ReadOnly="True" SortExpression="id" />
                                <asp:BoundField DataField="Customer_Name" HeaderText="Name" SortExpression="Customer_Name" />
                                <asp:BoundField DataField="Created_Date" HeaderText="Ordered Date" SortExpression="Created_Date" />                                
                                <asp:BoundField DataField="Total" HeaderText="Total" SortExpression="Total" />
                                <asp:BoundField DataField="Last_Updated_Date" HeaderText="Order Update Date" SortExpression="Last_Updated_Date" />
                                <asp:BoundField DataField="status" HeaderText="Status" SortExpression="status" />
                                <asp:BoundField DataField="PaymentType" HeaderText="Payment Type" SortExpression="status" />
                                <asp:TemplateField HeaderText="Action">
                                    <ItemTemplate> 
                                        <asp:LinkButton Text='View' ID="Id" class="btn btn-sm btn-primary" data-toggle="modal" data-target="#viewOrderModal" runat="server"
                                            data-id='<%# DataBinder.Eval(Container.DataItem, "Id") %>' 
                                            data-name='<%# DataBinder.Eval(Container.DataItem, "Customer_Name") %>'
                                            data-total='<%# DataBinder.Eval(Container.DataItem, "Total") %>'
                                            data-createdDate='<%# DataBinder.Eval(Container.DataItem, "Created_Date") %>'
                                            data-status='<%# DataBinder.Eval(Container.DataItem, "Status") %>'
                                            data-details='<%# DataBinder.Eval(Container.DataItem, "Order_Details") %>'
                                            /> 
                                    </ItemTemplate> 
                                </asp:TemplateField>
                            </Columns>
                            <AlternatingRowStyle BackColor="White" />
                            <FooterStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
                            <HeaderStyle BackColor="#FFFFFF" Font-Bold="True" ForeColor="#51cbce" />
                            <PagerStyle BackColor="#FFCC66" ForeColor="#333333" HorizontalAlign="Center" />
                            <RowStyle BackColor="White" ForeColor="#333333" />
                            <SelectedRowStyle BackColor="#FFCC66" Font-Bold="True" ForeColor="Navy" />
                            <SortedAscendingCellStyle BackColor="#FDF5AC" />
                            <SortedAscendingHeaderStyle BackColor="#4D0000" />
                            <SortedDescendingCellStyle BackColor="#FCF6C0" />
                            <SortedDescendingHeaderStyle BackColor="#820000" />
                        </asp:GridView>
                    </div>
                </div>
            </div>
            </div>
        </div>
    </div>

    <!-- View Order-->
    <div class="modal fade" id="viewOrderModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
      <div class="modal-dialog modal-dialog-centered" role="document">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title" id="addTitle">View Order</h5>
            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
              <span aria-hidden="true">&times;</span>
            </button>
          </div>
          <div class="modal-body">
              <div class="form-group row">
                <label class="col-sm-4 col-form-label">OrderId</label>
                <div class="col-sm-8">
                  <asp:Label ID="Order_Id" runat="server" CssClass="font-weight-bold"></asp:Label>
                </div>
              </div>

              <div class="form-group row">
                <label class="col-sm-4 col-form-label">Customer Name</label>
                <div class="col-sm-8">
                  <asp:Label ID="Customer_Name" runat="server" CssClass="font-weight-bold"></asp:Label>
                </div>
              </div>

              <div class="form-group row">
                <label class="col-sm-4 col-form-label">Created Date</label>
                <div class="col-sm-8">
                  <asp:Label ID="Created_Date" runat="server" CssClass="font-weight-bold"></asp:Label>
                </div>
              </div>

              <div class="form-group row">
                <label class="col-sm-4 col-form-label">Total</label>
                <div class="col-sm-8">
                  <asp:Label ID="Order_Total" runat="server" CssClass="font-weight-bold"></asp:Label>
                </div>
              </div>

              <div class="form-group row">
                <label class="col-sm-4 col-form-label">Status</label>
                <div class="col-sm-8">
                  <asp:Label ID="Order_Status" runat="server" CssClass="font-weight-bold"></asp:Label>
                </div>
              </div>

              <div class="form-group row">
                  <hr style="width: 100%"/>
                <label class="col-sm-12 col-form-label font-weight-bold">Order Items</label>
                  
                <div class="col-sm-12">
                  <div>
                      <table id="orderDetails" class="table" style="color:#51CBCE;border-collapse:collapse;" width="100%">
                          <thead>
                              <tr style="color:#51CBCE;background-color:White;font-weight:bold;">
                                  <th>Id</th>
                                  <th>Item</th>
                                  <th>Image</th>
                                  <th>Quantity</th>
                                  <th>Unit Price</th>
                                  <th>Total Price</th>
                              </tr>
                          </thead>
                          <tbody style="color:#333333;background-color:White;">

                          </tbody>
                      </table>
                  </div>
                </div>
              </div>

          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
          </div>
        </div>
      </div>
    </div>
    <!--View Order Modal close-->


    <script type="text/javascript" src="/Assets/js/jquery-3.4.1.min.js"></script>
    <script>
        $(function () {
            $('#viewOrderModal').on('shown.bs.modal', function (e) {
                $('.required').removeAttr('required');
                $('#categoryUpdateModal .required').attr('required', 'true');
                var button = $(e.relatedTarget);
                var id = button.attr("data-id");
                var name = button.attr("data-name");
                var total = button.attr("data-total");
                var createdDate = button.attr("data-createdDate");
                var status = button.attr("data-status");
                $('#ContentPlaceHolder1_Order_Id').html(id);
                $('#ContentPlaceHolder1_Customer_Name').html(name);
                $('#ContentPlaceHolder1_Order_Total').html(total);
                $('#ContentPlaceHolder1_Created_Date').html(createdDate);
                $('#ContentPlaceHolder1_Order_Status').html(status);

                var details = button.attr("data-details");
                details = JSON.parse(details);
                var detailData = "";
                $.each(details, function (index, detail) {

                    detailData += "<tr>";
                    detailData += "<td>" + detail.Id + "</td > ";
                    detailData += "<td>"+detail.Item_Name+"</td>";
                    detailData += "<td><img src='"+detail.Item_Image.replace("~","") +"' width='100px' width='100px'/></td>";
                    detailData += "<td>"+detail.Quantity+"</td>";
                    detailData += "<td>" + detail.Unit_Price + "</td>";
                    detailData += "<td>" + detail.Total_Price + "</td>";
                    detailData += "</tr > ";
                });
                $('#orderDetails tbody').html(detailData);

            });

            $('#orderUpdateModal').on('shown.bs.modal', function (e) {
                $('.required').removeAttr('required');
                var button = $(e.relatedTarget);
                var id = button.attr("data-id");
                var status = button.attr("data-status");
                $('#ContentPlaceHolder1_deleteName').val(name);
                $('#ContentPlaceHolder1_EditOrderId').html(id);
                $('#ContentPlaceHolder1_hiddenOrderId').val(id);
                $('#ContentPlaceHolder1_editOrderStatus').val(status);
                $('.deleteName').html(name);
            });
        });
    </script>
</asp:Content>