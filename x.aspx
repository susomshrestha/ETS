<%@ Page Language="C#" AutoEventWireup="true" CodeFile="x.aspx.cs" Inherits="x" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script src="DashBoardStyle/vendor/chart.js/Chart.js"></script>
    <script src="DashBoardStyle/vendor/jquery/jquery.min.js"></script>
    <link rel="stylesheet" href="//cdn.jsdelivr.net/chartist.js/latest/chartist.min.css" />
    <script src="//cdn.jsdelivr.net/chartist.js/latest/chartist.min.js"></script>
</head>
<body onload="firstLoad(); changeDate();">
    <form id="form1" runat="server">
    <%--<div>
        <div class="container">
		<canvas id="myChart" width="500" height="400">
			
		</canvas>
            <canvas id="pieChart" width="500" height="400">
			
		</canvas>
	</div>
    </div>--%>
        <div class="ct-chart ct-perfect-fourth">

        </div>
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
        
        new Chartist.Bar('.ct-chart', {
            labels: [expensename.join()],
            series: [expenseamount.join()]
        }, {
            distributeSeries: true
        });
        
		//function drawBarChart(expensename,expenseamount) {
		//    var myChart = document.getElementById('myChart').getContext('2d');

		//    var chart = new Chart(myChart, {
		//        type: 'bar',
		//        data: {
		//            labels: expensename,
		//            datasets: [{
		//                label: 'Amount',
		//                data: expenseamount,
		//                backgroundColor: 'red'
		//            }]
		//        },
		//        options: {
		//            responsive: false,
		//            title: {
		//                display: true,
		//                text: 'Expense Bar Chart',
		//                fontSize: 30
		//            },
		//            legend: {
		//                display: true,
		//                position: 'right',
		//                labels: {
		//                    fonsSize: 50
		//                }
		//            }
		//        }
		//    });
		//    chart.update();
		//}

		//function drawPieChart(expensename,expenseamount) {
		//    var PChart = document.getElementById('pieChart').getContext('2d');
		//    var options = {
		//        responsive: false,
		//        title: {
		//            display: true,
		//            position: "top",
		//            text: "Pie Chart",
		//            fontSize: 18,
		//            fontColor: "#111"
		//        },
		//        legend: {
		//            display: true,
		//            position: "right",
		//            labels: {
		//                fontColor: "#333",
		//                fontSize: 16
		//            }
		//        }
		//    };
		//    var data = {
		//        labels: expensename,
		//        datasets: [
        //            {
        //                label: "TeamA Score",
        //                data: expenseamount,
        //                backgroundColor: [
        //                    "#DEB887",
        //                    "#A9A9A9",
        //                    "#DC143C",
        //                    "#F4A460",
        //                    "#2E8B57"
        //                ],
        //                borderColor: [
        //                    "#CDA776",
        //                    "#989898",
        //                    "#CB252B",
        //                    "#E39371",
        //                    "#1D7A46"
        //                ],
        //                borderWidth: [1, 1, 1, 1, 1]
        //            }
		//        ]
		//    };

		//    var myPieChart = new Chart(PChart, {
		//        type: 'line',
		//        data: data,
		//        options: options
		//    });
		//    myPieChart.update();
		//}

		//drawBarChart(expensename, expenseamount);
		//drawPieChart(expensename, expenseamount);
		
	</script>
</body>
</html>
