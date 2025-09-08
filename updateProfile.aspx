<%@ Page Title="" Language="C#" MasterPageFile="~/Home.Master" AutoEventWireup="true" CodeBehind="updateProfile.aspx.cs" Inherits="SarinasHandicraft.updateProfile" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="content">
       <div class="container">
    <div class="main-body">
          <div class="row gutters-sm">
            <div class="col-md-12">
              <div class="card mb-3">
                <div class="card-body">
                    <asp:Literal ID="Message" runat="server"></asp:Literal>
                  <div class="row mb-2">
                    <div class=" form-group col-sm-4">
                      <h6 class="mb-0">First Name</h6>
                    </div>                      
                    <asp:TextBox ID="FirstName" runat="server" CssClass="col-sm-5 form-control" required="true"/>
                  </div>

                  <div class="row mb-2">
                    <div class="col-sm-4">
                      <h6 class="mb-0">Last Name</h6>
                    </div>
                    <asp:TextBox ID="LastName" runat="server" CssClass="col-sm-5 form-control" required="true"/>
                  </div>

                  <div class="row mb-2">
                    <div class="col-sm-4">
                      <h6 class="mb-0">Profile Image</h6>
                    </div>
                      <div class-="col-sm-5">
                        <asp:FileUpload ID="ProfileImage" runat="server" class="form-control"/><br />
                        <asp:Image Id="ImageUrl" runat="server" Width="150" Height="150" />
                      </div>
                  </div>

                  <div class="row mb-2">
                    <div class="col-sm-4">
                      <h6 class="mb-0">Mobile</h6>
                    </div>
                    <asp:TextBox TextMode="Number" ID="Mobile" runat="server" CssClass="col-sm-5 form-control" />
                  </div>

                  <div class="row mb-2">
                    <div class="col-sm-4">
                      <h6 class="mb-0">Gender</h6>
                    </div>
                    <asp:RadioButtonList ID="Gender" runat="server" RepeatDirection="Horizontal">
                        <asp:ListItem Text ="Male" Value="Male" Selected="true" CssClass="ml-3"/>
                        <asp:ListItem Text ="Female" Value="Female" CssClass="ml-3"/> 
                        <asp:ListItem Text ="Others" Value="Others" CssClass="ml-3"/> 
                    </asp:RadioButtonList>
                  </div>
                  
                  <div class="row mb-2">
                    <div class="col-sm-4">
                      <h6 class="mb-0">Address</h6>
                    </div>
                   <asp:TextBox ID="Address" runat="server" CssClass="col-sm-5 form-control" />
                  </div>
                  
                  <div class="row">
                    <div class="col-sm-12">
                      <asp:Button class="btn btn-info" Text="Update Profile" OnClick="Update_Profile" Value="Update Profile" runat="server"/>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
    </div>
    </div>
    <script type="text/javascript" src="/Assets/js/jquery-3.4.1.min.js"></script>
</asp:Content>
