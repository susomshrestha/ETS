using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class DashBoard_Expenses : System.Web.UI.Page
{
    int userid;
    BLLCategory blc = new BLLCategory();
    BLLExpense ble = new BLLExpense();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {

            userid = (int)Session["UserId"];
            showDDL();
            txtDate.Text = DateTime.Today.ToShortDateString();
            if (ble.GetAllExpense(userid) != null)
            {
                showExpense();
            }
            else
            {

            }
        }

    }
    public void showDDL()
    {
        userid = (int)Session["UserId"];
        DataTable dt = blc.GetAllExpenseCategory(userid);
        ddlCateogory.DataSource = dt;       
        ddlCateogory.DataTextField = "ExpenseCatname";
        ddlCateogory.DataValueField = "ExpenseCatid";
        ddlCateogory.DataBind();
        ddlCateogory.Items.Insert(0, "Choose any");

    }
    public void showExpense()
    {
        userid = (int)Session["UserId"];
        DataTable dt = ble.GetAllExpense(userid);
        GridView1.DataSource = dt;
        GridView1.DataBind();
        UpdateGridView.Update();
    }
    public void clearInput()
    {
        txtAmount.Text = string.Empty;
        txtName.Text = string.Empty;
        txtDescription.Text = string.Empty;
        txtDate.Text = DateTime.Today.ToShortDateString();
        ddlCateogory.SelectedIndex = 0;
    }

    protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        GridView1.PageIndex = e.NewPageIndex;
        showExpense();
    }

    protected void btnAdd_Click(object sender, EventArgs e)
    {
        userid = (int)Session["UserId"];
        DateTime d = Convert.ToDateTime(txtDate.Text);
        String desc = txtDescription.Text.ToString();
        int i = ble.InsertExpense(Convert.ToInt32(ddlCateogory.SelectedValue.ToString()), 1, txtName.Text, Convert.ToDecimal(txtAmount.Text),
            Convert.ToDateTime(d.ToShortDateString()), txtDescription.Text, userid);
        if (i > 0)
        {
            ClientScript.RegisterStartupScript(GetType(), "alert", "alert('Expense Added');", true);
            showExpense();
            clearInput();
        }
    }
    protected void ibtnEdit_Click(object sender, ImageClickEventArgs e)
    {
        GridViewRow gvRow = (GridViewRow)((ImageButton)sender).NamingContainer;
        Int32 expenseId = Convert.ToInt32(GridView1.DataKeys[gvRow.RowIndex].Value);
        

        DataTable dtbl = ble.GetExpenseByExpenseId(expenseId);
        showPopupCategory();
        hfUserID.Value = dtbl.Rows[0]["expenseId"].ToString();
        ddleditCategory.SelectedValue = dtbl.Rows[0]["ExpenseCatid"].ToString();
        txteditName.Text = dtbl.Rows[0]["expenseName"].ToString();
        txteditAmount.Text = dtbl.Rows[0]["expenseAmount"].ToString();
        txteditDate.Text = Convert.ToDateTime(dtbl.Rows[0]["expenseDate"]).ToShortDateString();
        txteditDescription.Text = dtbl.Rows[0]["expenseDescription"].ToString();
        
        EditPopup.Show();
        
    }
    public void showPopupCategory()
    {
        userid = (int)Session["UserId"];
        DataTable dt = blc.GetAllExpenseCategory(userid);
        ddleditCategory.DataSource = dt;
        ddleditCategory.DataTextField = "expenseCatname";
        ddleditCategory.DataValueField = "expenseCatid";
        ddleditCategory.DataBind();
    }
    
    protected void btnSave_Click(object sender, EventArgs e)
    {
        DateTime d = Convert.ToDateTime(txteditDate.Text);
        String desc = txteditDescription.Text.ToString();
        int i = ble.UpdateExpense(Convert.ToInt32(ddleditCategory.SelectedValue.ToString()),
            txteditName.Text, Convert.ToDecimal(txteditAmount.Text),
            Convert.ToDateTime(d.ToShortDateString()), txteditDescription.Text, Convert.ToInt32(hfUserID.Value.ToString()));
        if (i > 0)
        {
            ClientScript.RegisterStartupScript(GetType(), "alert", "alert('Expense Edited');", true);
            showExpense();
            clearInput();
        }
    }

    protected void ibtnDelete_Click(object sender, ImageClickEventArgs e)
    {
        GridViewRow gvRow = (GridViewRow)((ImageButton)sender).NamingContainer;
        Int32 expenseId = Convert.ToInt32(GridView1.DataKeys[gvRow.RowIndex].Value);
        int i = ble.DeleteExpense(expenseId);
        if (i>0)
        {
            ClientScript.RegisterStartupScript(GetType(), "alert", "alert('Expense Deleted');", true);
            showExpense();
        }
    }

}