<%@ Page Title="" Language="C#" MasterPageFile="~/Home.Master" AutoEventWireup="true" CodeBehind="feedback.aspx.cs" Inherits="SarinasHandicraft.feedback" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="/Assets/css/feedback.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
     <div class="content">
         <div class="bs-example">
             <div class="row">
                 <div class="col-md-6">
                     <h2>My Feedback</h2>
                 </div>
                 <div class="col-md-6">
                     <span class="btn btn-sm btn-primary pull-right" data-toggle="modal" data-target="#feedbackAddModal"><i class="fa fa-plus"></i> Add Feedback</span>
                 </div>
             </div>
            <div class="accordion" id="accordionExample">
                <asp:Literal ID="Message" Text="" runat="server"></asp:Literal>
                <asp:DataList ID="FeedbackList" runat="server" Width="100%">  
                    <ItemTemplate>
                        <div class="card mb-2 shadow-sm">
                            <div class="card-header bg-light" id="heading_<%# Eval("Id") %>">
                                <div class="d-flex justify-content-between align-items-center">
                                    <div>
                                        <a class="btn btn-link p-0" <%# GetCollapseAttribute(Eval("Response_Message")) %> data-target="#collapse_<%# Eval("Id") %>">
                                            <%# GetCollapseIcon(Eval("Response_Message")) %>
                                            <strong><%# Eval("Subject") %></strong>
                                        </a>
                                    </div>
                                    <span class="badge <%# GetStatusClass(Eval("Status")) %>">
                                        <%# Eval("Status") %>
                                    </span>
                                </div>
                                <small class="text-muted"><%# Eval("Created_Date", "{0:dd MMM yyyy HH:mm}") %></small>
                            </div>

                            <asp:Literal ID="CollapseDiv" runat="server" Text='<%# GetCollapseDiv(Eval("Id"), Eval("Response_Message")) %>'></asp:Literal>
                        </div>
                    </ItemTemplate>
                </asp:DataList>
            </div>
        </div>
     </div>

    <!-- Add Feedback Modal -->
    <div class="modal fade" id="feedbackAddModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
      <div class="modal-dialog modal-dialog-centered" role="document">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title" id="addTitle">Add Feedback</h5>
            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
              <span aria-hidden="true">&times;</span>
            </button>
          </div>
          <div class="modal-body">
              <div class="form-group row">
                <label class="col-sm-4 col-form-label">Subject</label>
                <div class="col-sm-8">
                  <asp:TextBox ID="Subject" runat="server" class="form-control required" required="true"></asp:TextBox>
                </div>
              </div>

              <div class="form-group row">
                <label class="col-sm-4 col-form-label">Message</label>
                <div class="col-sm-8">
                  <asp:TextBox ID="FeedbackMessage" TextMode="MultiLine" runat="server" class="form-control required" required="true"></asp:TextBox>
                </div>
              </div>
          </div>
          <div class="modal-footer">
             <asp:Button ID="SaveItem" runat="server" CssClass="btn btn-primary" Text="Add" OnClick="Save_Feedback"/>
            <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
          </div>
        </div>
      </div>
    </div>
    <!-- Add Feedback Modal End -->

    <script type="text/javascript" src="/Assets/js/jquery-3.4.1.min.js"></script>
</asp:Content>
