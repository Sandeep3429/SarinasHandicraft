<%@ Page Title="" Language="C#" UnobtrusiveValidationMode="None" MasterPageFile="~/Default.Master" AutoEventWireup="true" CodeBehind="login.aspx.cs" Inherits="SarinasHandicraft._default" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&display=swap" rel="stylesheet" />
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(to right, #fdfbfb, #ebedee);
        }
        .login-wrapper {
            display: flex;
            min-height: 100vh;
        }
        .login-image {
            flex: 1;
            background: url('/Assets/images/login.jpg') center center no-repeat;
        }
        .login-form {
            flex: 1;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 40px;
        }
        .login-card {
            width: 100%;
            max-width: 420px;
            background: #fff;
            padding: 40px 30px;
            border-radius: 16px;
            box-shadow: 0 6px 20px rgba(0,0,0,0.1);
        }
        .brand-wrapper {
            text-align: center;
            margin-bottom: 20px;
        }
        .brand-wrapper img {
            width: 60px;
            margin-bottom: 8px;
        }
        .login-card h3 {
            font-weight: 600;
            text-align: center;
            margin-bottom: 20px;
            color: #333;
        }
        .form-control {
            border-radius: 12px;
            padding: 12px;
            border: 1px solid #ddd;
            margin-bottom: 16px;
        }
        .login-btn {
            background: #ff7043;
            color: #fff;
            border: none;
            border-radius: 12px;
            padding: 12px;
            font-weight: 600;
            transition: 0.3s;
        }
        .login-btn:hover {
            background: #e64a19;
        }
        .login-card-footer-text {
            text-align: center;
            margin-top: 20px;
            font-size: 0.9rem;
        }
        .login-card-footer-text a {
            color: #ff7043;
            font-weight: 600;
            text-decoration: none;
        }
        .login-card-footer-text a:hover {
            text-decoration: underline;
        }

        /* Mobile */
        @media(max-width: 768px) {
            .login-wrapper {
                flex-direction: column;
            }
            .login-image {
                display: none;
            }
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="login-wrapper">
        <!-- Left side (image) -->
        <div class="login-image"></div>

        <!-- Right side (form) -->
        <div class="login-form">
            <div class="login-card">
                <div class="brand-wrapper">
                    <img src="/Assets/images/logo.png" alt="logo" />
                    <h3>Sarina’s Handicraft</h3>
                </div>
                <p class="login-card-description text-center">Sign into your account</p>
                <asp:Literal ID="Message" Text="" runat="server"></asp:Literal>

                <asp:TextBox ID="txtUsername" CssClass="form-control" placeholder="Username" required="true" runat="server"></asp:TextBox>
                <asp:TextBox ID="txtPassword" CssClass="form-control" placeholder="Password" TextMode="Password" required="true" runat="server" />

                <asp:Button ID="Button1" runat="server" CssClass="btn btn-block login-btn" Text="Login" OnClick="LoginBtnClick" />

                <div class="login-card-footer-text">
                    Don’t have an account? <a href="/register.aspx">Register here</a>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
