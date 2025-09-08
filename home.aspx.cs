using SarinasHandicraft.Dao;
using SarinasHandicraft.Dao.Impl;
using SarinasHandicraft.Models;
using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SarinasHandicraft
{
    public partial class home : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack) { 
                ItemDao itemDao = new ItemDaoImpl();
                ProductList.DataSource = itemDao.GetActiveItems();
                ProductList.DataBind();
            }
            if (Session["UserId"] != null)
            {
                string id = Session["UserId"].ToString();
                int userId = int.Parse(id);
                CartDao cartDao = new CartDaoImpl();
                List<Cart> carts = cartDao.GetUserCarts(userId);
                ((Label)Page.Master.FindControl("CartCount")).Text = carts.Count().ToString();
            }
        }

        protected void AddToCart(object sender, EventArgs e)
        {
            Debug.WriteLine("Test");
        }

        protected void ProductList_ItemCommand(object sender, RepeaterCommandEventArgs e)
        {
            string id = Session["UserId"].ToString();
            int userId = int.Parse(id);
            if (e.CommandName == "Add")
            {
                string cartCount = ((Label)Page.Master.FindControl("CartCount")).Text;
                string quantity = ((TextBox)ProductList.Items[e.Item.ItemIndex].FindControl("Quantity")).Text;
                string itemId = ((HiddenField)ProductList.Items[e.Item.ItemIndex].FindControl("ItemId")).Value;
                Cart cart = new Cart();
                cart.Item_Id = int.Parse(itemId);
                cart.Quantity = int.Parse(quantity);
                cart.User_Id = userId;
                CartDao cartDao = new CartDaoImpl();
                if (cartDao.checkItemInCart(cart.User_Id, cart.Item_Id))
                {
                    if (cartDao.UpdateCart(cart))
                    {
                        Message.Text = "<div class='alert alert-success'>Cart has been updated successfully.</div>";
                        ((HiddenField)ProductList.Items[e.Item.ItemIndex].FindControl("ItemId")).Value = "1";
                        ((Label)Page.Master.FindControl("CartCount")).Text = (int.Parse(cartCount) + 1).ToString();
                    }
                    else
                    {
                        Message.Text = "<div class='alert alert-danger'>Cart update fail.</div>";
                    }
                }
                else
                {
                    if (cartDao.SaveCart(cart))
                    {
                        Message.Text = "<div class='alert alert-success'>Cart has been saved successfully.</div>";
                        ((HiddenField)ProductList.Items[e.Item.ItemIndex].FindControl("ItemId")).Value = "1";
                        ((Label)Page.Master.FindControl("CartCount")).Text = (int.Parse(cartCount) + 1).ToString();
                    }
                    else
                    {
                        Message.Text = "<div class='alert alert-danger'>Cart Save Fail.</div>";
                    }

                }
            }
        }
        
    }
}