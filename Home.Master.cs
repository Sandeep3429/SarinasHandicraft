using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SarinasHandicraft
{
    public partial class Home : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserId"] == null || Session["UserId"].ToString() == "")
            {
                Debug.WriteLine("Session empty");
                if (UserId.Value != "")
                {
                    Session["UserId"] = UserId.Value;
                    Session["Name"] = Name.Value;
                    Session["Role"] = Role.Value;
                }
                else
                {
                    Response.Redirect("/login.aspx");
                    return;
                }
            }
            else
            {
                if (Session["Role"].ToString() != "ROLE_USER")
                {
                    Debug.WriteLine("Role:" + Session["Role"].ToString());
                    Response.Redirect("/login.aspx");
                    return;
                }
                UserId.Value = Session["UserId"].ToString();
                Name.Value = Session["Name"].ToString();
                Role.Value = Session["Role"].ToString();
            }

            // Debug.WriteLine(Session["UserId"]);
            /*if(Request.Cookies["UserId"] != null) {
                Debug.WriteLine("Cookie: " + Request.Cookies["UserId"].Value);
                Debug.WriteLine("Cookie: " + Request.Cookies["Role"].Value);
                if(Request.Cookies["UserId"].Value == "0" || Request.Cookies["Role"].Value != "ROLE_USER" )
                {
                    Response.Redirect("/login.aspx");
                    return;
                }
            }
            else
            {
                Response.Redirect("/login.aspx");
                return;
            }*/
        }

        protected void Logout(object sender, EventArgs e)
        {
            Session.Clear();
            Response.Redirect("/login.aspx");
        }
    }
}