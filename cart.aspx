<%@ Page Title="Shopping Cart" Language="C#" EnableEventValidation="true" MasterPageFile="~/Home.Master" AutoEventWireup="true" CodeBehind="cart.aspx.cs" Inherits="SarinasHandicraft.cart" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        /* Hero section like home */
        .hero {
            text-align: center;
            padding: 40px 20px;
            background: linear-gradient(135deg, #fdf6f0, #fae5d3);
            border-radius: 12px;
            margin-bottom: 30px;
            box-shadow: 0 6px 20px rgba(0,0,0,0.1);
        }
        .hero h1 { font-family: 'Playfair Display', serif; font-size: 2rem; color: #503b75; margin: 0; }
        .hero p  { color: #6b5e58; margin-top: 8px; }

        /* Cart Layout */
        .cart-wrapper { display: grid; grid-template-columns: 2fr 1fr; gap: 25px; }
        @media (max-width: 992px) { .cart-wrapper { grid-template-columns: 1fr; } }

        /* Cart Items */
        .cart-card {
            background: #fff; border-radius: 12px; padding: 15px; margin-bottom: 15px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.08);
            display: flex; justify-content: space-between; align-items: center;
        }
        .cart-card img { width: 60px; height: 60px; border-radius: 8px; object-fit: cover; }
        .cart-details { margin-left: 12px; }
        .cart-name { font-weight: 600; color: #503b75; }
        .cart-category { font-size: 0.85rem; color: #888; }

        /* Controls */
        .cart-controls { display: flex; align-items: center; gap: 10px; }
        .cart-controls .fa { cursor: pointer; color: #503b75; }
        .cart-price { font-weight: bold; color: #a46f50; }

        /* Payment Box */
        .payment-box {
            background: #fff; border-radius: 12px; padding: 20px; box-shadow: 0 4px 12px rgba(0,0,0,0.1);
        }
        .payment-box h5 { color: #503b75; font-weight:700; }
        .credit-card-label { font-weight: 600; margin-top: 10px; display:block; }
        .credit-inputs { border-radius: 8px; margin-bottom: 12px; }
        .total-line { display:flex; justify-content:space-between; margin:15px 0; font-weight:700; color:#503b75; }
        .btn-checkout { width:100%; padding:12px; font-weight:600; border-radius:10px; }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!-- Hero -->
    <div class="hero">
        <h1>Your Shopping Cart</h1>
        <p>Review your items and proceed to checkout</p>
    </div>

    <!-- Cart Layout -->
    <div class="container">
        <asp:Literal ID="Message" runat="server"></asp:Literal>
        <div class="cart-wrapper">

            <!-- Left Side: Items -->
            <div>
                <a href="/home.aspx" class="btn btn-link mb-3"><i class="fa fa-long-arrow-left"></i> Continue Shopping</a>
                <h5 class="mb-3">You have <asp:Label ID="Count" runat="server">0</asp:Label> items</h5>

                <asp:DataList ID="CartList" runat="server" Width="100%" OnItemCommand="CartList_Command" RepeatColumns="1">
                    <ItemTemplate>
                        <!-- raw values for parsing -->
                        <asp:HiddenField ID="ItemId" runat="server" Value='<%# Eval("Item_Id") %>' />
                        <asp:HiddenField ID="Quantity" runat="server" Value='<%# Eval("Item_Quantity") %>' />
                        <asp:HiddenField ID="UnitPriceValue" runat="server" Value='<%# Eval("Item_Price") %>' />
                        <asp:HiddenField ID="TotalPriceValue" runat="server" Value='<%# Eval("Total_Price") %>' />

                        <div class="cart-card">
                            <div class="d-flex align-items-center">
                                <img src='<%# Eval("Item_Image").ToString().Replace("~","") %>' alt='<%# Eval("Item_Name") %>' />
                                <div class="cart-details">
                                    <span class="cart-name"><%# Eval("Item_Name") %></span>
                                    <span class="cart-category"><%# Eval("Category_Name") %></span>
                                </div>
                            </div>

                            <div class="cart-controls">
                                <asp:LinkButton ID="BtnMinus" CommandName="Minus" runat="server"><i class="fa fa-minus"></i></asp:LinkButton>
                                <asp:Label ID="CartQuantity" Text='<%# Eval("Item_Quantity") %>' runat="server"></asp:Label>
                                <asp:LinkButton ID="BtnPlus" CommandName="Plus" runat="server"><i class="fa fa-plus"></i></asp:LinkButton>

                                <!-- display (with रु) -->
                                <asp:Label ID="UnitPrice" CssClass="cart-price" Text='<%# String.Format("रु {0}", Eval("Item_Price")) %>' runat="server" />
                                <asp:Label ID="TotalPrice" CssClass="cart-price" Text='<%# String.Format("रु {0}", Eval("Total_Price")) %>' runat="server" />

                                <asp:LinkButton ID="BtnDelete" CommandName="Delete" CssClass="text-danger" runat="server"><i class="fa fa-trash"></i></asp:LinkButton>
                            </div>
                        </div>
                    </ItemTemplate>
                </asp:DataList>
            </div>

            <!-- Right Side: Checkout -->
            <div class="payment-box">
                <h5>Payment Information</h5>

                <asp:RadioButtonList ID="PaymentType" runat="server" RepeatDirection="Horizontal" CssClass="mb-3">
                    <asp:ListItem Text='<img src="/Assets/images/mastercard.png" width="40" />' Value="MASTER_CARD" Selected="True" />
                    <asp:ListItem Text='<img src="/Assets/images/visa.png" width="40" />' Value="VISA" />
                    <asp:ListItem Text='<img src="/Assets/images/amex.png" width="40" />' Value="AMEX" />
                </asp:RadioButtonList>

                <label class="credit-card-label">Name on Card</label>
                <asp:TextBox ID="CardName" runat="server" CssClass="form-control credit-inputs" MaxLength="50"></asp:TextBox>

                <label class="credit-card-label">Card Number</label>
                <asp:TextBox ID="CardNumber" runat="server" CssClass="form-control credit-inputs" placeholder="4321125478963214" />

                <div class="row">
                    <div class="col-md-6">
                        <label class="credit-card-label">Expiry Date</label>
                        <asp:TextBox ID="ExpiryDate" runat="server" CssClass="form-control credit-inputs" TextMode="Date"></asp:TextBox>
                    </div>
                    <div class="col-md-6">
                        <label class="credit-card-label">CVV</label>
                        <asp:TextBox ID="CVVNumber" runat="server" CssClass="form-control credit-inputs" placeholder="342" TextMode="Number"></asp:TextBox>
                    </div>
                </div>

                <label class="credit-card-label">Address</label>
                <asp:TextBox ID="Address" runat="server" CssClass="form-control credit-inputs"></asp:TextBox>

                <div class="total-line">
                    <span>Total</span>
                    <asp:Label ID="TotalOrder" runat="server">$ 0</asp:Label>
                </div>

                <asp:Button ID="CheckOut" Text="Proceed to Checkout" runat="server" CssClass="btn btn-primary btn-checkout" OnClick="Save_Order"/>
            </div>
        </div>
    </div>
</asp:Content>
