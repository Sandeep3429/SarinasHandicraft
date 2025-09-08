using SarinasHandicraft.Dao;
using SarinasHandicraft.Dao.Impl;
using SarinasHandicraft.Models;
using SarinasHandicraft.Utils;
using System;
using System.Diagnostics;
using Newtonsoft.Json;
using System.Collections.Generic;
using System.Web.UI.WebControls;
using System.Drawing;

namespace SarinasHandicraft
{
    public partial class dashboard : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            OrderDao orderDao = new OrderDaoImpl();
            List<Order> orderList = orderDao.GetOrders();
            foreach(Order order in orderList)
            {
                orderDao = new OrderDaoImpl();
                List<OrderItem> orderItems = orderDao.GetOrderDetails(order.Id);
                order.Order_Details = JsonConvert.SerializeObject(orderItems);
                Debug.WriteLine(JsonConvert.SerializeObject(orderItems));
            }
            OrderGridView.DataSource = orderList;
            OrderGridView.DataBind();
        }

        protected void Update_Order(object sender, EventArgs e)
        {
            OrderDao orderDao = new OrderDaoImpl();
            Order order = orderDao.GetOrdersById(int.Parse(hiddenOrderId.Value));
            if(order == null)
            {
                Message.Text = "<div class='alert alert-danger'>Order does not exist.</div>";
                return;
            }
            orderDao = new OrderDaoImpl();
            order.Status = (OrderStatusEnum) Enum.Parse(typeof(OrderStatusEnum), editOrderStatus.Text);
            if (orderDao.UpdateOrder(order))
            {
                Message.Text = "<div class='alert alert-success'>Order status updated successfully.</div>";
                orderDao = new OrderDaoImpl();
                OrderGridView.DataSource = orderDao.GetOrders();
                OrderGridView.DataBind();
            }
            else
            {
                Message.Text = "<div class='alert alert-danger'>Error occured while updating order.</div>";
            }
        }

        protected void OnRowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                string status = (e.Row.Cells[5].Text);

                foreach (TableCell cell in e.Row.Cells)
                {
                    if (status == "PLACED")
                    {
                        cell.BackColor = Color.LightYellow;
                    }
                    if (status == "PROCESSING")
                    {
                        cell.BackColor = Color.LightBlue;
                    }
                    if (status == "DELIVERED")
                    {
                        cell.BackColor = Color.LightGreen;
                    }
                    if (status == "CANCELLED")
                    {
                        cell.BackColor = Color.OrangeRed;
                    }
                }
            }
        }
    }
}