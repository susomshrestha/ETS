<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ZZPIE.aspx.cs" Inherits="ZZPIE" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script src="d3.js"></script>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            
        </div>
    </form>
    <script>

        var data = [
    {"fruit": "apple", "count": 40}, 
    {"fruit": "banana", "count": 30},
    {"fruit": "orange", "count": 10},
    {"fruit": "grapes", "count": 20}
        ];
        d3.json("/data.json", function (error, data) {

            var myData = data.map(function (d) { return d.expenseAmount; });
            var Da = data.map(function (d) {
                return (eval(d.expenseDate.replace(/\/Date\((\d+)\)\//gi, "new Date($1)"))).toISOString().slice(0, 10);
            });

            var margin = { top: 20, right: 20, bottom: 20, left: 20 },
                        width = 500 - margin.right - margin.left,
                        height = 500 - margin.top - margin.bottom,
                        radius = width / 2;

            // color range
            var color = d3.scaleOrdinal()
                .range(["#BBDEFB", "#90CAF9", "#64B5F6", "#42A5F5", "#2196F3", "#1E88E5", "#1976D2"]);

            // pie chart arc. Need to create arcs before generating pie
            var arc = d3.arc()
                .outerRadius(radius - 10)
                .innerRadius((radius - 10) / 2);

            // arc for the labels position
            var labelArc = d3.arc()
                .outerRadius(radius - 40)
                .innerRadius(radius - 40);

            // generate pie chart and donut chart
            var pie = d3.pie()
                .sort(null)
                .value(function (d) { return d.expenseAmount; });

            // define the svg for pie chart
            var svg = d3.select("body").append("svg")
                .attr("width", width)
                .attr("height", height)
              .append("g")
                .attr("transform", "translate(" + width / 2 + "," + height / 2 + ")");


            // "g element is a container used to group other SVG elements"
            var g = svg.selectAll(".arc")
                .data(pie(data))
              .enter().append("g")
                .attr("class", "arc");

            // append path 
            g.append("path")
                .attr("d", arc)
                .style("fill", function (d) { return color(d.data.fruit); })
              // transition 
              .transition()
                .ease(d3.easeLinear)
                .duration(2000)
                .attrTween("d", tweenPie);

            // append text
            g.append("text")
              .transition()
                .ease(d3.easeLinear)
                .duration(2000)
              .attr("transform", function (d) { return "translate(" + labelArc.centroid(d) + ")"; })
                .attr("dy", ".35em")
                .text(function (d) { return d.data.fruit; });

            // Helper function for animation of pie chart and donut chart
            function tweenPie(b) {
                b.innerRadius = 0;
                var i = d3.interpolate({ startAngle: 0, endAngle: 0 }, b);
                return function (t) { return arc(i(t)); };
            }
        });
    </script>
</body>
</html>
