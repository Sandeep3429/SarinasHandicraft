<%@ Page Title="" Language="C#" MasterPageFile="~/Default.Master" AutoEventWireup="true" CodeBehind="register.aspx.cs" Inherits="SarinasHandicraft.register" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        /* Centered register layout that matches site theme */
        .register-wrapper {
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 48px 8px;
        }

        .card-register {
            width: 100%;
            max-width: 980px;
            display: flex;
            border-radius: 14px;
            overflow: hidden;
            background: #fff;
            box-shadow: 0 12px 36px rgba(0,0,0,0.08);
            border: 1px solid #efe6df;
        }

        /* Left image (hidden on small screens) */
        .card-left {
            flex: 1;
            min-height: 520px;
            background-image: url('/Assets/images/login.jpg');
            background-size: cover;
            background-position: center;
            position: relative;
        }
        .card-left::after {
            /* subtle overlay so text or logo on image reads well */
            content: "";
            position: absolute;
            inset: 0;
            background: linear-gradient(180deg, rgba(255,255,255,0.05) 0%, rgba(255,255,255,0.25) 100%);
        }

        /* Right form area */
        .card-right {
            flex: 1;
            padding: 38px;
            display: flex;
            flex-direction: column;
            justify-content: center;
        }

        .brand-wrapper {
            display: flex;
            align-items: center;
            gap: 12px;
            margin-bottom: 12px;
        }
        .brand-wrapper img.logo {
            width: 72px;
            height: 72px;
            border-radius: 10px;
            object-fit: contain;
            box-shadow: 0 8px 20px rgba(80,59,117,0.06);
            background: #fff;
            padding: 8px;
        }
        .brand-title {
            font-family: 'Playfair Display', serif;
            font-size: 1.25rem;
            color: #503b75;
            font-weight: 700;
        }

        .login-card-description {
            margin-bottom: 18px;
            color: #6b5e58;
            font-size: 1rem;
        }

        /* Inputs */
        .form-control {
            border-radius: 10px;
            padding: 12px 14px;
            border: 1px solid #e4dcd3;
            box-shadow: none;
            transition: border-color 0.18s ease, box-shadow 0.18s ease;
            font-size: 0.96rem;
        }
        .form-control:focus {
            outline: none;
            box-shadow: 0 6px 18px rgba(80,59,117,0.06);
            border-color: #503b75;
        }

        /* Radio group */
        .gender-group .radio {
            margin-right: 14px;
            margin-left: 0;
        }

        /* Register button */
        .btn-register {
            border-radius: 10px;
            padding: 12px 16px;
            font-weight: 700;
            margin-top: 8px;
        }

        /* Footer text */
        .login-card-footer-text {
            margin-top: 14px;
            font-size: 0.95rem;
            color: #6b5e58;
        }
        .login-card-footer-text a {
            color: #a46f50;
            font-weight: 700;
            text-decoration: none;
        }

        /* client message element for quick client-side errors */
        #clientMessage {
            display: none;
            margin-bottom: 12px;
        }

        /* Responsive: stack on small screens */
        @media (max-width: 900px) {
            .card-register { flex-direction: column; }
            .card-left { display: none; }
            .card-right { padding: 28px; }
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:Panel ID="Panel1" runat="server">
        <div class="register-wrapper">
            <div class="card-register" role="region" aria-label="Registration card">
                <!-- visual left side -->
                <div class="card-left" aria-hidden="true"></div>

                <!-- right side: form -->
                <div class="card-right">
                    <div class="brand-wrapper" aria-hidden="false">
                        <img src="/Assets/images/logo.png" alt="Sarina's Logo" class="logo" />
                        <div>
                            <div class="brand-title">Sarina’s Handicraft</div>
                            <div style="font-size:0.9rem;color:#7a6c64;">Handmade &amp; Heartfelt</div>
                        </div>
                    </div>

                    <p class="login-card-description">Create your account — it takes just a minute.</p>

                    <!-- server messages from code-behind -->
                    <asp:Literal ID="Message" Text="" runat="server"></asp:Literal>

                    <!-- client-only validation message -->
                    <div id="clientMessage" class="alert alert-danger" role="alert" aria-live="polite"></div>

                    <!-- form controls (IDs unchanged) -->
                    <div class="form-group">
                        <label class="sr-only" for="<%= txtFirstName.ClientID %>">First Name</label>
                        <asp:TextBox ID="txtFirstName" CssClass="form-control" placeholder="First Name" required="true" runat="server"></asp:TextBox>
                    </div>

                    <div class="form-group">
                        <label class="sr-only" for="<%= txtLastName.ClientID %>">Last Name</label>
                        <asp:TextBox ID="txtLastName" CssClass="form-control" placeholder="Last Name" required="true" runat="server"></asp:TextBox>
                    </div>

                    <div class="form-group">
                        <label class="sr-only" for="<%= txtUsername.ClientID %>">Username</label>
                        <asp:TextBox ID="txtUsername" CssClass="form-control" placeholder="Username" required="true" runat="server"></asp:TextBox>
                    </div>

                    <div class="form-group mb-3">
                        <label class="sr-only" for="<%= txtPassword.ClientID %>">Password</label>
                        <asp:TextBox ID="txtPassword" CssClass="form-control" placeholder="Password" TextMode="Password" required="true" runat="server" />
                    </div>

                    <div class="form-group mb-3">
                        <label class="sr-only" for="<%= txtConfirmPassword.ClientID %>">Confirm Password</label>
                        <asp:TextBox ID="txtConfirmPassword" CssClass="form-control" placeholder="Confirm Password" TextMode="Password" required="true" runat="server" />
                    </div>

                    <div class="form-group mb-2 gender-group" aria-label="Gender">
                        <asp:RadioButtonList ID="GenderRadioBtn" runat="server" RepeatDirection="Horizontal" CssClass="form-control-plaintext">
                            <asp:ListItem Text ="Male" Value="Male" Selected="true" />
                            <asp:ListItem Text ="Female" Value="Female" />
                            <asp:ListItem Text ="Others" Value="Others" />
                        </asp:RadioButtonList>
                    </div>

                    <!-- keep the same button ID and server OnClick handler; add a client-side validator -->
                    <asp:Button ID="Button1" runat="server" CssClass="btn btn-primary btn-block btn-register" Text="Register"
                                OnClick="RegisterBtnClick" OnClientClick="return validateRegister();" />

                    <div class="login-card-footer-text">
                        Already have account?
                        <a href="/login.aspx">Login</a>
                    </div>
                </div>
            </div>
        </div>
    </asp:Panel>

    <!-- small client-side validation script (non-invasive) -->
    <script type="text/javascript">
        function showClientMessage(msg) {
            var el = document.getElementById('clientMessage');
            el.innerText = msg;
            el.style.display = 'block';
        }
        function hideClientMessage() {
            var el = document.getElementById('clientMessage');
            el.style.display = 'none';
        }

        function validateRegister() {
            hideClientMessage();
            // grab server-side rendered client IDs
            var pwd = document.getElementById('<%= txtPassword.ClientID %>').value || '';
            var cp = document.getElementById('<%= txtConfirmPassword.ClientID %>').value || '';
            var username = document.getElementById('<%= txtUsername.ClientID %>').value || '';
            // simple rules: username + password length and match
            if (username.trim().length < 3) {
                showClientMessage('Username must be at least 3 characters.');
                return false;
            }
            if (pwd.length < 6) {
                showClientMessage('Password should be at least 6 characters.');
                return false;
            }
            if (pwd !== cp) {
                showClientMessage('Passwords do not match.');
                return false;
            }
            // all good -> allow server postback (server RegisterBtnClick will run)
            hideClientMessage();
            return true;
        }
    </script>
</asp:Content>
