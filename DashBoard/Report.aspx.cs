using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class DashBoard_Report : System.Web.UI.Page
{
    int userid;
    BLLExpense ble = new BLLExpense();
    protected void Page_Load(object sender, EventArgs e)
    {
        if(!IsPostBack)
        {
            userid = (int)Session["UserId"];
        }
    }
    public void showExpense()
    {
        userid = (int)Session["UserId"];
        DateTime from = Convert.ToDateTime(txtfrom.Text);
        DateTime to = Convert.ToDateTime(txtto.Text);
        DateTime now = DateTime.Today;
        DataTable dt = ble.getExpenseByDateRange(userid,Convert.ToDateTime(from.ToShortDateString()),Convert.ToDateTime(to.ToShortDateString()),Convert.ToDateTime(now.ToShortDateString()));
        gridReport.DataSource = dt;
        gridReport.DataBind();
        UpdateGridView.Update();
    }

    protected void btnGenerate_Click(object sender, EventArgs e)
    {
        showExpense();
        gridReport.Columns[6].Visible = false;
        gridReport.Columns[2].Visible = false;
    }

    protected void gridReport_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gridReport.PageIndex = e.NewPageIndex;
        showExpense();
    }
}