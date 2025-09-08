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
    public partial class profile : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            int userId = int.Parse((string)Session["userId"]);
            UserDao userDao = new UserDaoImpl();
            User user = userDao.GetUserById(userId);
            FirstName.Text = user.FirstName;
            LastName.Text = user.LastName;
            Mobile.Text = user.Mobile;
            Gender.Text = user.Gender;
            CreatedDate.Text = user.CreatedDate.ToString();
            Role.Text = user.Role.ToString();
            ProfileImage.ImageUrl = user.Image == "" ? "/Uploads/User/avatar7.png" : user.Image;
            FullName.Text = user.FirstName + " " + user.LastName;
            Username.Text = user.Username;
            Address.Text = user.Address;

            CartDao cartDao = new CartDaoImpl();
            List<Cart> carts = cartDao.GetUserCarts(userId);
            Debug.WriteLine(carts.Count);
            ((Label)Page.Master.FindControl("CartCount")).Text = carts.Count().ToString();
        }
    }
}