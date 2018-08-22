using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.UI;
using System.Web.UI.WebControls;


public partial class ZZZZ : System.Web.UI.Page
{
    BLLExpense ble = new BLLExpense();
    protected void Page_Load(object sender, EventArgs e)
    {
        DataTable dt = new DataTable();
        dt = ble.GetAllExpense(12);
        string json = DataTableToJSONWithJavaScriptSerializer(dt);
        TextBox1.Text = json;
        WriteTextAsync(json);
    }

    static async void WriteTextAsync(string text)
    {
        // Set a variable to the My Documents path.
        string mydocpath = Environment.GetFolderPath(Environment.SpecialFolder.MyDocuments);

        // Write the text asynchronously to a new file named "WriteTextAsync.txt".
        using (StreamWriter outputFile = new StreamWriter(Path.Combine(mydocpath, "WriteTextAsync.txt")))
        {
            await outputFile.WriteAsync(text);
        }
    }

    public string DataTableToJSONWithJavaScriptSerializer(DataTable table)
    {
        JavaScriptSerializer jsSerializer = new JavaScriptSerializer();
        List<Dictionary<string, object>> parentRow = new List<Dictionary<string, object>>();
        Dictionary<string, object> childRow;
        foreach (DataRow row in table.Rows)
        {
            childRow = new Dictionary<string, object>();
            foreach (DataColumn col in table.Columns)
            {
                childRow.Add(col.ColumnName, row[col]);
            }
            parentRow.Add(childRow);
        }
        return jsSerializer.Serialize(parentRow);
    }
}