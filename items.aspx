<%@ Page Title="" Language="C#" MasterPageFile="~/Dashboard.Master" AutoEventWireup="true" CodeBehind="items.aspx.cs" Inherits="SarinasHandicraft.items" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="/Assets/css/items.css" rel="stylesheet" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="content">
        <div class="row mb-3">
            <div class="col-md-6">
                <h4 class="text-primary">Item List</h4>
            </div>
            <div class="col-md-6 text-right">
                <span class="btn btn-primary" data-toggle="modal" data-target="#itemAddModal">
                    <i class="fa fa-plus mr-1"></i> Add Item
                </span>
            </div>
        </div>

        <asp:Literal ID="Message" runat="server"></asp:Literal>

        <div class="table-responsive shadow-sm rounded">
            <asp:GridView ID="ItemGridView" runat="server" CssClass="table table-striped table-hover"
                AutoGenerateColumns="False" CellPadding="6" GridLines="None">
                <Columns>
                    <asp:BoundField DataField="id" HeaderText="ID" ReadOnly="True" SortExpression="id" />
                    <asp:BoundField DataField="name" HeaderText="Name" SortExpression="name" />
                    <asp:ImageField DataImageUrlField="image" HeaderText="Image" ItemStyle-Width="80" ControlStyle-Width="80" />
                    <asp:BoundField DataField="description" HeaderText="Description" SortExpression="description" />
                    <asp:BoundField DataField="category_name" HeaderText="Category" SortExpression="category_name" />
                    <asp:BoundField DataField="code" HeaderText="Code" SortExpression="code" />
                    <asp:BoundField DataField="price" HeaderText="Price" SortExpression="price" DataFormatString="{0:C}" />
                    <asp:BoundField DataField="quantity" HeaderText="Quantity" SortExpression="quantity" />
                    <asp:BoundField DataField="status" HeaderText="Status" SortExpression="status" />

                    <asp:TemplateField HeaderText="Action">
                        <ItemTemplate>
                            <div class="btn-group">
                                <a href="javascript:void(0);" class="btn btn-sm btn-primary editItemBtn"
                                    data-id='<%# Eval("Id") %>'
                                    data-name='<%# Eval("Name") %>'
                                    data-description='<%# Eval("Description") %>'
                                    data-code='<%# Eval("Code") %>'
                                    data-price='<%# Eval("Price") %>'
                                    data-quantity='<%# Eval("Quantity") %>'
                                    data-image='<%# Eval("Image") %>'
                                    data-categoryId='<%# Eval("Category_Id") %>'
                                    data-status='<%# Eval("Status") %>'
                                    data-toggle="modal"
                                    data-target="#itemUpdateModal">Edit</a>

                                <a href="javascript:void(0);" class="btn btn-sm btn-danger deleteItemBtn"
                                    data-id='<%# Eval("Id") %>'
                                    data-name='<%# Eval("Name") %>'
                                    data-toggle="modal"
                                    data-target="#itemDeleteModal">Delete</a>
                            </div>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </div>
    </div>

    <!-- Add Item Modal -->
    <div class="modal fade" id="itemAddModal" tabindex="-1" role="dialog" aria-hidden="true">
      <div class="modal-dialog modal-dialog-centered modal-lg">
        <div class="modal-content shadow-sm rounded">
          <div class="modal-header bg-primary text-white">
            <h5 class="modal-title">Add New Item</h5>
            <button type="button" class="close text-white" data-dismiss="modal">&times;</button>
          </div>
          <div class="modal-body">
              <div class="form-row mb-2">
                  <div class="col-md-6">
                      <label>Item Name</label>
                      <asp:TextBox ID="addItemName" runat="server" CssClass="form-control" />
                  </div>
                  <div class="col-md-6">
                      <label>Image</label>
                      <asp:FileUpload ID="AddImageUpload" runat="server" CssClass="form-control" />
                  </div>
              </div>

              <div class="form-row mb-2">
                  <div class="col-md-6">
                      <label>Code</label>
                      <asp:TextBox ID="addCode" runat="server" CssClass="form-control" />
                  </div>
                  <div class="col-md-6">
                      <label>Category</label>
                      <asp:DropDownList ID="addCategoryId" runat="server" CssClass="form-control" />
                  </div>
              </div>

              <div class="form-row mb-2">
                  <div class="col-md-4">
                      <label>Price</label>
                      <asp:TextBox ID="addPrice" runat="server" CssClass="form-control" type="number" />
                  </div>
                  <div class="col-md-4">
                      <label>Quantity</label>
                      <asp:TextBox ID="addQuantity" runat="server" CssClass="form-control" type="number" />
                  </div>
                  <div class="col-md-4">
                      <label>Status</label>
                      <asp:DropDownList ID="addStatus" runat="server" CssClass="form-control">
                          <asp:ListItem Text="Active" Value="ACTIVE" />
                          <asp:ListItem Text="Inactive" Value="INACTIVE" />
                      </asp:DropDownList>
                  </div>
              </div>

              <div class="form-group">
                  <label>Description</label>
                  <asp:TextBox ID="addDescription" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="3" />
              </div>
          </div>
          <div class="modal-footer">
            <asp:Button ID="SaveItem" runat="server" CssClass="btn btn-primary" Text="Add Item" OnClick="Save_Item" />
            <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
          </div>
        </div>
      </div>
    </div>

    <!-- Update Item Modal -->
    <div class="modal fade" id="itemUpdateModal" tabindex="-1" role="dialog" aria-hidden="true">
      <div class="modal-dialog modal-dialog-centered modal-lg">
        <div class="modal-content shadow-sm rounded">
          <div class="modal-header bg-info text-white">
            <h5 class="modal-title">Update Item</h5>
            <button type="button" class="close text-white" data-dismiss="modal">&times;</button>
          </div>
          <div class="modal-body">
              <asp:HiddenField ID="hiddenItemId" runat="server" />

              <div class="form-row mb-2">
                  <div class="col-md-6">
                      <label>Name</label>
                      <asp:TextBox ID="editItemName" runat="server" CssClass="form-control" />
                  </div>
                  <div class="col-md-6">
                      <label>Image</label>
                      <asp:FileUpload ID="editImageUpload" runat="server" CssClass="form-control" />
                      <asp:Image ID="ShowImage" runat="server" Height="80" Width="80" CssClass="mt-2" />
                  </div>
              </div>

              <div class="form-row mb-2">
                  <div class="col-md-4">
                      <label>Code</label>
                      <asp:TextBox ID="editCode" runat="server" CssClass="form-control" />
                  </div>
                  <div class="col-md-4">
                      <label>Price</label>
                      <asp:TextBox ID="editPrice" runat="server" CssClass="form-control" type="number" />
                  </div>
                  <div class="col-md-4">
                      <label>Quantity</label>
                      <asp:TextBox ID="editQuantity" runat="server" CssClass="form-control" type="number" />
                  </div>
              </div>

              <div class="form-row mb-2">
                  <div class="col-md-6">
                      <label>Category</label>
                      <asp:DropDownList ID="editCategoryId" runat="server" CssClass="form-control" />
                  </div>
                  <div class="col-md-6">
                      <label>Status</label>
                      <asp:DropDownList ID="editStatus" runat="server" CssClass="form-control">
                          <asp:ListItem Text="Active" Value="ACTIVE" />
                          <asp:ListItem Text="Inactive" Value="INACTIVE" />
                          <asp:ListItem Text="Delete" Value="DELETE" />
                      </asp:DropDownList>
                  </div>
              </div>

              <div class="form-group">
                  <label>Description</label>
                  <asp:TextBox ID="editDescription" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="3" />
              </div>
          </div>
          <div class="modal-footer">
            <asp:Button ID="UpdateItem" runat="server" CssClass="btn btn-info" Text="Update" OnClick="Update_Item" />
            <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
          </div>
        </div>
      </div>
    </div>

    <!-- Delete Item Modal -->
    <div class="modal fade" id="itemDeleteModal" tabindex="-1" role="dialog" aria-hidden="true">
      <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content shadow-sm rounded">
          <div class="modal-header bg-danger text-white">
            <h5 class="modal-title">Delete Item</h5>
            <button type="button" class="close text-white" data-dismiss="modal">&times;</button>
          </div>
          <div class="modal-body">
              <asp:HiddenField ID="deleteItemId" runat="server" />
              Are you sure you want to delete item "<span class="font-weight-bold deleteName"></span>"?
          </div>
          <div class="modal-footer">
            <asp:Button ID="DeleteItem" runat="server" CssClass="btn btn-danger" Text="Delete" OnClick="Delete_Item" />
            <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
          </div>
        </div>
      </div>
    </div>

<script type="text/javascript" src="/Assets/js/jquery-3.4.1.min.js"></script>
<script>
    $(document).ready(function () {

        // Edit Item Modal
        $('.editItemBtn').click(function () {
            var button = $(this);
            $('#<%= hiddenItemId.ClientID %>').val(button.data('id'));
            $('#<%= editItemName.ClientID %>').val(button.data('name'));
            $('#<%= editDescription.ClientID %>').val(button.data('description'));
            $('#<%= editCode.ClientID %>').val(button.data('code'));
            $('#<%= editPrice.ClientID %>').val(button.data('price'));
            $('#<%= editQuantity.ClientID %>').val(button.data('quantity'));
            $('#<%= editCategoryId.ClientID %>').val(button.data('categoryid'));
            $('#<%= editStatus.ClientID %>').val(button.data('status'));
            $('#<%= ShowImage.ClientID %>').attr('src', button.data('image').replace("~", ""));
        });

        // Delete Item Modal
        $('.deleteItemBtn').click(function () {
            var button = $(this);
            $('#<%= deleteItemId.ClientID %>').val(button.data('id'));
            $('.deleteName').text(button.data('name'));
        });

    });
</script>

</asp:Content>
