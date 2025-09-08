<%@ Page Title="" Language="C#" MasterPageFile="~/Dashboard.Master" AutoEventWireup="true" CodeBehind="feedbackList.aspx.cs" Inherits="SarinasHandicraft.feedbacks" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="content">
        <div class="row">
            <div class="col-md-12">
            <div class="card">
                <div class="card-header row">
                    <div class="col-md-6">
                        <h4 class="card-title"> Feedback List</h4>
                     </div>
                    <div class="col-md-6">
                    </div>
                </div>
                <div class="card-body">
                <div class="table-responsive">
                    <asp:Literal ID="Message" Text="" runat="server"></asp:Literal>
                    <asp:GridView ID="FeedbackGridView" runat="server" class="table" AutoGenerateColumns="False" CellPadding="4" ForeColor="#51cbce" GridLines="None">
                            <Columns>
                                <asp:BoundField DataField="id" HeaderText="Id" InsertVisible="False" ReadOnly="True" SortExpression="id" />
                                <asp:BoundField DataField="name" HeaderText="Name" SortExpression="Name" />
                                <asp:BoundField DataField="created_date" HeaderText="Issue Date" SortExpression="status" />
                                <asp:BoundField DataField="subject" HeaderText="Subject" SortExpression="status" />
                                <asp:BoundField DataField="message" HeaderText="Message" SortExpression="status" />
                                <asp:BoundField DataField="status" HeaderText="Status" SortExpression="status" />
                                <asp:TemplateField HeaderText="Action">
                                    <ItemTemplate> 
                                        <asp:LinkButton Text='View' ID="Id" class="btn btn-sm btn-success" data-toggle="modal" data-target="#viewFeedbackModal" runat="server"
                                            data-id='<%# DataBinder.Eval(Container.DataItem, "Id") %>' 
                                            data-name='<%# DataBinder.Eval(Container.DataItem, "Name") %>'
                                            data-status='<%# DataBinder.Eval(Container.DataItem, "Status") %>'
                                            data-subject='<%# DataBinder.Eval(Container.DataItem, "Subject") %>'
                                            data-message='<%# DataBinder.Eval(Container.DataItem, "Message") %>'
                                            data-createdDate='<%# DataBinder.Eval(Container.DataItem, "created_date") %>'
                                            data-responsemessage='<%# DataBinder.Eval(Container.DataItem, "Response_Message") %>'
                                            data-responsedate='<%# DataBinder.Eval(Container.DataItem, "Response_Date") %>'
                                            /> 
                                        
                                        <asp:LinkButton Text='Mark as Solved' ID="LinkButton1" class="btn btn-sm btn-danger" data-toggle="modal" data-target="#updateFeedbackModal" runat="server"
                                            Visible='<%# (Eval("Status").ToString() == "SOLVED")? false: true %>'
                                            data-id='<%# DataBinder.Eval(Container.DataItem, "Id") %>'
                                            data-subject='<%# DataBinder.Eval(Container.DataItem, "Subject") %>'
                                            data-name='<%# DataBinder.Eval(Container.DataItem, "Name") %>'/> 
                                    </ItemTemplate> 
                                </asp:TemplateField>
                            </Columns>
                            <AlternatingRowStyle BackColor="White" />
                            <FooterStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
                            <HeaderStyle BackColor="#FFFFFF" Font-Bold="True" ForeColor="#51cbce" />
                            <PagerStyle BackColor="#FFCC66" ForeColor="#333333" HorizontalAlign="Center" />
                            <RowStyle BackColor="White" ForeColor="#333333" />
                            <SelectedRowStyle BackColor="#FFCC66" Font-Bold="True" ForeColor="Navy" />
                            <SortedAscendingCellStyle BackColor="#FDF5AC" />
                            <SortedAscendingHeaderStyle BackColor="#4D0000" />
                            <SortedDescendingCellStyle BackColor="#FCF6C0" />
                            <SortedDescendingHeaderStyle BackColor="#820000" />
                        </asp:GridView>
                    </div>
                </div>
            </div>
            </div>
        </div>
    </div>

    <!-- Modal View Feedback-->
    <div class="modal fade" id="viewFeedbackModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
      <div class="modal-dialog modal-dialog-centered" role="document">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title" id="title">View Feedback</h5>
            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
              <span aria-hidden="true">&times;</span>
            </button>
          </div>
          <div class="modal-body">
              <div class="form-group row">
                <label class="col-sm-4 col-form-label">Name</label>
                <div class="col-sm-8">
                    <asp:Label ID="Name" runat="server"></asp:Label>
                    <asp:HiddenField ID="hiddenFeedbackId" runat="server"/>
                </div>
              </div>
              <div class="form-group row">
                <label class="col-sm-4 col-form-label">Created Date</label>
                <div class="col-sm-8">
                    <asp:Label ID="CreatedDate" runat="server"></asp:Label>
                </div>
              </div>
              <div class="form-group row">
                <label class="col-sm-4 col-form-label">Subject</label>
                <div class="col-sm-8">
                    <asp:Label ID="Subject" runat="server"></asp:Label>
                </div>
              </div>
              <div class="form-group row">
                <label class="col-sm-4 col-form-label">Message</label>
                <div class="col-sm-8">
                    <asp:Label ID="FeedbackMessage" runat="server"></asp:Label>
                </div>
              </div>

              <div class="form-group row">
                <label class="col-sm-4 col-form-label">Status</label>
                <div class="col-sm-8">
                    <asp:Label ID="Status" runat="server"></asp:Label>
                </div>
              </div>
              <div class="form-group row">
                <label class="col-sm-4 col-form-label">Response Message</label>
                <div class="col-sm-8">
                    <asp:Label ID="ResponseMessage" runat="server"></asp:Label>
                    <asp:TextBox ID="ResponseMessageText" runat="server" TextMode="MultiLine" CssClass="form-control required"></asp:TextBox>
                </div>
              </div>
              <div class="form-group row feedbackDate">
                <label class="col-sm-4 col-form-label">Response Date</label>
                <div class="col-sm-8">
                    <asp:Label ID="ResponseDate" runat="server"></asp:Label>
                </div>
              </div>
          </div>
          <div class="modal-footer">
             <asp:Button ID="ViewCategory" runat="server" CssClass="btn btn-primary" Text="Reply" OnClick ="Response_Feedback"/>
             <asp:Button ID="UpdateCategory" runat="server" CssClass="btn btn-primary" Text="Ok"/>
            <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
          </div>
        </div>
      </div>
    </div>
    <!--Update View Feedback Modal close-->

    <!-- Modal Update Feedback Status-->
    <div class="modal fade" id="updateFeedbackModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
      <div class="modal-dialog modal-dialog-centered" role="document">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title" id="updateFeedback">Solved Feedback</h5>
            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
              <span aria-hidden="true">&times;</span>
            </button>
          </div>
          <div class="modal-body">
              <asp:HiddenField ID="HiddenId" runat="server"/>
              Do you want to make <asp:Label runat="server" ID="FeedbackId" CssClass="font-weight-bold"></asp:Label> feedback as solved?
          </div>
          <div class="modal-footer">
             <asp:Button ID="Button2" runat="server" CssClass="btn btn-primary" Text="Make Solved" OnClick="Update_Status"/>
            <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
          </div>
        </div>
      </div>
    </div>
    <!--Update Feedback Status Modal close-->

    <script type="text/javascript" src="/Assets/js/jquery-3.4.1.min.js"></script>
    <script>
        $(function () {
            $('#viewFeedbackModal').on('shown.bs.modal', function (e) {
                var button = $(e.relatedTarget);
                var id = button.attr('data-id');
                var name = button.attr('data-name');
                var createdDate = button.attr('data-createdDate');
                var responseDate = button.attr('data-responseDate');
                var subject = button.attr('data-subject');
                var message = button.attr('data-message');
                var status = button.attr('data-status');
                $('#ContentPlaceHolder1_hiddenFeedbackId').val(id);
                $('#ContentPlaceHolder1_Name').html(name);
                $('#ContentPlaceHolder1_CreatedDate').html(createdDate);
                $('#ContentPlaceHolder1_Status').html(status);
                $('#ContentPlaceHolder1_Subject').html(subject);
                $('#ContentPlaceHolder1_FeedbackMessage').html(message);
                $('#ContentPlaceHolder1_ResponseMessage').html(message);
                if (status == "ISSUED") {
                    $('#ContentPlaceHolder1_ResponseMessageText').show();
                    $('#ContentPlaceHolder1_ViewCategory').show();
                    $('#ContentPlaceHolder1_UpdateCategory').hide();
                    $('.feedbackDate').hide();
                } else {
                    $('#ContentPlaceHolder1_ResponseMessageText').hide();
                    $('#ContentPlaceHolder1_ViewCategory').hide();
                    $('#ContentPlaceHolder1_UpdateCategory').show();
                    $('#ContentPlaceHolder1_ResponseDate').html(responseDate);
                    
                }
            });

            $('#updateFeedbackModal').on('shown.bs.modal', function (e) {
                var button = $(e.relatedTarget);
                var id = button.attr('data-id');
                var subject = button.attr('data-subject');
                $('#ContentPlaceHolder1_HiddenId').val(id);
                $('#ContentPlaceHolder1_FeedbackId').html(id+". "+subject);
            });
        });
    </script>
</asp:Content>
