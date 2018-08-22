using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class DashBoard_MasterDashboard : System.Web.UI.MasterPage
{
    BLLUser user = new BLLUser();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {            
            if (Session["UserId"] != null)
            {
                int userid = (int)Session["UserId"];
                DataTable dt = user.getUserInformation(userid);
                lblUserName.Text = Convert.ToString(dt.Rows[0]["FullName"]);
            }
            else
            {
                Response.Redirect("../LoginSignup/Login.aspx");
            }
        }
    }

    protected void btnLogout_Click(object sender, ImageClickEventArgs e)
    {
        Session.Abandon();
        Response.Redirect("../LoginSignup/Login.aspx");
    }
}
