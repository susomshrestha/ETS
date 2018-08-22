<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ZZZZ.aspx.cs" Inherits="ZZZZ" Async="true"  %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script src="http://d3js.org/d3.v3.min.js" charset="utf-8"></script>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <div id="chart"></div>
        </div>
        <asp:TextBox ID="TextBox1" TextMode="MultiLine" runat="server"></asp:TextBox>
    </form>
    <script>
        var myData = [10, 29, 45, 32, 19, 56, 70, 35, 87, 90, 100];
        //d3.json("databar.json", function(error, myData) {
        //    console.log(myData);
        //    myData.forEach(function(d) {
        //        d.expenseAmount = d.expenseAmount;
        //    });
        
        var margin = {
            top: 30,
            right: 30,
            bottom: 40,
            left:50
        }

        var height = 500 - margin.top - margin.bottom, width = 600 - margin.left - margin.right;
        //var barWidth = 30, barOffset = 20;

        var animationDelay = 30, animationDuration = 700;

        var yScale = d3.scale.linear()
                        .domain([0, d3.max(myData)])
                        .range([0, height]);

        var xScale = d3.scale.ordinal()
                        .domain(d3.range(0, myData.length))
                        .rangeBands([0, width])

        var colors = d3.scale.linear()
                        .domain([0, myData.length])
                        .range(['#f12345', '#123458']);

        var tooltip = d3.select('body').append('div')
                        .style('position', 'absolute')
                        .style('background', '#f4f4f4')
                        .style('padding', '5px 15px')
                        .style('border', '1px #333 solid')
                        .style('border-radius', '5px')
                        .style('opacity', '0')


        var mychart = d3.select('#chart').append('svg')
                    .attr('width', width + margin.right + margin.left).attr('height', height + margin.top + margin.bottom)
                    .append('g')
                    .attr('transform','translate('+margin.left+','+margin.top+')')
                    .style('background', '#f4f4f4')
                    .selectAll('rect')
                    .data(myData)
                    .enter().append('rect')
                        //.style('fill', 'lightgreen')
                        .style('fill', function (d, i) {
                            return colors(d);
                        })
                        .attr('width', xScale.rangeBand() - 5)
                        .attr('height', 0)
                        .attr('x', function (d, i) {
                            return xScale(i);
                        })
                        .attr('y', height)
                    .on('mouseover', function (d) {
                        tooltip.transition()
                            .style('opacity', 1)

                        tooltip.html(d)
                            .style('left', (d3.event.pageX) + 'px')
                            .style('top', (d3.event.pageY) + 'px')
                        d3.select(this).style('opacity', 0.5)
                    })
                    .on('mouseout', function (d) {
                        tooltip.transition()
                            .style('opacity', 0)
                        d3.select(this).style('opacity', 1)
                    })
        mychart.transition()
            .attr('height', function (d) {
                return yScale(d);
            })
            .attr('y', function (d) {
                return (height - yScale(d));
            })
            .duration(animationDuration)
            .delay(function (d, i) {
                return i * animationDelay;
            })
            .ease('elastic')

        var vScale = d3.scale.linear()
                        .domain([0, d3.max(myData)])
                        .range([height, 0]);

        var hScale = d3.scale.ordinal()
                        .domain(d3.range(0, myData.length))
                        .rangeBands([0, width])
        //Vertical axis
        var vAxis = d3.svg.axis()
                .scale(vScale)
                .orient('left')
                .ticks(5)
                .tickPadding(5)
        //Vertical guide
        var vGuide = d3.select('svg')
                    .append('g')
                    vAxis(vGuide)
                    vGuide.attr('transform', 'translate('+margin.left+','+margin.top+')')
                    vGuide.selectAll('path')
                        .style('fill', 'none')
                        .style('stroke', '#000')
                    vGuide.selectAll('line')
                        .style('stroke', '#000')
        //Horizontal axis
        var hAxis = d3.svg.axis()
                .scale(hScale)
                .orient('bottom')
                .tickValues(hScale.domain().filter(function (d, i) {
                    return !(i % (myData.length / 11));
                }))
        //Horizontal guide
        var hGuide = d3.select('svg')
                    .append('g')
                    hAxis(hGuide)
                    hGuide.attr('transform', 'translate('+margin.left+','+(height + margin.top)+')')
                    hGuide.selectAll('path')
                        .style('fill', 'none')
                        .style('stroke', '#000')
                    hGuide.selectAll('line')
                        .style('stroke', '#000')


    </script>
</body>
</html>
