<html>
<head>
  <meta http-equiv=Content-Type content="text/html; charset=windows-1252">
  <meta name=ProgId             content= FrontPage.Editor.Document       >
  <meta name=Generator          content="Microsoft Excel 9"              >

</head>

<script type='text/javascript'>

function create_chart() {

  var xlLineMarkers    = 65;
  var xlColumns        =  2;

  var chDimSeriesNames =  0;
  var chDimCategories  =  1;
  var chDimValues      =  2;
  var chDimXValues     =  4;

  chart.Charts.Add();
  
  chart.ChartType = xlLineMarkers;
  chart.DataSource = excel;//.Range("A1:B12");
  var s = chart.Charts(0).SeriesCollection;

  var data_series = s.Add();

  data_series.SetData(chDimCategories, 0, "A1:A12");
  data_series.SetData(chDimValues,     0, "B1:B12");

  return false;
}

function showTable() {
  

  excel.DisplayToolbar = false;

  excel.range('a1:a12').select();
  excel.Selection.NumberFormat = 'mmm-yy';

  excel.range('a1' ).value = 'Jan-2004';
  excel.range('a2' ).value = 'Feb-2004';
  excel.range('a3' ).value = 'Mar-2004';
  excel.range('a4' ).value = 'Apr-2004';
  excel.range('a5' ).value = 'May-2004';
  excel.range('a6' ).value = 'Jun-2004';
  excel.range('a7' ).value = 'Jul-2004';
  excel.range('a8' ).value = 'Aug-2004';
  excel.range('a9' ).value = 'Sep-2004';
  excel.range('a10').value = 'Oct-2004';
  excel.range('a11').value = 'Nov-2004';
  excel.range('a12').value = 'Dec-2004';

  excel.range('b1' ).value = 10;
  excel.range('b2' ).value = 15;
  excel.range('b3' ).value = 18;
  excel.range('b4' ).value = 17;
  excel.range('b5' ).value = 50;
  excel.range('b6' ).value = 23;
  excel.range('b7' ).value = 22;
  excel.range('b8' ).value = 24;
  excel.range('b9' ).value = 27;
  excel.range('b10').value = 27;
  excel.range('b11').value = 29;
  excel.range('b12').value = 32;
}
</script>

<object
  id      = 'excel'
  classid = 'CLSID:0002E510-0000-0000-C000-000000000046'>
 <param name=DisplayTitleBar value=false   >
 <param name=ViewableRange   value='a1:b12'>
 <param name=AutoFit         value=true    >
</object>

<object
  width   =  800
  height  =  400
  id      = 'chart'
  classid = 'CLSID:0002E500-0000-0000-C000-000000000046'>
</object>

<body onLoad='showTable();'>

<form>
  <input type=submit onclick='return create_chart()' value='Create Chart'>
</form>


</body>
</html>
