using SarinasHandicraft.Dao;
using SarinasHandicraft.Dao.Impl;
using SarinasHandicraft.Models;
using SarinasHandicraft.Utils;
using System;
using System.Diagnostics;
using System.Web.UI;

namespace SarinasHandicraft
{
    public partial class register : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void RegisterBtnClick(object sender, EventArgs e)
        {
            // Validate Password
            if (txtPassword.Text.Length < 8)
            {
                Message.Text = "<div class='alert alert-danger'>Password must be minimum 8 characters.</div>";
                return;
            }
            if (txtPassword.Text != txtConfirmPassword.Text)
            {
                Message.Text = "<div class='alert alert-danger'>Password does not match.</div>";
                return;
            }

            try
            {
                User user = new User
                {
                    FirstName = txtFirstName.Text.Trim(),
                    LastName = txtLastName.Text.Trim(),
                    Username = txtUsername.Text.Trim(),
                    Password = txtPassword.Text,
                    Gender = GenderRadioBtn.SelectedValue,
                    Role = RoleEnum.ROLE_USER
                };

                UserDao userDao = new UserDaoImpl();

                // Check username existence
                User previousUser = userDao.CheckUser(user);
                if (previousUser != null)
                {
                    Message.Text = "<div class='alert alert-danger'>Username already exists.</div>";
                    return;
                }

                // Save user
                bool saved = userDao.SaveUser(user);
                if (saved)
                {
                    Session["RegisterStatus"] = "True";
                    Response.Redirect("/login.aspx");
                }
                else
                {
                    Message.Text = "<div class='alert alert-danger'>Error occurred while saving user.</div>";
                }
            }
            catch (Exception ex)
            {
                Message.Text = "<div class='alert alert-danger'>" + ex.Message + "</div>";
            }
        }
    }
}
