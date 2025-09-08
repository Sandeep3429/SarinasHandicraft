using Newtonsoft.Json;
using SarinasHandicraft.Dao;
using SarinasHandicraft.Dao.Impl;
using SarinasHandicraft.Models;
using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SarinasHandicraft
{
    public partial class feedback : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserId"] != null)
            {
                int userId = int.Parse(Session["UserId"].ToString());
                if (!IsPostBack)
                {
                    BindFeedbackList(userId);
                }

                CartDao cartDao = new CartDaoImpl();
                List<Cart> carts = cartDao.GetUserCarts(userId);
                ((Label)Page.Master.FindControl("CartCount")).Text = carts.Count.ToString();
            }
        }

        protected void Save_Feedback(object sender, EventArgs e)
        {
            int userId = int.Parse(Session["UserId"].ToString());
            Feedback feedback = new Feedback
            {
                User_Id = userId,
                Subject = Subject.Text,
                Message = FeedbackMessage.Text
            };

            FeedbackDao feedbackDao = new FeedbackDaoImpl();
            if (feedbackDao.SaveFeedback(feedback))
            {
                Message.Text = "<div class='alert alert-success'>Feedback has been sent.</div>";
                BindFeedbackList(userId);
            }
            else
            {
                Message.Text = "<div class='alert alert-danger'>Feedback cannot be sent. Please try again later.</div>";
            }
        }

        private void BindFeedbackList(int userId)
        {
            FeedbackDao feedbackDao = new FeedbackDaoImpl();
            List<Feedback> feedbacks = feedbackDao.getUserFeedback(userId);
            FeedbackList.DataSource = feedbacks;
            FeedbackList.DataBind();
        }

        // Helper methods for DataList binding
        protected string GetCollapseAttribute(object responseMessage)
        {
            if (responseMessage != null && !string.IsNullOrEmpty(responseMessage.ToString()))
                return "data-toggle='collapse'";
            return "";
        }

        protected string GetCollapseIcon(object responseMessage)
        {
            if (responseMessage != null && !string.IsNullOrEmpty(responseMessage.ToString()))
                return "<i class='fa fa-plus mr-2'></i>";
            return "";
        }

        protected string GetStatusClass(object status)
        {
            if (status != null)
            {
                string s = status.ToString();
                if (s == "ISSUED") return "badge-primary";
                if (s == "SOLVED") return "badge-success";
                return "badge-warning";
            }
            return "badge-secondary";
        }

        protected string GetCollapseDiv(object id, object responseMessage)
        {
            if (responseMessage != null && !string.IsNullOrEmpty(responseMessage.ToString()))
            {
                return $"<div id='collapse_{id}' class='collapse' data-parent='#accordionExample'><div class='card-body'><p>{responseMessage}</p></div></div>";
            }
            return "";
        }
    }
}
