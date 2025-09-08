using SarinasHandicraft.Dao;
using SarinasHandicraft.Dao.Impl;
using SarinasHandicraft.Models;
using SarinasHandicraft.Utils;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SarinasHandicraft
{
    public partial class feedbacks : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                FeedbackDao feedbackDao = new FeedbackDaoImpl();
                FeedbackGridView.DataSource = feedbackDao.getFeedbacks();
                FeedbackGridView.DataBind();
            }
        }

        protected void Response_Feedback(object sender, EventArgs e)
        {
            if(ResponseMessageText.Text.Trim() == "") 
            {
                Message.Text = "<div class='alert alert-danger'>Please enter the message.</div>";
                return;
            }
            FeedbackDao feedbackDao = new FeedbackDaoImpl();
            Feedback feedback = feedbackDao.getFeedbackById(int.Parse(hiddenFeedbackId.Value));
            if (feedback == null)
            {
                Message.Text = "<div class='alert alert-danger'>Feedback doesnot exist.</div>";
                return;
            }
            feedback.Response_Message = ResponseMessageText.Text;
            feedback.Response_Date = DateTime.Now;
            feedback.status = FeedbackStatusEnum.RESPOND;
            feedbackDao = new FeedbackDaoImpl();
            if (feedbackDao.UpdateFeedback(feedback))
            {
                Message.Text = "<div class='alert alert-success'>Feedback has been responded.</div>";
                feedbackDao = new FeedbackDaoImpl();
                FeedbackGridView.DataSource = feedbackDao.getFeedbacks();
                FeedbackGridView.DataBind();
                return;
            }
            else
            {
                Message.Text = "<div class='alert alert-danger'>Error occured while responding to feedback.</div>";
                return;
            }

        }
        protected void Update_Status(object sender, EventArgs e)
        {
            FeedbackDao feedbackDao = new FeedbackDaoImpl();
            Feedback feedback = feedbackDao.getFeedbackById(int.Parse(HiddenId.Value));
            if (feedback == null)
            {
                Message.Text = "<div class='alert alert-danger'>Feedback doesnot exist.</div>";
                return;
            }
            feedback.status = FeedbackStatusEnum.SOLVED;
            if (feedbackDao.UpdateFeedback(feedback))
            {
                Message.Text = "<div class='alert alert-success'>Status has been updated.</div>";
                feedbackDao = new FeedbackDaoImpl();
                FeedbackGridView.DataSource = feedbackDao.getFeedbacks();
                FeedbackGridView.DataBind();
                return;
            }
            else
            {
                Message.Text = "<div class='alert alert-danger'>Error occured while updateing status.</div>";
                return;
            }

        }
            
    }
}