<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    
    <div class="jumbotron" style="height: 830px">
        <h1>Welcome to Word Cloud Generator</h1>
        <div style="height: 650px; position: relative; float: left; padding-right: 20px">
            <asp:TextBox ID="TextBox1" runat="server" Height="315px" TextMode="MultiLine" Width="356px"></asp:TextBox>
            <br />
            <br />
            <asp:Panel ID="Panel1" runat="server" Visible="False">
            <asp:TextBox ID="TextBox2" runat="server" TextMode="MultiLine" Visible="False"></asp:TextBox>
                <asp:TextBox ID="TextBox3" runat="server" TextMode="MultiLine"></asp:TextBox>
                </asp:Panel>
        <p>&nbsp;&nbsp;<asp:Label ID="Label1" runat="server" Text="Label"></asp:Label>
&nbsp;<asp:FileUpload ID="FileUpload" runat="server" />
            </p>
        <p>
            <asp:Button ID="Button4" runat="server" OnClick="Button4_Click" Text="Edit List" />
&nbsp;<asp:Button ID="Button2" runat="server" OnClick="Button2_Click" Text="Upload" />
            &nbsp;<input id="Button1" type="button" onClick="Populate()" value="Generate" />
            </p>
            <p>
                <input id="Button5" runat="server" type="button" onClick="ExportToPDF()" value="Export to PDF" />
            &nbsp;<input id="Button6" runat="server" type="button" onClick="ExportToSVG" value="Export to SVG" />
        </p>
       
        
             </div>
        <div style="background-color: darkslategrey; height: 650px; position: relative; width: 650px; float: left;" id="cloud">
            </div>
    

    <!-- Hidden <FORM> to submit the SVG data to the server, which will convert it to SVG/PDF/PNG downloadable file.
     The form is populated and submitted by the JavaScript below. -->

<%--    <form id="svgform" method="post" action="download.pl">
         <input type="hidden" id="output_format" name="output_format" value="">
         <input type="hidden" id="data" name="data" value="">
    </form>--%>

     </div>

    <script type="text/javascript">
        var tb2 = "";
        var string1 = "";
        var string5 = "";
        var string3 = "";
        var tb2Text = [];
        var tb2Size = [];
        var element;
        var height;
        var width;
        var maxCount;
        var minCount;
        var maxWordSize;
        var minWordSize;
        var spread;
        var step;


        function clear() {
            string1 = "";
            tb2 = "";
            string5 = "";
            string3 = "";
            tb2Text = [];
            tb2Size = [];
            d3.select("svg").remove();
            element = "";
            height = "";
            width = "";
            maxCount = "";
            minCount = "";

        }

        function submit_download_form(output_format) {
            // Get the d3js SVG element
            var tmp = document.getElementById("cloud");
            var svg = tmp.getElementsByTagName("svg")[0];
            // Extract the data as SVG text string
            var svg_xml = (new XMLSerializer).serializeToString(svg);

            // Submit the <FORM> to the server.
            // The result will be an attachment file to download.
            var form = document.getElementById("svgform");
            form['output_format'].value = output_format;
            form['data'].value = svg_xml;
            form.submit();
        }


        function ExportToPDF() {

            submit_download_form("pdf");
            //// Get the d3js SVG element
            //var tmp = document.getElementById("cloud");
            //var svg = tmp.getElementsByTagName("svg")[0];
            //// Extract the data as SVG text string
            //var svg_xml = (new XMLSerializer).serializeToString(svg);

            //// Submit the <FORM> to the server.
            //// The result will be an attachment file to download.
            //var form = document.getElementById("svgform");
            //form['output_format'].value = "output_format";
            //form['data'].value = svg_xml;
            //form.submit();

            //d3.selectAll("svg text").style({ 'font-size': '12px' });
            //d3.selectAll(".c3-axis path").style({ 'fill': 'none', 'stroke': '#000' });
            //d3.selectAll(".c3-chart-arc path").style({ 'stroke': '#FFFFFF' });
            //d3.selectAll(".c3-chart-arc text").style({ 'fill': '#FFFFFF' });

            //html2canvas(document.getElementById('exportchart'), {
            //    onrendered: function (canvas) {
            //        var a = document.createElement("a");
            //        a.download = "chart.png";
            //        a.href = canvas.toDataURL("image/png");
            //        a.click();

            //var serializer = new XMLSerializer();
            //var source = '<?xml version="1.0" standalone="no"?>\r\n' + serializer.serializeToString(svg.node());
            //var image = new Image;
            //image.src = "data:image/svg+xml;charset=utf-8," + encodeURIComponent(source);
            //var canvas = document.createElement("canvas");
            //canvas.width = pngWidth;
            //canvas.height = pngHeight;
            //var context = canvas.getContext("2d");
            //context.fillStyle = '#fff';  
            //context.fillRect(0, 0, 10000, 10000);
            //context.drawImage(image, 0, 0);
            //return canvas.toDataURL("image/png");  
        }

        function Populate() {
            clear();
                         
            var tb2 = (document.getElementById('<%=TextBox3.ClientID%>').value).slice(0, -1);
            tb2 = tb2.replace(/\n/g, "=");
            tb2 = tb2+"=";
            tb2 = tb2.split("=");

            var i;
            var j;
            for (i = 0; i < tb2.length; i++) {

                if (i % 2 === 0) {
                    tb2Size.push(tb2[i]);
                    //convert to int b4 store
                } else {
                    tb2Text.push(tb2[i]);
                }

            }

            // First define your cloud data, using `text` and `size` properties:
            string1 = "[";

            //put in the counnt, edit the for loop
            for (i = 0; i < tb2Text.length; i++) {
                string5 += "{ size: " + tb2Size[i] * 3.3 + ", text: '" + tb2Text[i] + "' },";
            }
            string5 = string5.slice(0, -1);

            string3 = "]";

            //concatenate the string
            var skillsToDraw = eval('(' + string1 + string5 + string3 + ')');
            /*var skillsToDraw = [
                { text: 'javascript', size: 80 },
                { text: 'D3.js', size: 30 },
                { text: 'coffeescript', size: 50 },
                { text: 'shaving sheep', size: 50 },
                { text: 'AngularJS', size: 60 },
                { text: 'Ruby', size: 60 },
                { text: 'ECMAScript', size: 30 },
                { text: 'Actionscript', size: 20 },
                { text: 'Linux', size: 40 },
                { text: 'C++', size: 40 },
                { text: 'C#', size: 50 },
                { text: 'JAVA', size: 76 }
            ];*/
            // Next you need to use the layout script to calculate the placement, rotation and size of each word:

            var width = 500;
            var height = 500;
            var fill = d3.scale.category20();

            d3.layout.cloud()
                .size([width, height])
                .words(skillsToDraw)
                .rotate(function () {
                    return ~~(Math.random() * 2) * 90;
                })
                .font("Impact")
                .fontSize(function (d) {
                    return d.size;
                })
                .on("end", drawSkillCloud)
                .start();

            // Finally implement `drawSkillCloud`, which performs the D3 drawing:

            // apply D3.js drawing API
            function drawSkillCloud(words) {
                d3.select("#cloud")
                    .append("svg")
                    .attr("width", width)
                    .attr("height", height)
                    .style("margin-left", "75px")
                    .style("margin-top", "45px")
                    .append("g")
                    .attr("transform", "translate(" + ~~(width / 2) + "," + ~~(height / 2) + ")")
                    .selectAll("text")
                    .data(words)
                    .enter()
                    .append("text")
                    .style("font-size",
                    function (d) {
                        return d.size + "px";
                    })
                    .style("-webkit-touch-callout", "none")
                    .style("-webkit-user-select", "none")
                    .style("-khtml-user-select", "none")
                    .style("-moz-user-select", "none")
                    .style("-ms-user-select", "none")
                    .style("user-select", "none")
                    .style("cursor", "default")
                    .style("font-family", "Chiller")
                    .style("fill",
                    function (d, i) {
                        return fill(i);
                    })
                    .attr("text-anchor", "middle")
                    .attr("transform",
                    function (d) {
                        return "translate(" + [d.x, d.y] + ")rotate(" + d.rotate + ")";
                    })
                    .text(function (d) {
                        return d.text;
                    });
            }

            // set the viewbox to content bounding box (zooming in on the content, effectively trimming whitespace)

            var svg = document.getElementsByTagName("svg")[0];
            var bbox = svg.getBBox();
            var viewBox = [bbox.x, bbox.y, bbox.width, bbox.height].join(" ");
            svg.setAttribute("viewBox", viewBox);
        }

    </script>
    <script src="Scripts/d3.min.js"></script>
    <script src="Scripts/d3.layout.cloud.js"></script>

    </asp:Content>