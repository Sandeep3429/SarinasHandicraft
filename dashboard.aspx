<%@ Page Title="Dashboard" Language="C#" UnobtrusiveValidationMode="None" MasterPageFile="~/Dashboard.Master" AutoEventWireup="true" CodeBehind="dashboard.aspx.cs" Inherits="SarinasHandicraft.product" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="/Assets/css/dashboard-style.css" />
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    
    <br />
     <br />
     <br />
    <div class="dashboard-container">

        <div class="cards-row">
            <div class="card">
                <div class="card-icon bg-success">
                    <i class="fas fa-users"></i>
                </div>
                <div class="card-content">
                    <h4>Total Customer</h4>
                    <span><asp:Label ID="TotalCustomer" runat="server"></asp:Label></span>
                </div>
                <div class="card-footer">
                    <i class="fas fa-calendar"></i> Till Now
                </div>
            </div>

            <div class="card">
                <div class="card-icon bg-primary">
                    <i class="fas fa-user-check"></i>
                </div>
                <div class="card-content">
                    <h4>Total Active User</h4>
                    <span><asp:Label ID="ActiveCustomer" runat="server"></asp:Label></span>
                </div>
                <div class="card-footer">
                    <i class="fas fa-calendar"></i> Till Now
                </div>
            </div>

            <div class="card">
                <div class="card-icon bg-warning">
                    <i class="fas fa-user-clock"></i>
                </div>
                <div class="card-content">
                    <h4>Total Inactive Users</h4>
                    <span><asp:Label ID="InactiveCustomer" runat="server"></asp:Label></span>
                </div>
                <div class="card-footer">
                    <i class="fas fa-clock"></i> Till Now
                </div>
            </div>

            <div class="card">
                <div class="card-icon bg-danger">
                    <i class="fas fa-user-slash"></i>
                </div>
                <div class="card-content">
                    <h4>Total Deleted User</h4>
                    <span><asp:Label ID="DeleteUser" runat="server"></asp:Label></span>
                </div>
                <div class="card-footer">
                    <i class="fas fa-clock"></i> Till Now
                </div>
            </div>
        </div>

        <div class="cards-row">
            <div class="card">
                <div class="card-icon bg-success">
                    <span>रु</span>
                </div>
                <div class="card-content">
                    <h4>Total Order Amount</h4>
                    <span>रु <asp:Label ID="TotalOrderAmount" runat="server"></asp:Label></span>
                </div>
                <div class="card-footer">
                    <i class="fas fa-calendar"></i> Till Now
                </div>
            </div>

            <div class="card">
                <div class="card-icon bg-info">
                    <i class="fas fa-shopping-bag"></i>
                </div>
                <div class="card-content">
                    <h4>Order Count</h4>
                    <span><asp:Label ID="OrderCount" runat="server"></asp:Label></span>
                </div>
                <div class="card-footer">
                    <i class="fas fa-calendar"></i> Till Now
                </div>
            </div>

            <div class="card">
                <div class="card-icon bg-success">
                    <i class="fas fa-truck"></i>
                </div>
                <div class="card-content">
                    <h4>Delivered Orders</h4>
                    <span><asp:Label ID="DelieveredOrder" runat="server"></asp:Label></span>
                </div>
                <div class="card-footer">
                    <i class="fas fa-clock"></i> Till Now
                </div>
            </div>

            <div class="card">
                <div class="card-icon bg-danger">
                    <i class="fas fa-ban"></i>
                </div>
                <div class="card-content">
                    <h4>Cancelled Orders</h4>
                    <span><asp:Label ID="CancelledOrder" runat="server"></asp:Label></span>
                </div>
                <div class="card-footer">
                    <i class="fas fa-clock"></i> Till Now
                </div>
            </div>
        </div>

    </div>

    <script type="text/javascript" src="/Assets/js/jquery-3.4.1.min.js"></script>
</asp:Content>
