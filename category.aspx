<%@ Page Title="" Language="C#" MasterPageFile="~/Dashboard.Master" AutoEventWireup="true" CodeBehind="category.aspx.cs" Inherits="SarinasHandicraft.category1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="content">
        <div class="row">
            <div class="col-md-12">
                <div class="card">
                    <div class="card-header row">
                        <div class="col-md-6">
                            <h4 class="card-title">Category List</h4>
                        </div>
                        <div class="col-md-6 text-right">
                            <span class="btn btn-md btn-primary" data-toggle="modal" data-target="#categoryAddModal">Add Category</span>
                        </div>
                    </div>
                    <div class="card-body">
                        <div class="table-responsive">
                            <asp:Literal ID="Message" runat="server" Text=""></asp:Literal>
                            <asp:GridView ID="CategoryGridView" runat="server" class="table table-striped table-bordered" AutoGenerateColumns="False" CellPadding="4" ForeColor="#51cbce" GridLines="None">
                                <Columns>
                                    <asp:BoundField DataField="id" HeaderText="ID" ReadOnly="True" SortExpression="id" />
                                    <asp:BoundField DataField="name" HeaderText="Name" SortExpression="name" />
                                    <asp:BoundField DataField="status" HeaderText="Status" SortExpression="status" />
                                    <asp:TemplateField HeaderText="Action">
                                        <ItemTemplate>
                                            <asp:LinkButton CssClass="btn btn-sm btn-primary mr-1" Text="Edit" runat="server"
                                                data-toggle="modal" data-target="#categoryUpdateModal"
                                                data-id='<%# Eval("Id") %>'
                                                data-name='<%# Eval("Name") %>'
                                                data-status='<%# Eval("Status") %>'>
                                            </asp:LinkButton>

                                            <asp:LinkButton CssClass="btn btn-sm btn-danger" Text="Delete" runat="server"
                                                data-toggle="modal" data-target="#categoryDeleteModal"
                                                data-id='<%# Eval("Id") %>'
                                                data-name='<%# Eval("Name") %>'>
                                            </asp:LinkButton>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                                <HeaderStyle BackColor="#f8f9fa" Font-Bold="True" ForeColor="#51cbce" />
                                <RowStyle BackColor="White" ForeColor="#333333" />
                                <AlternatingRowStyle BackColor="#f1f1f1" />
                            </asp:GridView>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Add Category Modal -->
    <div class="modal fade" id="categoryAddModal" tabindex="-1" role="dialog" aria-hidden="true">
      <div class="modal-dialog modal-dialog-centered" role="document">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title">Add Category</h5>
            <button type="button" class="close" data-dismiss="modal">&times;</button>
          </div>
          <div class="modal-body">
            <div class="form-group row">
                <label class="col-sm-4 col-form-label">Name</label>
                <div class="col-sm-8">
                    <asp:TextBox ID="addName" runat="server" CssClass="form-control required"></asp:TextBox>
                </div>
            </div>
            <div class="form-group row">
                <label class="col-sm-4 col-form-label">Status</label>
                <div class="col-sm-8">
                    <asp:DropDownList ID="addStatus" runat="server" CssClass="form-control">
                        <asp:ListItem Text="Active" Value="ACTIVE" />
                        <asp:ListItem Text="Inactive" Value="INACTIVE" />
                        <asp:ListItem Text="Delete" Value="DELETE" />
                    </asp:DropDownList>
                </div>
            </div>
          </div>
          <div class="modal-footer">
            <asp:Button ID="SaveCategory" runat="server" CssClass="btn btn-primary" Text="Add" OnClick="Save_Category"/>
            <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
          </div>
        </div>
      </div>
    </div>

    <!-- Update Category Modal -->
    <div class="modal fade" id="categoryUpdateModal" tabindex="-1" role="dialog" aria-hidden="true">
      <div class="modal-dialog modal-dialog-centered" role="document">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title">Update Category</h5>
            <button type="button" class="close" data-dismiss="modal">&times;</button>
          </div>
          <div class="modal-body">
            <div class="form-group row">
                <label class="col-sm-4 col-form-label">Name</label>
                <div class="col-sm-8">
                    <asp:TextBox ID="editName" runat="server" CssClass="form-control required"></asp:TextBox>
                    <asp:HiddenField ID="hiddenCategoryId" runat="server"/>
                </div>
            </div>
            <div class="form-group row">
                <label class="col-sm-4 col-form-label">Status</label>
                <div class="col-sm-8">
                    <asp:DropDownList ID="editStatus" runat="server" CssClass="form-control">
                        <asp:ListItem Text="Active" Value="ACTIVE" />
                        <asp:ListItem Text="Inactive" Value="INACTIVE" />
                        <asp:ListItem Text="Delete" Value="DELETE" />
                    </asp:DropDownList>
                </div>
            </div>
          </div>
          <div class="modal-footer">
            <asp:Button ID="UpdateCategory" runat="server" CssClass="btn btn-primary" Text="Update" OnClick="Update_Category"/>
            <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
          </div>
        </div>
      </div>
    </div>

    <!-- Delete Category Modal -->
    <div class="modal fade" id="categoryDeleteModal" tabindex="-1" role="dialog" aria-hidden="true">
      <div class="modal-dialog modal-dialog-centered" role="document">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title">Delete Category</h5>
            <button type="button" class="close" data-dismiss="modal">&times;</button>
          </div>
          <div class="modal-body">
            <asp:HiddenField ID="deleteCategoryId" runat="server"/>
            Are you sure you want to delete category "<span class="font-weight-bold deleteName"></span>"?
          </div>
          <div class="modal-footer">
            <asp:Button ID="DeleteCategory" runat="server" CssClass="btn btn-danger" Text="Delete" OnClick="Delete_Category"/>
            <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
          </div>
        </div>
      </div>
    </div>

    <!-- jQuery and Script -->
    <script src="/Assets/js/jquery-3.4.1.min.js"></script>
    <script>
        $(function () {
            // Update Modal
            $('#categoryUpdateModal').on('show.bs.modal', function (e) {
                var button = $(e.relatedTarget);
                $('#<%= editName.ClientID %>').val(button.data('name'));
                $('#<%= hiddenCategoryId.ClientID %>').val(button.data('id'));
                $('#<%= editStatus.ClientID %>').val(button.data('status'));
            });

            // Delete Modal
            $('#categoryDeleteModal').on('show.bs.modal', function (e) {
                var button = $(e.relatedTarget);
                $('#<%= deleteCategoryId.ClientID %>').val(button.data('id'));
                $('.deleteName').text(button.data('name'));
            });
        });
    </script>
</asp:Content>
