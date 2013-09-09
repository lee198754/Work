<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default2.aspx.cs" Inherits="Default2" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>百度地图API自定义地图</title>
    <style type="text/css">
    html,body{margin:0;padding:0;}
    .iw_poi_title {color:#CC5522;font-size:14px;font-weight:bold;overflow:hidden;padding-right:13px;white-space:nowrap}
    .iw_poi_content {font:12px arial,sans-serif;overflow:visible;padding-top:4px;white-space:-moz-pre-wrap;word-wrap:break-word}
</style>
<script type="text/javascript" src="http://api.map.baidu.com/api?key=&v=1.1&services=true"></script>

</head>
<body>
    <form id="form1" runat="server">
    <div>
        <div style="width:697px;height:550px;border:#ccc solid 1px;" id="dituContent"></div>
    </div>
    </form>
</body>
<script type="text/javascript">
    var opts = {
      width : 100,     // 信息窗口宽度
      height: 50,     // 信息窗口高度
      title : "IBM中国股份有限公司"  // 信息窗口标题
    }
    //创建和初始化地图函数：
    function initMap() {
        createMap(); //创建地图
        setMapEvent(); //设置地图事件
        addMapControl(); //向地图添加控件
    }

    //创建地图函数：
    function createMap() {
        var map = new BMap.Map("dituContent"); //在百度地图容器中创建一个地图
        //var point = new BMap.Point(104.114129, 37.550339); //定义一个中心点坐标26.074286,119.296579
        //var point = new BMap.Point(119.315641,26.060566); //定义一个中心点坐标
        var point = new BMap.Point(119.296579,26.074286); //定义一个中心点坐标
        //map.centerAndZoom(point, 5); //设定地图的中心点和坐标并将地图显示在地图容器中
        map.centerAndZoom(point, 12); //设定地图的中心点和坐标并将地图显示在地图容器中
        window.map = map; //将map变量存储在全局

        //向地图添加标注
        var bounds = map.getBounds();        

        var point = new BMap.Point(116.326655,39.902095);
        var marker = new BMap.Marker(point);
        var label = new BMap.Label('IBM全球总部',{"offset":new BMap.Size(9,-15)});
        marker.setLabel(label);
        map.addOverlay(marker);
        marker.addEventListener("click", function(){this.openInfoWindow(new BMap.InfoWindow("全球总部（北京）</br>Tel:010-10000000", opts));});

        var point = new BMap.Point(103.809019, 30.850669); 
        var marker = new BMap.Marker(point);
        var label = new BMap.Label('成都分公司',{"offset":new BMap.Size(9,-15)});
        marker.setLabel(label);
        map.addOverlay(marker);
        marker.addEventListener("click", function(){this.openInfoWindow(new BMap.InfoWindow("成都分公司</br>Tel:暂无", opts));});

        var point = new BMap.Point(114.059763,22.646821);
        var marker = new BMap.Marker(point);
        var label = new BMap.Label('香港分公司',{"offset":new BMap.Size(9,-15)});
        marker.setLabel(label);
        map.addOverlay(marker);
        marker.addEventListener("click", function(){this.openInfoWindow(new BMap.InfoWindow("香港分公司</br>Tel:暂无", opts));});

        var point = new BMap.Point(121.323246, 31.294085);
        var marker = new BMap.Marker(point);
        var label = new BMap.Label('上海分公司',{"offset":new BMap.Size(9,-15)});
        marker.setLabel(label);
        map.addOverlay(marker);
        marker.addEventListener("click", function(){this.openInfoWindow(new BMap.InfoWindow("上海分公司</br>Tel:暂无", opts));});
    }
    // 编写自定义函数,创建标注
    function addMarker(point, index) {
        var myIcon = new BMap.Icon("http://api.map.baidu.com/img/markers.png", new BMap.Size(23, 25), {
            offset: new BMap.Size(10, 25),                  // 指定定位位置
            imageOffset: new BMap.Size(0, 0 - index * 25)   // 设置图片偏移
        });
        var marker = new BMap.Marker(point, { icon: myIcon });
        map.addOverlay(marker);
    }

    //地图事件设置函数：
    function setMapEvent() {
        map.enableDragging(); //启用地图拖拽事件，默认启用(可不写)
        map.enableScrollWheelZoom(); //启用地图滚轮放大缩小
        map.enableDoubleClickZoom(); //启用鼠标双击放大，默认启用(可不写)
        map.enableKeyboard(); //启用键盘上下左右键移动地图
    }

    //地图控件添加函数：
    function addMapControl() {
        //向地图中添加缩放控件
        var ctrl_nav = new BMap.NavigationControl({ anchor: BMAP_ANCHOR_TOP_LEFT, type: BMAP_NAVIGATION_CONTROL_LARGE });
        map.addControl(ctrl_nav);
        //向地图中添加缩略图控件
        var ctrl_ove = new BMap.OverviewMapControl({ anchor: BMAP_ANCHOR_BOTTOM_RIGHT, isOpen: 1 });
        map.addControl(ctrl_ove);
        //向地图中添加比例尺控件
        var ctrl_sca = new BMap.ScaleControl({ anchor: BMAP_ANCHOR_BOTTOM_LEFT });
        map.addControl(ctrl_sca);
    }
    initMap(); //创建和初始化地图
</script>



</html>
