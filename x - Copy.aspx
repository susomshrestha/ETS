<%@ Page Language="C#" AutoEventWireup="true" CodeFile="x - Copy.aspx.cs" Inherits="x" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script src="DashBoardStyle/vendor/chart.js/Chart.js"></script>
    <script src="DashBoardStyle/vendor/jquery/jquery.min.js"></script>

    <link rel="stylesheet" href="//cdnjs.cloudflare.com/ajax/libs/morris.js/0.5.1/morris.css"/>
    <script src="//ajax.googleapis.com/ajax/libs/jquery/1.9.0/jquery.min.js"></script>
    <script src="//cdnjs.cloudflare.com/ajax/libs/raphael/2.1.0/raphael-min.js"></script>
    <script src="//cdnjs.cloudflare.com/ajax/libs/morris.js/0.5.1/morris.min.js"></script>

</head>
<body onload="firstLoad(); changeDate();">
    <form id="form1" runat="server">
        <div id="myfirstchart" style="height: 250px;"></div>
    </form>

    <script type="text/javascript">
        var jsonarray = new Array();
        var expensename = new Array();
        var expenseamount = new Array();
        function loadArray() {
            $.getJSON('data.json', function (data) {
                jsonarray = data;
            });
        };

        function changeDate() {
            for (var i = 0; i < jsonarray.length; i++) {
                ((i) => {
                    date = eval(jsonarray[i].expenseDate.replace(/\/Date\((\d+)\)\//gi, "new Date($1)"));
                    jsonarray[i].expenseDate = date;
                })(i);
            }
        };

        function firstLoad() {
            for (var i = 0; i < jsonarray.length; i++) {
                ((i) => {
                    expensename[i] = jsonarray[i].expenseName;
                    expenseamount[i] = [jsonarray[i].expenseAmount];
                })(i);
            }
        };
        loadArray();

        new Morris.Bar({
            element: 'myfirstchart',
            data: [
              jsonarray
            ],
            xkey: 'expenseAmount',
            ykeys: ['expenseName', 'expenseId'],
            labels: ['Series A', 'Series B']
        });

    </script>
</body>
</html>
