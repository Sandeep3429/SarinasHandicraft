using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using SarinasHandicraft.Models;
using SarinasHandicraft.Dao;
using SarinasHandicraft.Dao.Impl;
using System.Data;
using System.Diagnostics;

namespace SarinasHandicraft
{
    public partial class product : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            DashboardDao dashboardDao = new DashboardImpl();
            DashboardReport dashboardReport = dashboardDao.GetDashboardReport();
            TotalCustomer.Text = dashboardReport.TotalCustomer.ToString();
            ActiveCustomer.Text = dashboardReport.TotalActiveCustomer.ToString() ;
            InactiveCustomer.Text = dashboardReport.TotalInactiveCustomer.ToString();
            DeleteUser.Text = dashboardReport.TotalDeleteCustomer.ToString();

            OrderCount.Text = dashboardReport.TotalOrder.ToString();
            TotalOrderAmount.Text = dashboardReport.TotalOrderAmount.ToString();
            DelieveredOrder.Text = dashboardReport.TotalDelivered.ToString();
            CancelledOrder.Text = dashboardReport.TotalCancelled.ToString();
        }

       
    }
}