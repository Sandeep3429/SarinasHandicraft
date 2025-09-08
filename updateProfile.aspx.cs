using SarinasHandicraft.Dao;
using SarinasHandicraft.Dao.Impl;
using SarinasHandicraft.Models;
using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SarinasHandicraft
{
    public partial class updateProfile : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            int userId = int.Parse(Session["userId"].ToString());
            if (!IsPostBack)
            {
                UserDao userDao = new UserDaoImpl();
                User user = userDao.GetUserById(userId);
                FirstName.Text = user.FirstName;
                LastName.Text = user.LastName;
                Mobile.Text = user.Mobile;
                Gender.SelectedValue = user.Gender;
                Address.Text = user.Address;
                ImageUrl.ImageUrl = user.Image == "" ? "/Uploads/User/avatar7.png" : user.Image;
            }

            CartDao cartDao = new CartDaoImpl();
            List<Cart> carts = cartDao.GetUserCarts(userId);
            Debug.WriteLine(carts.Count);
            ((Label)Page.Master.FindControl("CartCount")).Text = carts.Count().ToString();
        }

        protected void Update_Profile(object sender, EventArgs e)
        {
            int userId = int.Parse(Session["userId"].ToString());
            UserDao userDao = new UserDaoImpl();
            User user = userDao.GetUserById(userId);
            if (user == null)
            {
                Message.Text = "<div class='alert alert-danger'>User doesnot exist.</div>";
                return;
            }
            user.Id = userId;
            user.FirstName = FirstName.Text;
            user.LastName = LastName.Text;
            user.Gender = Gender.SelectedValue;
            user.Mobile = Mobile.Text;
            user.Address = Address.Text;
            if (ProfileImage.FileName != "")
            {
                string ImageUrl = this.Upload_File(ProfileImage.FileName);
                user.Image = ImageUrl;
            }
            userDao = new UserDaoImpl();
            if (userDao.UpdateUser(user))
            {
                Message.Text = "<div class='alert alert-success'>Profile has been updated successfully.</div>";
                FirstName.Text = user.FirstName;
                LastName.Text = user.LastName;
                Mobile.Text = user.Mobile;
                Gender.SelectedValue = user.Gender;
                Address.Text = user.Address;
                ImageUrl.ImageUrl = user.Image == "" ? "/Uploads/User/avatar7.png" : user.Image;
                Response.Redirect("profile.aspx");
            }
            else
            {
                Message.Text = "<div class='alert alert-danger'>Error occured while updating Profile.</div>";
            }
        }

        protected string Upload_File(string fileName)
        {
            Debug.WriteLine("upload start");
            try
            {
                string path = "/Uploads/User";
                string folderPath = Server.MapPath(path);
                Debug.WriteLine(folderPath);
                //Check whether Directory (Folder) exists.
                if (!Directory.Exists(folderPath))
                {
                    //If Directory (Folder) does not exists Create it.
                    Directory.CreateDirectory(folderPath);
                }

                //Save the File to the Directory (Folder).
                Path.GetFileName(fileName);
                ProfileImage.SaveAs(folderPath + Path.GetFileName(fileName));
                Debug.WriteLine("Save files");
                return path + Path.GetFileName(fileName);
            }
            catch (Exception exp)
            {
                Debug.WriteLine(exp.Message);
            }
            return null;
        }
    }
}