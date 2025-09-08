<%@ Page Title="Sarina's Handicraft Store" Language="C#" EnableEventValidation="true" MasterPageFile="~/Home.Master" AutoEventWireup="true" CodeBehind="home.aspx.cs" Inherits="SarinasHandicraft.home" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet" />
    <style>
        /* Hero Section */
        .hero {
            text-align: center;
            padding: 80px 20px 60px;
            background: linear-gradient(135deg, #fdf6f0, #fae5d3);
            border-radius: 12px;
            margin-bottom: 50px;
            box-shadow: 0 8px 30px rgba(0,0,0,0.12);
            position: relative;
            overflow: hidden;
        }
        .hero h1 {
            font-family: 'Playfair Display', serif;
            font-size: 3rem;
            font-weight: 700;
            color: #503b75;
            margin-bottom: 15px;
        }
        .hero p {
            font-size: 1.2rem;
            color: #6b5e58;
            margin-bottom: 25px;
        }
        .hero .btn-shop {
            padding: 12px 28px;
            font-weight: 600;
            font-size: 1.1rem;
            border-radius: 8px;
            background-color: #a46f50;
            color: #fff;
            text-decoration: none;
            transition: all 0.3s ease;
        }
        .hero .btn-shop:hover {
            background-color: #8a573c;
            color: #fff;
        }

        /* Hero Decorative Circles */
        .hero::before, .hero::after {
            content: '';
            position: absolute;
            border-radius: 50%;
            background: rgba(164, 111, 80, 0.15);
        }
        .hero::before {
            width: 200px; height: 200px; top: -50px; left: -50px;
        }
        .hero::after {
            width: 300px; height: 300px; bottom: -80px; right: -80px;
        }

        /* Product Grid */
        .product-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(240px, 1fr));
            gap: 25px;
        }
        .product-card {
            background: #fff;
            border-radius: 12px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.08);
            overflow: hidden;
            text-align: center;
            padding-bottom: 15px;
            transition: transform 0.25s ease, box-shadow 0.3s ease;
        }
        .product-card:hover {
            transform: translateY(-6px);
            box-shadow: 0 12px 28px rgba(0,0,0,0.12);
        }
        .product-card img {
            width: 100%;
            height: 200px;
            object-fit: cover;
            cursor: pointer;
        }
        .product-info {
            padding: 15px;
        }
        .product-name {
            font-weight: 600;
            font-size: 1.1rem;
            color: #503b75;
            margin: 5px 0;
        }
        .product-category {
            font-size: 0.85rem;
            color: #888;
        }
        .product-price {
            font-weight: bold;
            color: #a46f50;
            font-size: 1.2rem;
            margin-top: 6px;
        }
        .stock {
            font-size: 0.9rem;
            color: #666;
            margin-top: 5px;
        }
        .quantity-control {
            display: flex;
            justify-content: center;
            align-items: center;
            gap: 6px;
            margin-top: 12px;
        }
        .quantity-control input[type="button"] {
            width: 32px;
            height: 32px;
            background: #f5f5f5;
            border: 1px solid #ccc;
            border-radius: 6px;
            font-weight: bold;
            cursor: pointer;
        }
        .quantity-control .form-control {
            width: 50px;
            text-align: center;
            padding: 5px;
        }
        .btn-add {
            margin-top: 12px;
            font-weight: 600;
            border-radius: 8px;
        }

        /* Modal */
        .modal-content {
            border-radius: 12px;
            box-shadow: 0 6px 20px rgba(0,0,0,0.15);
        }
        .modal-title {
            font-weight: 700;
            color: #503b75;
        }

        @media (max-width: 768px) {
            .hero h1 { font-size: 2rem; }
            .hero p { font-size: 1rem; }
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!-- Hero Section -->
    <div class="hero">
        <h1>Welcome to Sarina’s Handicraft Store</h1>
        <p>Discover handcrafted treasures, made with love and tradition.</p>
        <a href="#products" class="btn-shop">Shop Now</a>
    </div>

    <!-- Product Section -->
    <div class="container" id="products">
        <asp:Literal ID="Message" Text="" runat="server"></asp:Literal>
        <div class="product-grid">
            <asp:Repeater ID="ProductList" runat="server" OnItemCommand="ProductList_ItemCommand">
                <ItemTemplate>
                    <div class="product-card">
                        <img src='<%# Eval("Image").ToString().Replace("~","") %>' alt="<%# Eval("Name") %>"
                             data-toggle="modal" data-target="#itemDetailModal"
                             data-id="<%# Eval("Image") %>"
                             data-name="<%# Eval("Name") %>"
                             data-price="<%# Eval("Price") %>"
                             data-quantity="<%# Eval("Quantity") %>"
                             data-description="<%# Eval("Description") %>"
                             data-code="<%# Eval("Code") %>"
                             data-category="<%# Eval("Category_Name") %>">
                        <div class="product-info">
                            <div class="product-category"><%# Eval("Category_Name") %></div>
                            <div class="product-name"><%# Eval("Name") %></div>
                            <div class="product-price">रु <%# Eval("Price") %></div>
                            <div class="stock">Stock: <%# Eval("Quantity") %></div>
                            <div class="quantity-control" id="Item_<%# Eval("Id") %>">
                                <input type="button" value="-" class="minus" data-id="<%# Eval("Id") %>" data-quantity="<%# Eval("Quantity") %>">
                                <asp:TextBox ID="Quantity" runat="server" Text="1" CssClass="form-control qty"></asp:TextBox>
                                <asp:HiddenField ID="ItemId" runat="server" Value='<%# Eval("Id") %>'></asp:HiddenField>
                                <input type="button" value="+" class="plus" data-id="<%# Eval("Id") %>" data-quantity="<%# Eval("Quantity") %>">
                            </div>
                            <asp:Button ID="AddToCart" runat="server" Text="Add to Cart" CssClass="btn btn-primary btn-block btn-add" CommandName="Add" CommandArgument='<%# Eval("Quantity")%>' />
                        </div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </div>
    </div>

    <!-- Item Details Modal -->
    <div class="modal fade" id="itemDetailModal" tabindex="-1" role="dialog">
      <div class="modal-dialog modal-dialog-centered" role="document">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title">Item Details</h5>
            <button type="button" class="close" data-dismiss="modal"><span>&times;</span></button>
          </div>
          <div class="modal-body">
              <div class="form-group">
                <label>Item Name</label><br />
                <asp:Label ID="ItemName" runat="server" CssClass="font-weight-bold"></asp:Label><br />
                <img src="/" id="ItemImage" class="img-thumbnail mt-2" width="120" />
              </div>
              <div class="form-group">
                <label>Description</label><br />
                <asp:Label ID="Description" runat="server"></asp:Label>
              </div>
              <div class="form-group">
                <label>Code</label><br />
                <asp:Label ID="Code" runat="server"></asp:Label>
              </div>
              <div class="form-group">
                <label>Available Stock</label><br />
                <asp:Label ID="Stock" runat="server"></asp:Label>
              </div>
              <div class="form-group">
                <label>Category</label><br />
                <asp:Label ID="Category" runat="server"></asp:Label>
              </div>
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
          </div>
        </div>
      </div>
    </div>

    <!-- Scripts -->
    <script type="text/javascript" src="/Assets/js/jquery-3.4.1.min.js"></script>
    <script>
        $(function () {
            $('.minus').on('click', function () {
                var itemId = $(this).attr('data-id');
                var count = parseInt($(this).parents('#Item_' + itemId).find('.qty').val());
                if (count > 1) count--;
                $(this).parents('#Item_' + itemId).find('.qty').val(count);
            });

            $('.plus').on('click', function () {
                var itemId = $(this).attr('data-id');
                var maxQty = $(this).attr('data-quantity');
                var count = parseInt($(this).parents('#Item_' + itemId).find('.qty').val());
                if (count < maxQty) count++;
                $(this).parents('#Item_' + itemId).find('.qty').val(count);
            });

            $('#itemDetailModal').on('shown.bs.modal', function (e) {
                var button = $(e.relatedTarget);
                $("#ContentPlaceHolder1_ItemName").html(button.attr("data-name"));
                $("#ContentPlaceHolder1_Description").html(button.attr("data-description"));
                $("#ContentPlaceHolder1_Code").html(button.attr("data-code"));
                $("#ContentPlaceHolder1_Stock").html(button.attr("data-quantity"));
                $("#ContentPlaceHolder1_Category").html(button.attr("data-category"));
                $("#ItemImage").attr('src', button.attr("data-id").replace("~", ""));
            });
        });
    </script>
</asp:Content>
