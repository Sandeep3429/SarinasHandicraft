using SarinasHandicraft.Dao;
using SarinasHandicraft.Dao.Impl;
using SarinasHandicraft.Models;
using SarinasHandicraft.Utils;
using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Web.UI;

namespace SarinasHandicraft
{
    public partial class category1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindCategoryGrid();
            }
        }

        private void BindCategoryGrid()
        {
            CategoryDao categoryDao = new CategoryDaoImpl();
            List<Category> categoryList = categoryDao.GetActiveCategories();
            CategoryGridView.DataSource = categoryList;
            CategoryGridView.DataBind();
        }

        protected void Save_Category(object sender, EventArgs e)
        {
            CategoryDao categoryDao = new CategoryDaoImpl();
            Category previousCategory = categoryDao.GetCategoryByName(addName.Text);

            // Check if category exists and is not deleted
            if (previousCategory != null && previousCategory.Status != UserStatusEnum.DELETE)
            {
                Message.Text = "<div class='alert alert-danger'>Category already exists.</div>";
                return;
            }

            Category category = new Category
            {
                Name = addName.Text,
                Status = (UserStatusEnum)Enum.Parse(typeof(UserStatusEnum), addStatus.Text)
            };

            if (categoryDao.SaveCategory(category))
            {
                Message.Text = "<div class='alert alert-success'>Category Saved Successfully.</div>";
                BindCategoryGrid();
                addName.Text = string.Empty; // clear input
                addStatus.SelectedIndex = 0;
            }
            else
            {
                Message.Text = "<div class='alert alert-danger'>Error occurred while saving category.</div>";
            }
        }

        protected void Update_Category(object sender, EventArgs e)
        {
            int id = int.Parse(hiddenCategoryId.Value);
            CategoryDao categoryDao = new CategoryDaoImpl();
            Category category = categoryDao.GetCategoryById(id);

            if (category == null)
            {
                Message.Text = "<div class='alert alert-danger'>Category does not exist.</div>";
                return;
            }

            // Check duplicate by name excluding current category
            Category duplicate = categoryDao.GetCategoryByName(editName.Text);
            if (duplicate != null && duplicate.Id != category.Id && duplicate.Status != UserStatusEnum.DELETE)
            {
                Message.Text = "<div class='alert alert-danger'>Category name is already used.</div>";
                return;
            }

            category.Name = editName.Text;
            category.Status = (UserStatusEnum)Enum.Parse(typeof(UserStatusEnum), editStatus.Text);

            if (categoryDao.UpdateCategory(category))
            {
                Message.Text = "<div class='alert alert-success'>Category Updated Successfully.</div>";
                BindCategoryGrid();
            }
            else
            {
                Message.Text = "<div class='alert alert-danger'>Error occurred while updating category.</div>";
            }
        }

        protected void Delete_Category(object sender, EventArgs e)
        {
            int id = int.Parse(deleteCategoryId.Value);
            CategoryDao categoryDao = new CategoryDaoImpl();
            Category category = categoryDao.GetCategoryById(id);

            if (category == null)
            {
                Message.Text = "<div class='alert alert-danger'>Category does not exist.</div>";
                return;
            }

            if (categoryDao.DeleteCategory(id))
            {
                Message.Text = $"<div class='alert alert-success'>{category.Name} category has been deleted successfully.</div>";
                BindCategoryGrid();
            }
            else
            {
                Message.Text = "<div class='alert alert-danger'>Error occurred while deleting category.</div>";
            }
        }
    }
}
