using Newtonsoft.Json;
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
    public partial class order : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Debug.WriteLine("userId: " + Session["UserId"]);

            if (Session["UserId"] != null)
            {
                string id = (string) Session["UserId"];
                int userId = int.Parse(id);
                OrderDao orderDao = new OrderDaoImpl();
                List<Order> orderList = orderDao.GetOrdersByUser(userId);
                foreach (Order order in orderList)
                {
                    orderDao = new OrderDaoImpl();
                    List<OrderItem> orderItems = orderDao.GetOrderDetails(order.Id);
                    order.Order_Details = JsonConvert.SerializeObject(orderItems);
                    Debug.WriteLine(JsonConvert.SerializeObject(orderItems));
                }
                OrderGridView.DataSource = orderList;
                OrderGridView.DataBind();

                CartDao cartDao = new CartDaoImpl();
                List<Cart> carts = cartDao.GetUserCarts(userId);
                Debug.WriteLine(carts.Count);
                ((Label)Page.Master.FindControl("CartCount")).Text = carts.Count().ToString();
            }
        }
    }
}