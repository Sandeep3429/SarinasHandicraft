<%@ Page Title="My Profile" Language="C#" MasterPageFile="~/Home.Master" AutoEventWireup="true" CodeBehind="profile.aspx.cs" Inherits="SarinasHandicraft.profile" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="/Assets/css/profile.css" rel="stylesheet" />
    <style>
        .profile-card {
            background: #fff;
            border-radius: 12px;
            box-shadow: 0 6px 18px rgba(0,0,0,0.08);
            padding: 20px;
            transition: all 0.3s ease;
        }
        .profile-card:hover {
            box-shadow: 0 10px 25px rgba(0,0,0,0.12);
        }
        .profile-image {
            border-radius: 50%;
            border: 4px solid #a46f50;
            width: 150px;
            height: 150px;
            object-fit: cover;
        }
        .profile-name {
            font-family: 'Playfair Display', serif;
            font-size: 1.6rem;
            font-weight: 700;
            color: #503b75;
            margin-top: 10px;
        }
        .profile-username {
            color: #888;
            font-size: 0.9rem;
            margin-bottom: 10px;
        }
        .profile-info h6 {
            font-weight: 600;
            color: #503b75;
        }
        .profile-info .text-secondary {
            color: #666;
            font-weight: 500;
        }
        .profile-info hr {
            border-top: 1px solid #eee;
            margin: 10px 0;
        }
        .btn-edit {
            background: #503b75;
            border: none;
            border-radius: 8px;
            color: #fff;
            font-weight: 600;
            padding: 8px 20px;
            transition: all 0.3s ease;
        }
        .btn-edit:hover {
            background: #a46f50;
            color: #fff;
        }
        @media (max-width: 767px) {
            .profile-card {
                margin-bottom: 20px;
            }
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="content">
        <div class="container">
            <div class="main-body">
                <div class="row gutters-sm">
                    <!-- Profile Sidebar -->
                    <div class="col-md-4 mb-3">
                        <div class="profile-card text-center">
                            <asp:Image ID="ProfileImage" CssClass="profile-image" runat="server" />
                            <div class="mt-3">
                                <h4 class="profile-name"><asp:Label ID="FullName" runat="server" /></h4>
                                <p class="profile-username"><asp:Label ID="Username" runat="server" /></p>
                            </div>
                        </div>
                    </div>

                    <!-- Profile Details -->
                    <div class="col-md-8">
                        <div class="profile-card profile-info">
                            <div class="row mb-2">
                                <div class="col-sm-4"><h6>First Name</h6></div>
                                <div class="col-sm-8 text-secondary"><asp:Label ID="FirstName" runat="server" /></div>
                            </div>
                            <hr />
                            <div class="row mb-2">
                                <div class="col-sm-4"><h6>Last Name</h6></div>
                                <div class="col-sm-8 text-secondary"><asp:Label ID="LastName" runat="server" /></div>
                            </div>
                            <hr />
                            <div class="row mb-2">
                                <div class="col-sm-4"><h6>Mobile</h6></div>
                                <div class="col-sm-8 text-secondary"><asp:Label ID="Mobile" runat="server" /></div>
                            </div>
                            <hr />
                            <div class="row mb-2">
                                <div class="col-sm-4"><h6>Gender</h6></div>
                                <div class="col-sm-8 text-secondary"><asp:Label ID="Gender" runat="server" /></div>
                            </div>
                            <hr />
                            <div class="row mb-2">
                                <div class="col-sm-4"><h6>Registered Date</h6></div>
                                <div class="col-sm-8 text-secondary"><asp:Label ID="CreatedDate" runat="server" /></div>
                            </div>
                            <hr />
                            <div class="row mb-2">
                                <div class="col-sm-4"><h6>Role</h6></div>
                                <div class="col-sm-8 text-secondary"><asp:Label ID="Role" runat="server" /></div>
                            </div>
                            <hr />
                            <div class="row mb-2">
                                <div class="col-sm-4"><h6>Address</h6></div>
                                <div class="col-sm-8 text-secondary"><asp:Label ID="Address" runat="server" /></div>
                            </div>
                            <hr />
                            <div class="row mt-3">
                                <div class="col-sm-12 text-right">
                                    <a class="btn btn-edit" href="/updateProfile.aspx">Edit Profile</a>
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
