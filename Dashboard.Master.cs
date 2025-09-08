using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SarinasHandicraft
{
    public partial class Dashboard : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserId"] == null || Session["UserId"].ToString() == "")
            {
                Debug.WriteLine("Session empty");
                Response.Redirect("/login.aspx");
                return;
            }
            else
            {
                if (Session["Role"].ToString() == "ROLE_ADMIN" || Session["Role"].ToString() == "ROLE_MANAGER")
                {
                    LoginUserName.Text = Session["Name"].ToString();
                    return;
                }
                if (Session["Role"].ToString() == "ROLE_USER")
                {
                    Debug.WriteLine("Role:" + Session["Role"].ToString());
                    Response.Redirect("/home.aspx");
                    return;
                }
                Response.Redirect("/login.aspx");
            }
        }

        protected void Logout(object sender, EventArgs e)
        {
            Session.Clear();
            Response.Redirect("/login.aspx");
        }
    }
}