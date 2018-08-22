<%@ Page Title="" Language="C#" MasterPageFile="~/DashBoard/MasterDashboard.master" AutoEventWireup="true" CodeFile="Report.aspx.cs" Inherits="DashBoard_Report" %>

<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="ajaxToolkit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:UpdatePanel ID="UpdateGridView" UpdateMode="Conditional" runat="server">
        <ContentTemplate>
            <div>
                <p style="margin: 10px 15px">
                    <a href="Dashboard.aspx">Dashboard </a>/ Report 
                </p>
            </div>
            <div class="col-lg-12">
                <div class="block">
                    <div class="row">
                        <div class="col-sm-1">
                            <asp:Label ID="Label1" runat="server" CssClass="form-control-label" Text="From"></asp:Label>
                        </div>
                        <div class="col-3">
                            <asp:TextBox onkeypress="return onlyDate(event)" ID="txtfrom" runat="server" CssClass="form-control"></asp:TextBox>
                            <ajaxToolkit:CalendarExtender ID="txtfrom_CalendarExtender" runat="server" TargetControlID="txtfrom" />
                        </div>
                        <div class="col-sm-1">
                            <asp:Label ID="Label2" runat="server" CssClass="form-control-label" Text="To"></asp:Label>
                        </div>
                        <div class="col-3">
                            <asp:TextBox onkeypress="return onlyDate(event)" ID="txtto" CssClass="form-control" runat="server"></asp:TextBox>
                            <ajaxToolkit:CalendarExtender ID="txtto_CalendarExtender" runat="server" TargetControlID="txtto" />
                        </div>
                        <div class="col">
                            <asp:Button ID="btnGenerate" CssClass="btn btn-primary" runat="server" Text="Generate" OnClick="btnGenerate_Click" />
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-lg-12">
                <div class="block">
                    <asp:GridView ID="gridReport" BorderWidth="0"
                        CssClass="table table-hover table-responsive-md table-fixed"
                        runat="server" AutoGenerateColumns="False" AllowPaging="True"
                        DataKeyNames="expenseId" EmptyDataText="No Data Found" OnPageIndexChanging="gridReport_PageIndexChanging">
                       <Columns>
                           <asp:TemplateField Visible="false">
                               <ItemTemplate>
                                   <%#Eval("expenseId") %>
                               </ItemTemplate>
                           </asp:TemplateField>
                           <asp:TemplateField HeaderText="SN">
                                <ItemTemplate>
                                    <%#Container.DataItemIndex +1 %>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Category">
                                <ItemTemplate>
                                    <%#Eval("expenseCatname") %>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Name">
                                <ItemTemplate>
                                    <%#Eval("expenseName") %>
                                </ItemTemplate>
                            </asp:TemplateField>
                           <asp:TemplateField HeaderText="Date Added">
                                <ItemTemplate>
                                    <%#Eval("expenseDate","{0:d}")%>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Amount">
                                <ItemTemplate>
                                    <%#Eval("expenseAmount")%>
                                </ItemTemplate>
                            </asp:TemplateField>                            
                            <asp:TemplateField HeaderText="Description">
                                <ItemTemplate>
                                    <%#Eval("expenseDescription")%>
                                </ItemTemplate>
                            </asp:TemplateField>
                       </Columns>
                   </asp:GridView>
                </div>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>

