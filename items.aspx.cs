using SarinasHandicraft.Dao;
using SarinasHandicraft.Dao.Impl;
using SarinasHandicraft.Models;
using SarinasHandicraft.Utils;
using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.IO;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SarinasHandicraft
{
    public partial class items : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindGrid();
                BindCategories();
            }
        }

        private void BindGrid()
        {
            ItemDao itemDao = new ItemDaoImpl();
            ItemGridView.DataSource = itemDao.GetItems();
            ItemGridView.DataBind();
        }

        private void BindCategories()
        {
            CategoryDao categoryDao = new CategoryDaoImpl();
            List<Category> activeCategory = categoryDao.GetActiveCategories();

            addCategoryId.DataSource = activeCategory;
            addCategoryId.DataTextField = "Name";
            addCategoryId.DataValueField = "Id";
            addCategoryId.DataBind();

            editCategoryId.DataSource = activeCategory;
            editCategoryId.DataTextField = "Name";
            editCategoryId.DataValueField = "Id";
            editCategoryId.DataBind();
        }

        protected void Save_Item(object sender, EventArgs e)
        {
            ItemDao itemDao = new ItemDaoImpl();
            Item previousItem = itemDao.GetItemByCode(addCode.Text);
            if (previousItem != null)
            {
                Message.Text = "<div class='alert alert-danger'>Item code already exists.</div>";
                return;
            }

            Item item = new Item
            {
                Name = addItemName.Text,
                Description = addDescription.Text,
                Code = addCode.Text,
                Quantity = int.Parse(addQuantity.Text),
                Price = float.Parse(addPrice.Text),
                Category_Id = int.Parse(addCategoryId.SelectedValue),
                Status = StatusEnum.ACTIVE,
                Image = Upload_File(AddImageUpload)
            };

            if (item.Image == null)
            {
                Message.Text = "<div class='alert alert-danger'>Error uploading image.</div>";
                return;
            }

            if (itemDao.SaveItem(item))
            {
                Message.Text = "<div class='alert alert-success'>Item Saved Successfully.</div>";
                BindGrid();
            }
            else
            {
                Message.Text = "<div class='alert alert-danger'>Error occurred while saving item.</div>";
            }
        }

        protected void Update_Item(object sender, EventArgs e)
        {
            int id = int.Parse(hiddenItemId.Value);
            ItemDao itemDao = new ItemDaoImpl();
            Item item = itemDao.GetItemById(id);
            if (item == null)
            {
                Message.Text = "<div class='alert alert-danger'>Item does not exist.</div>";
                return;
            }

            item.Name = editItemName.Text;
            item.Description = editDescription.Text;
            item.Code = editCode.Text;
            item.Price = float.Parse(editPrice.Text);
            item.Quantity = int.Parse(editQuantity.Text);
            item.Category_Id = int.Parse(editCategoryId.SelectedValue);
            item.Status = (StatusEnum)Enum.Parse(typeof(StatusEnum), editStatus.SelectedValue);

            if (editImageUpload.HasFile)
            {
                item.Image = Upload_File(editImageUpload);
            }

            if (itemDao.checkDupliateCode(item))
            {
                Message.Text = "<div class='alert alert-danger'>Item code is already in use.</div>";
                return;
            }

            if (itemDao.UpdateItem(item))
            {
                Message.Text = "<div class='alert alert-success'>Item updated successfully.</div>";
                BindGrid();
                ScriptManager.RegisterStartupScript(this, GetType(), "closeModal", "$('#itemUpdateModal').modal('hide');", true);
            }
            else
            {
                Message.Text = "<div class='alert alert-danger'>Error occurred while updating item.</div>";
            }
        }

        protected void Delete_Item(object sender, EventArgs e)
        {
            int id = int.Parse(deleteItemId.Value);
            ItemDao itemDao = new ItemDaoImpl();
            Item item = itemDao.GetItemById(id);
            if (item == null)
            {
                Message.Text = "<div class='alert alert-danger'>Item does not exist.</div>";
                return;
            }

            if (itemDao.DeleteItem(id))
            {
                Message.Text = $"<div class='alert alert-success'>{item.Name} item has been deleted successfully.</div>";
                BindGrid();
            }
            else
            {
                Message.Text = "<div class='alert alert-danger'>Error occurred while deleting item.</div>";
            }
        }

        protected string Upload_File(FileUpload uploadControl)
        {
            try
            {
                if (!uploadControl.HasFile) return null;

                string folderPath = Server.MapPath("~/Uploads/");
                if (!Directory.Exists(folderPath))
                    Directory.CreateDirectory(folderPath);

                string fileName = Path.GetFileName(uploadControl.FileName);
                uploadControl.SaveAs(folderPath + fileName);
                return "~/Uploads/" + fileName;
            }
            catch (Exception exp)
            {
                Debug.WriteLine(exp.Message);
                return null;
            }
        }
    }
}
