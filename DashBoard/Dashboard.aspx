<%@ Page Title="" Language="C#" MasterPageFile="~/DashBoard/MasterDashboard.master" AutoEventWireup="true" CodeFile="Dashboard.aspx.cs" Inherits="DashBoard_Dashboard" %>

<%@ Register Assembly="System.Web.DataVisualization, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" Namespace="System.Web.UI.DataVisualization.Charting" TagPrefix="asp" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div>
        <p style="margin: 10px 15px;">
            Dashboard 
        </p>
    </div>
    <section class="no-padding-top no-padding-bottom">
        <div class="container-fluid">
            <div class="row">
                <div class="col">
                    <div class="statistic-block block">
                        <div class="progress-details d-flex align-items-end justify-content-between">
                            <div class="title">
                                <div class="icon">
                                    <asp:Image ID="imgIncome" ImageUrl="../DashBoardStyle/img/MoneyIN.png" CssClass="img-fluid rounded-circle" runat="server" />
                                </div>
                                <strong style="color: #3C7A89">Incomes</strong>
                            </div>
                            <div class="number dashtext-1">
                                <asp:Label ID="lblIncomeAmount" runat="server" Text="" Font-Size="28px"></asp:Label>
                            </div>
                        </div>
                        <%--<div class="progress progress-template">
                            <div role="progressbar" style="width: 30%" aria-valuenow="30" aria-valuemin="0" aria-valuemax="100" class="progress-bar progress-bar-template dashbg-1"></div>
                        </div>--%>
                    </div>
                </div>
                <div class="col">
                    <div class="statistic-block block">
                        <div class="progress-details d-flex align-items-end justify-content-between">
                            <div class="title">
                                <div class="icon">
                                    <asp:Image ID="Image1" ImageUrl="../DashBoardStyle/img/MoneyOUT.png" runat="server" />
                                </div>
                                <strong style="color: #BA1B1D">Expenses</strong>
                            </div>
                            <div class="number dashtext-2">
                                <asp:Label ID="lblExpenseAmount" runat="server" Text="" Font-Size="28px"></asp:Label>
                            </div>
                        </div>
                        <%--<div class="progress progress-template">
                            <div role="progressbar" style="width: 70%" aria-valuenow="70" aria-valuemin="0" aria-valuemax="100" class="progress-bar progress-bar-template dashbg-2"></div>
                        </div>--%>
                    </div>
                </div>
                <div class="col">
                    <div class="statistic-block block">
                        <div class="progress-details d-flex align-items-end justify-content-between">
                            <div class="title">
                                <div class="icon">
                                    <asp:Image ID="Image2" ImageUrl="../DashBoardStyle/img/Money.png" runat="server" />
                                </div>
                                <strong style="color: green;">Balance</strong>
                            </div>
                            <div class="number dashtext-3">
                                <asp:Label ID="lblBalanceAmount" runat="server" Text="" Font-Size="28px"></asp:Label>
                            </div>
                        </div>
                        <%--<div class="progress progress-template">
                            <div role="progressbar" style="width: 55%" aria-valuenow="55" aria-valuemin="0" aria-valuemax="100" class="progress-bar progress-bar-template dashbg-3"></div>
                        </div>--%>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <div class="col-lg-12">
        <div class="block">
            <div class="row">
                <div class="col">
                    <div class="bar-chart block chart">
                        <div class="title"><strong>Income Graph</strong></div>
                        <div class="bar-chart chart">
                            <asp:Chart ID="barChartCustom3" BackColor="34, 37, 42" runat="server" DataSourceID="SqlDataSource1">
                                <Series>
                                    <asp:Series Name="Series1" XValueMember="incomeDate" YValueMembers="incomeAmount"></asp:Series>
                                </Series>
                                <ChartAreas>
                                    <asp:ChartArea Name="ChartArea1" BackColor="#22252a"></asp:ChartArea>
                                </ChartAreas>
                            </asp:Chart>
                            <asp:SqlDataSource runat="server" ID="SqlDataSource1" ConnectionString='<%$ ConnectionStrings:ExpenseSystemConnectionString %>' SelectCommand="SELECT etsIncome.incomeAmount, etsIncome.incomeDate, etsExpense.expenseAmount, etsExpense.expenseDate FROM etsIncome CROSS JOIN etsExpense"></asp:SqlDataSource>
                        </div>

                    </div>
                </div>
                <div class="col">
                    <div class="bar-chart block chart">
                        <div class="title"><strong>Expense Graph</strong></div>
                        <div class="bar-chart chart">
                            <asp:Chart ID="Chart1" BackColor="#22252a" runat="server" DataSourceID="SqlDataSource1">
                                <Series>
                                    <asp:Series Name="Series1" XValueMember="expenseDate" YValueMembers="expenseAmount"></asp:Series>
                                </Series>
                                <ChartAreas>
                                    <asp:ChartArea Name="ChartArea1" BackColor="#22252a"></asp:ChartArea>
                                </ChartAreas>
                            </asp:Chart>
                            <asp:SqlDataSource runat="server" ID="SqlDataSource2" ConnectionString='<%$ ConnectionStrings:ExpenseSystemConnectionString %>' SelectCommand="SELECT * FROM [etsExpense]"></asp:SqlDataSource>
                        </div>
                    </div>
                </div>
            </div>


        </div>
    </div>
</asp:Content>
