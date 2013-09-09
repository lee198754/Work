<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default3.aspx.cs" Inherits="Default3" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
   <title>百度地图API自定义地图</title>
   
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
      title : ""  // 信息窗口标题
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
        var point = new BMap.Point(119.296579,26.074286); //定义一个中心点坐标
        map.centerAndZoom(point, 17); //设定地图的中心点和坐标并将地图显示在地图容器中
        window.map = map; //将map变量存储在全局

        //向地图添加标注
        var bounds = map.getBounds();        
        
        var point = new BMap.Point(119.296579,26.074286);
        var marker = new BMap.Marker(point);
        var label = new BMap.Label('IBM全球总部',{"offset":new BMap.Size(9,-15)});
        marker.setLabel(label);
        map.addOverlay(marker);
        //marker.addEventListener("click", function(){this.openInfoWindow(new BMap.InfoWindow("全球总部（北京）</br>Tel:010-10000000", opts));});
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
