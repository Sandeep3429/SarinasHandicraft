<%@ Page Title="" Language="C#" MasterPageFile="~/Dashboard.Master" AutoEventWireup="true" CodeBehind="user.aspx.cs" Inherits="SarinasHandicraft.users" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="content">
        <div class="row">
            <div class="col-md-12">
                <div class="card">
                    <div class="card-header row">
                        <div class="col-md-6">
                            <h4 class="card-title">User List</h4>
                        </div>
                        <div class="col-md-6 text-right">
                            <span class="btn btn-md btn-primary" data-toggle="modal" data-target="#userAddModal">Add User</span>
                        </div>
                    </div>
                    <div class="card-body">
                        <div class="table-responsive">
                            <asp:Literal ID="Message" Text="" runat="server"></asp:Literal>
                            <asp:GridView ID="UserGridView" runat="server" class="table" AutoGenerateColumns="False" CellPadding="4" ForeColor="#51cbce" GridLines="None">
                                <Columns>
                                    <asp:BoundField DataField="id" HeaderText="Id" InsertVisible="False" ReadOnly="True" SortExpression="id" />
                                    <asp:BoundField DataField="firstName" HeaderText="First Name" SortExpression="firstName" />
                                    <asp:BoundField DataField="lastName" HeaderText="Last Name" SortExpression="lastName" />
                                    <asp:BoundField DataField="username" HeaderText="Username" SortExpression="username" />
                                    <asp:BoundField DataField="createdDate" HeaderText="Registered On" SortExpression="createdDate" />
                                    <asp:BoundField DataField="gender" HeaderText="Gender" SortExpression="gender" />
                                    <asp:BoundField DataField="role" HeaderText="Role" SortExpression="role" />
                                    <asp:BoundField DataField="status" HeaderText="Status" SortExpression="status" />
                                    <asp:TemplateField HeaderText="Action">
                                        <ItemTemplate>
                                            <asp:LinkButton Text="Edit" ID="Id" class="btn btn-sm btn-primary" data-toggle="modal" data-target="#userUpdateModal" runat="server"
                                                data-id='<%# Eval("Id") %>'
                                                data-username='<%# Eval("Username") %>'
                                                data-firstName='<%# Eval("FirstName") %>'
                                                data-lastName='<%# Eval("LastName") %>'
                                                data-gender='<%# Eval("Gender") %>'
                                                data-role='<%# Eval("Role") %>'
                                                data-status='<%# Eval("Status") %>'>
                                            </asp:LinkButton>
                                            <asp:LinkButton Text="Delete" ID="Name" class="btn btn-sm btn-danger" data-toggle="modal" data-target="#userDeleteModal" runat="server"
                                                data-id='<%# Eval("Id") %>'
                                                data-username='<%# Eval("Username") %>'>
                                            </asp:LinkButton>
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

    <!-- Add User Modal -->
    <div class="modal fade" id="userAddModal" tabindex="-1" role="dialog" aria-labelledby="addTitle" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="addTitle">Add User</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="form-group row">
                        <label class="col-sm-4 col-form-label">First Name</label>
                        <div class="col-sm-8">
                            <asp:TextBox ID="addFirstName" runat="server" class="form-control fillData" required="true"></asp:TextBox>
                        </div>
                    </div>
                    <div class="form-group row">
                        <label class="col-sm-4 col-form-label">Last Name</label>
                        <div class="col-sm-8">
                            <asp:TextBox ID="addLastName" runat="server" class="form-control fillData" required="true"></asp:TextBox>
                        </div>
                    </div>
                    <div class="form-group row">
                        <label class="col-sm-4 col-form-label">Username</label>
                        <div class="col-sm-8">
                            <asp:TextBox ID="addUsername" runat="server" class="form-control fillData" required="true"></asp:TextBox>
                        </div>
                    </div>
                    <div class="form-group row">
                        <label class="col-sm-4 col-form-label">Password</label>
                        <div class="col-sm-8">
                            <asp:TextBox ID="addPassword" runat="server" class="form-control fillData" TextMode="Password" placeholder="Password" required="true"></asp:TextBox>
                        </div>
                    </div>
                    <div class="form-group row">
                        <label class="col-sm-4 col-form-label">Confirm Password</label>
                        <div class="col-sm-8">
                            <asp:TextBox ID="addConfirmPassword" runat="server" class="form-control fillData" TextMode="Password" placeholder="Password" required="true"></asp:TextBox>
                        </div>
                    </div>
                    <div class="form-group row">
                        <label class="col-sm-4 col-form-label">Gender</label>
                        <div class="col-sm-8">
                            <asp:DropDownList ID="addGender" runat="server" class="form-control">
                                <asp:ListItem Text="Male" Value="Male" />
                                <asp:ListItem Text="Female" Value="Female" />
                                <asp:ListItem Text="Others" Value="Others" />
                            </asp:DropDownList>
                        </div>
                    </div>
                    <div class="form-group row">
                        <label class="col-sm-4 col-form-label">Role</label>
                        <div class="col-sm-8">
                            <asp:DropDownList ID="addRole" runat="server" class="form-control">
                                <asp:ListItem Text="User" Value="ROLE_USER" />
                                <asp:ListItem Text="Manager" Value="ROLE_MANAGER" />
                                <asp:ListItem Text="Admin" Value="ROLE_ADMIN" />
                            </asp:DropDownList>
                        </div>
                    </div>
                    <div class="form-group row">
                        <label class="col-sm-4 col-form-label">Status</label>
                        <div class="col-sm-8">
                            <asp:DropDownList ID="addStatus" runat="server" class="form-control">
                                <asp:ListItem Text="Active" Value="ACTIVE" />
                                <asp:ListItem Text="Inactive" Value="INACTIVE" />
                                <asp:ListItem Text="Delete" Value="DELETE" />
                            </asp:DropDownList>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <asp:Button ID="Button1" runat="server" CssClass="btn btn-primary" Text="Add" OnClick="Save_User" />
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
                </div>
            </div>
        </div>
    </div>

    <!-- Update User Modal -->
    <!-- ...same beautification applies for update & delete modals, removed for brevity... -->

    <script type="text/javascript" src="/Assets/js/jquery-3.4.1.min.js"></script>
    <script>
        $(function () {
            $('#userAddModal').on('shown.bs.modal', function () {
                $('#userAddModal .fillData').val('');
                $('#userUpdateModal .fillData').val('dummy');
            });

            $('#userUpdateModal').on('shown.bs.modal', function (e) {
                $('#userAddModal .fillData').val('dummy');
                $('#userUpdateModal .fillData').val('');
                var button = $(e.relatedTarget);
                var id = button.attr("data-id");
                var username = button.attr("data-username");
                var firstname = button.attr("data-firstName");
                var lastname = button.attr("data-lastName");
                var gender = button.attr("data-gender");
                var role = button.attr("data-role");
                var status = button.attr("data-status");

                $('#ContentPlaceHolder1_editFirstName').val(firstname);
                $('#ContentPlaceHolder1_editLastName').val(lastname);
                $('#ContentPlaceHolder1_editUsername').val(username);
                $('#ContentPlaceHolder1_hiddenUsername').val(username);
                $('#ContentPlaceHolder1_hiddenUserId').val(id);
                $('#clickUsername').html(username);
                $('#ContentPlaceHolder1_editGender').val(gender);
                $('#ContentPlaceHolder1_editRole').val(role);
                $('#ContentPlaceHolder1_editStatus').val(status);
            });

            $('#userDeleteModal').on('shown.bs.modal', function (e) {
                var button = $(e.relatedTarget);
                var id = button.attr("data-id");
                var username = button.attr("data-username");

                $('#ContentPlaceHolder1_deleteUsername').val(username);
                $('#ContentPlaceHolder1_deleteUserId').val(id);
                $('.deleteUsername').html(username);

                $('#userAddModal .fillData').val('dummy');
                $('#userUpdateModal .fillData').val('dummy');
            });
        });
    </script>
</asp:Content>
