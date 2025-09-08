using SarinasHandicraft.Dao;
using SarinasHandicraft.Dao.Impl;
using SarinasHandicraft.Models;
using SarinasHandicraft.Utils;
using System;
using System.Collections.Generic;
using System.Web.UI;

namespace SarinasHandicraft
{
    public partial class users : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindUserGrid();
            }
        }

        private void BindUserGrid()
        {
            UserDao userDao = new UserDaoImpl();
            List<User> userList = userDao.GetUsers();
            UserGridView.DataSource = userList;
            UserGridView.DataBind();
        }

        protected void Save_User(object sender, EventArgs e)
        {
            if (string.IsNullOrEmpty(addPassword.Text) || addPassword.Text.Length < 8)
            {
                Message.Text = "<div class='alert alert-danger'>Password must be at least 8 characters.</div>";
                return;
            }

            if (addPassword.Text != addConfirmPassword.Text)
            {
                Message.Text = "<div class='alert alert-danger'>Passwords do not match.</div>";
                return;
            }

            UserDao userDao = new UserDaoImpl();
            User existingUser = userDao.GetUserByUsername(addUsername.Text);
            if (existingUser != null)
            {
                Message.Text = "<div class='alert alert-danger'>Username already exists.</div>";
                return;
            }

            User user = new User
            {
                FirstName = addFirstName.Text,
                LastName = addLastName.Text,
                Username = addUsername.Text,
                Password = addPassword.Text,
                Gender = addGender.SelectedValue,
                Role = (RoleEnum)Enum.Parse(typeof(RoleEnum), addRole.SelectedValue),
                Status = (UserStatusEnum)Enum.Parse(typeof(UserStatusEnum), addStatus.SelectedValue)
            };

            if (userDao.SaveUser(user))
            {
                Message.Text = "<div class='alert alert-success'>User saved successfully.</div>";
                BindUserGrid();
            }
            else
            {
                Message.Text = "<div class='alert alert-danger'>Error occurred while saving user.</div>";
            }
        }

        protected void Update_User(object sender, EventArgs e)
        {
            int id = int.Parse(hiddenUserId.Value);
            UserDao userDao = new UserDaoImpl();
            User user = userDao.GetUserById(id);

            if (user == null)
            {
                Message.Text = "<div class='alert alert-danger'>User does not exist.</div>";
                return;
            }

            user.FirstName = editFirstName.Text;
            user.LastName = editLastName.Text;
            user.Gender = editGender.SelectedValue;
            user.Role = (RoleEnum)Enum.Parse(typeof(RoleEnum), editRole.SelectedValue);
            user.Status = (UserStatusEnum)Enum.Parse(typeof(UserStatusEnum), editStatus.SelectedValue);

            if (userDao.UpdateUser(user))
            {
                Message.Text = "<div class='alert alert-success'>User updated successfully.</div>";
                BindUserGrid();
            }
            else
            {
                Message.Text = "<div class='alert alert-danger'>Error occurred while updating user.</div>";
            }
        }

        protected void Delete_User(object sender, EventArgs e)
        {
            int id = int.Parse(deleteUserId.Value);
            UserDao userDao = new UserDaoImpl();
            User user = userDao.GetUserById(id);

            if (user == null)
            {
                Message.Text = "<div class='alert alert-danger'>User does not exist.</div>";
                return;
            }

            if (userDao.DeleteUser(id))
            {
                Message.Text = $"<div class='alert alert-success'>{user.Username} deleted successfully.</div>";
                BindUserGrid();
            }
            else
            {
                Message.Text = "<div class='alert alert-danger'>Error occurred while deleting user.</div>";
            }
        }
    }
}
