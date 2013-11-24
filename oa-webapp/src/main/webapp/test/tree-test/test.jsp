<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<%@ include file="/common/global.jsp"%>
    <title>部门管理</title>
	<%@ include file="/common/meta.jsp" %>
    <%@ include file="/common/include-styles.jsp" %>
    <%@ include file="/common/include-jquery.jsp"%>
    <%@ include file="/common/include-ztree.jsp" %>

	<SCRIPT type="text/javascript">
		<!--
		//zTree的配置
		var setting = {
    		view: {
    			//多选
    			selectedMulti: false
    		},		
			edit: {
				//zTree可以修改
				enable: true,
				//隐藏删除按钮
				showRemoveBtn:false,
				//隐藏修改按钮
				showRenameBtn:false
			},
			check: {
				//设置zTree有复选框效果
				enable: true
			}
		};
		
		//zTree的数据
		//open:展开节点
		//url：打开的请求地址：修改模式不能打开url
		//target：地址的target
		var zNodes =[
			{ name:"父节点1 - 展开", open:true,
				children: [
					{ name:"父节点11 - 折叠", open: true,
						children: [
							{ name:"叶子节点111", url: "aaaa", target:"aa"},
							{ name:"叶子节点112"},
							{ name:"叶子节点113"},
							{ name:"叶子节点114", checked: true}
						]},
					{ name:"父节点12 - 折叠",
						children: [
							{ name:"叶子节点121", checked: true},
							{ name:"叶子节点122"},
							{ name:"叶子节点123"},
							{ name:"叶子节点124"}
						]},
					{ name:"父节点13 - 没有子节点", isParent:true}
				]},
			{ name:"父节点2 - 折叠",
				children: [
					{ name:"父节点21 - 展开", open:true,
						children: [
							{ name:"叶子节点211"},
							{ name:"叶子节点212"},
							{ name:"叶子节点213"},
							{ name:"叶子节点214"}
						]},
					{ name:"父节点22 - 折叠",
						children: [
							{ name:"叶子节点221"},
							{ name:"叶子节点222"},
							{ name:"叶子节点223"},
							{ name:"叶子节点224"}
						]},
					{ name:"父节点23 - 折叠",
						children: [
							{ name:"叶子节点231"},
							{ name:"叶子节点232"},
							{ name:"叶子节点233"},
							{ name:"叶子节点234"}
						]}
				]},
			{ name:"父节点3 - 没有子节点", isParent:true}

		];

		$(document).ready(function(){
			//初始化zTree
			//treeDemo: ul对象
			//setting：zTree的配置
			//zNodes：zTree的数据(通过ajax获取后台数据)
			$.fn.zTree.init($("#treeDemo"), setting, zNodes);
		});
		
		function addRoot() {
			//得到zTree对象
			var zTree = $.fn.zTree.getZTreeObj("treeDemo");
			//增加节点,如果parentNode=null，添加根节点
			zTree.addNodes(null, {name: '新节点', id: 123})
		}
		
		function addChildren() {
			var zTree = $.fn.zTree.getZTreeObj("treeDemo");
			//通过参数得到一个节点,如果多个节点返回，只返回第一个节点
			var pNode = zTree.getNodeByParam("name", "叶子节点121");
			zTree.addNodes(pNode, {name: '新节点', id: 123});
		}
		function deleteNode() {
			var treeObj = $.fn.zTree.getZTreeObj("treeDemo");
			//得到选中的节点
			var nodes = treeObj.getSelectedNodes();
			for (var i=0, l=nodes.length; i < l; i++) {
				//删除一个节点
				treeObj.removeNode(nodes[i]);
			}
		}
		
		function getNode() {
			var zTree = $.fn.zTree.getZTreeObj("treeDemo");
			//得到节点的所有根节点，如果要得到所有节点，需要递归
			var nodes =  zTree.getNodes();
			showNode( nodes);
		}
		
		function showNode(nodes) {
			var zTree = $.fn.zTree.getZTreeObj("treeDemo");
			for (var i in nodes) {
				alert("顺序:" + zTree.getNodeIndex(nodes[i]) + "  name:" + nodes[i].name + "  parent :" + (null != nodes[i].getParentNode() ? nodes[i].getParentNode().name : '空 '));
				
				//递归
				if (nodes[i].children && nodes[i].children.length > 0) {
					showNode(nodes[i].children);
				}
			}
		}
		function updateNode() {
			var zTree = $.fn.zTree.getZTreeObj("treeDemo");
			var node = zTree.getNodeByParam("name", "叶子节点121");
			node.name= '修改节点';
			zTree.updateNode(node);
			
		}
	</SCRIPT>
</HEAD>

<BODY>
	<input type="button" value="添加根节点" onclick="addRoot();">
	<input type="button" value="添加子节点" onclick="addChildren();">
	<input type="button" value="修改节点" onclick="updateNode();">
	<input type="button" value="删除节点" onclick="deleteNode();">
	<input type="button" value="得到节点顺序，和父节点" onclick="getNode();">
	<ul id="treeDemo" class="ztree" style="width: 100%; height: 100%;"></ul>
	
</BODY>
</HTML>