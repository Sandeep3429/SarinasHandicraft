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
    public partial class _default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["RegisterStatus"]!=null && Session["RegisterStatus"].ToString() == "True")
            {
                Message.Text = "<div class='alert alert-success'>Registration has been Successful. Please Login.</div>";
            }
        }

        protected void LoginView1_ViewChanged(object sender, EventArgs e)
        {

        }

        protected void LoginBtnClick(object sender, EventArgs e)
        {
            try
            {
                User user = new User();
                UserDao userDao = new UserDaoImpl();
                user.Username = txtUsername.Text;
                user.Password = txtPassword.Text;
                User previousUser = userDao.CheckUser(user);
                if (previousUser!=null && previousUser.Id!=0)
                {
                    Session["Username"] = txtUsername.Text;
                    Session["UserId"] = previousUser.Id.ToString();
                    Debug.WriteLine(Session["UserId"].ToString());
                    Session["Name"] = previousUser.FirstName + " " + previousUser.LastName;
                    Session["Role"] = previousUser.Role.ToString();
                    /*HttpCookie userId = new HttpCookie("UserId");
                    userId.Value = previousUser.Id.ToString();
                    HttpCookie role = new HttpCookie("Role");
                    role.Value = previousUser.Role.ToString();
                    Response.Cookies.Add(userId);
                    Response.Cookies.Add(role);*/
                    Message.Text = "<div class='alert alert-success'>Login Success</div>";
                    if (previousUser.Role.ToString() == "ROLE_USER")
                    {
                        Response.Redirect("home.aspx", false);
                        Context.ApplicationInstance.CompleteRequest();
                    }
                    else
                    {
                        Response.Redirect("dashboard.aspx");
                    }
                }
                else
                {
                    Message.Text = "<div class='alert alert-danger'>Invalid User or Password.</div>";
                }
            }
            catch (Exception ex)
            {
                Message.Text = "<div class='alert alert-danger'>"+ex.Message+"</div>";
            }
        }
    }
}