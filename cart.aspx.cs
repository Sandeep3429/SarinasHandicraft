using SarinasHandicraft.Dao;
using SarinasHandicraft.Dao.Impl;
using SarinasHandicraft.Models;
using SarinasHandicraft.Utils;
using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Globalization;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SarinasHandicraft
{
    public partial class cart : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["UserId"] == null)
                {
                    // If session expired, redirect to login
                    Response.Redirect("/login.aspx");
                    return;
                }

                BindCart();
            }
        }

        private void BindCart()
        {
            string id = Session["UserId"].ToString();
            if (!int.TryParse(id, out int userId))
            {
                Message.Text = "<div class='alert alert-danger'>Invalid user session.</div>";
                return;
            }

            CartDao cartDao = new CartDaoImpl();
            List<Cart> carts = cartDao.GetUserCarts(userId);
            Count.Text = carts.Count().ToString();

            float totalSum = 0f;
            foreach (var cart in carts)
            {
                totalSum += cart.Total_Price;
            }
            TotalOrder.Text = "रु " + totalSum.ToString("0.00", CultureInfo.InvariantCulture);
            ((Label)Page.Master.FindControl("CartCount")).Text = carts.Count().ToString();
            CartList.DataSource = carts;
            CartList.DataBind();
        }

        protected void CartList_Command(Object sender, DataListCommandEventArgs e)
        {
            // SESSION check
            if (Session["UserId"] == null)
            {
                Response.Redirect("/login.aspx");
                return;
            }
            if (!int.TryParse(Session["UserId"].ToString(), out int userId))
            {
                Message.Text = "<div class='alert alert-danger'>Invalid user session.</div>";
                return;
            }

            // Use e.Item.FindControl (safer) to get controls
            var hfItemId = e.Item.FindControl("ItemId") as HiddenField;
            var hfMaxQty = e.Item.FindControl("Quantity") as HiddenField;
            var lblCartQty = e.Item.FindControl("CartQuantity") as Label;
            var hfUnitPrice = e.Item.FindControl("UnitPriceValue") as HiddenField;
            var lblUnitPrice = e.Item.FindControl("UnitPrice") as Label;
            var hfTotalPrice = e.Item.FindControl("TotalPriceValue") as HiddenField;
            var lblTotalPrice = e.Item.FindControl("TotalPrice") as Label;

            if (hfItemId == null)
            {
                Message.Text = "<div class='alert alert-danger'>Internal error: item id not found.</div>";
                return;
            }

            // Safe parsing
            int itemId = ParseIntSafe(hfItemId.Value);
            int maxQuantity = ParseIntSafe(hfMaxQty?.Value);
            int cartQuantity = ParseIntSafe(lblCartQty?.Text);

            float unitPrice = 0f;
            if (hfUnitPrice != null && !string.IsNullOrWhiteSpace(hfUnitPrice.Value))
            {
                float.TryParse(hfUnitPrice.Value, NumberStyles.Any, CultureInfo.InvariantCulture, out unitPrice);
            }
            else if (lblUnitPrice != null)
            {
                unitPrice = ParseCurrencyToFloat(lblUnitPrice.Text);
            }

            float totalPrice = 0f;
            if (hfTotalPrice != null && !string.IsNullOrWhiteSpace(hfTotalPrice.Value))
            {
                float.TryParse(hfTotalPrice.Value, NumberStyles.Any, CultureInfo.InvariantCulture, out totalPrice);
            }
            else if (lblTotalPrice != null)
            {
                totalPrice = ParseCurrencyToFloat(lblTotalPrice.Text);
            }

            CartDao cartDao = new CartDaoImpl();

            try
            {
                if (e.CommandName == "Delete")
                {
                    if (cartDao.DeleteCart(userId, itemId))
                    {
                        Message.Text = "<div class='alert alert-success'>Cart item deleted successfully.</div>";
                        BindCart();
                    }
                    else
                    {
                        Message.Text = "<div class='alert alert-danger'>Cart delete failed.</div>";
                    }
                }
                else if (e.CommandName == "Minus")
                {
                    if (cartQuantity > 1)
                    {
                        var newQty = cartQuantity - 1;
                        Cart cart = new Cart
                        {
                            User_Id = userId,
                            Item_Id = itemId,
                            Quantity = newQty,
                            Total_Price = newQty * unitPrice
                        };

                        if (cartDao.UpdateCart(cart))
                        {
                            Message.Text = "<div class='alert alert-success'>Cart updated successfully.</div>";
                            BindCart();
                        }
                        else
                        {
                            Message.Text = "<div class='alert alert-danger'>Error occurred during cart update.</div>";
                        }
                    }
                    else
                    {
                        Message.Text = "<div class='alert alert-danger'>Minimum order must be 1.</div>";
                    }
                }
                else if (e.CommandName == "Plus")
                {
                    if (maxQuantity > 0 && cartQuantity >= maxQuantity)
                    {
                        Message.Text = $"<div class='alert alert-danger'>Maximum item available is {maxQuantity}.</div>";
                        return;
                    }

                    var newQty = cartQuantity + 1;
                    Cart cart = new Cart
                    {
                        User_Id = userId,
                        Item_Id = itemId,
                        Quantity = newQty,
                        Total_Price = newQty * unitPrice
                    };

                    if (cartDao.UpdateCart(cart))
                    {
                        Message.Text = "<div class='alert alert-success'>Cart updated successfully.</div>";
                        BindCart();
                    }
                    else
                    {
                        Message.Text = "<div class='alert alert-danger'>Error occurred during cart update.</div>";
                    }
                }
            }
            catch (Exception ex)
            {
                // Log ex if you have a logging facility
                Debug.WriteLine("CartList_Command error: " + ex.ToString());
                Message.Text = "<div class='alert alert-danger'>An unexpected error occurred. Try again.</div>";
            }
        }

        protected void Save_Order(object sender, EventArgs e)
        {
            if (Session["UserId"] == null)
            {
                Response.Redirect("/login.aspx");
                return;
            }
            if (!int.TryParse(Session["UserId"].ToString(), out int userId))
            {
                Message.Text = "<div class='alert alert-danger'>Invalid user session.</div>";
                return;
            }

            string cardHolderName = CardName.Text;
            string cardNumber = CardNumber.Text;
            string expiryDate = ExpiryDate.Text;
            string cvvNumber = CVVNumber.Text;
            string paymentMethod = PaymentType.SelectedValue;

            if (string.IsNullOrWhiteSpace(cardNumber) || cardNumber.Length < 16)
            {
                Message.Text = "<div class='alert alert-danger'>Card Number must be 16 digits.</div>";
                return;
            }
            if (string.IsNullOrWhiteSpace(cvvNumber) || cvvNumber.Length < 3)
            {
                Message.Text = "<div class='alert alert-danger'>Invalid CVV Number</div>";
                return;
            }

            Order order = new Order
            {
                User_Id = userId,
                PaymentType = (PaymentTypeEnum)Enum.Parse(typeof(PaymentTypeEnum), paymentMethod),
                Address = Address.Text
            };

            CartDao cartDao = new CartDaoImpl();
            List<Cart> carts = cartDao.GetUserCarts(userId);
            float totalOrder = 0f;
            foreach (var cart in carts) totalOrder += cart.Total_Price;
            order.Total = totalOrder;

            OrderDao orderDao = new OrderDaoImpl();
            if (orderDao.SaveOrder(order, carts))
            {
                Message.Text = "<div class='alert alert-success'>Order has been placed.</div>";
                if (cartDao.ClearCart(userId))
                {
                    Response.Redirect("/order.aspx");
                }
            }
            else
            {
                Message.Text = "<div class='alert alert-danger'>Failed to save order. Try again later</div>";
            }
        }

        // Helpers
        private int ParseIntSafe(string s)
        {
            if (string.IsNullOrWhiteSpace(s)) return 0;
            if (int.TryParse(s, out int v)) return v;
            // remove non digits
            var cleaned = Regex.Replace(s, @"[^\d\-]", "");
            if (int.TryParse(cleaned, out v)) return v;
            return 0;
        }

        private float ParseCurrencyToFloat(string s)
        {
            if (string.IsNullOrWhiteSpace(s)) return 0f;
            // remove everything except digits and dot and minus
            var cleaned = Regex.Replace(s, @"[^\d\.\-]", "");
            if (float.TryParse(cleaned, NumberStyles.Any, CultureInfo.InvariantCulture, out float v)) return v;
            if (float.TryParse(cleaned, out v)) return v;
            return 0f;
        }
    }
}
