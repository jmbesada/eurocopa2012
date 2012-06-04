<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
	<jsp:include page="/WEB-INF/jsp/common/loadScripts.jsp"/>
	<style>
		#loginPanel{
			width:375px;
			height:250px;
		}
	</style>
</head>
<body class="ui-widget-overlay">
	<div id="logo"></div>
	<div id="openInbox">
		<a href="#inbox">
			<img src="${basePath}images/inbox.png" title="Enviar sugerencias"/>
		</a>
		
	</div>
	<div id="disconnect" class="ui-state-active ui-corner-all" >
		<a href="/j_spring_security_logout">Desconectar</a>
	</div>
	<div class="ui-widget">
		<div class="ui-widget-header banner"" style="text-align:center;height:100px;line-height:50px;">
			<h1>Mis Apuestas De La Eurocopa 2012</h1>
		</div>
	</div>

	<div id="menu">
		<ul>
			<li><a href="#myBets">Mis apuestas</a></li>
			<li><a href="#score">Puntuación</a></li>
			<li><a href="#groupsScoring">Así va la Eurocopa</a></li>
			<li><a href="#changePassword">Cambiar contraseña</a></li>
			<li><a href="#bases">Bases del concurso</a></li>
		</ul>
		<div id="myBets">
			<c:if test="${param.tab == 0 }">
				<jsp:include page="/services/bet/index" />
			</c:if>
		</div>
		<div id="score">
			<c:if test="${param.tab == 1 }">
				<jsp:include page="/services/scoring/index"/>
			</c:if>
		</div>
		<div id="groupsScoring">
			<c:if test="${param.tab == 2 }">
				<jsp:include page="/services/scoring/groupsScoring"/>
			</c:if>
		</div>
		<div id="changePassword">
			<c:if test="${param.tab == 3 }">
				<jsp:include page="/services/changePassword/index"/>
			</c:if>
		</div>
		<div id="bases">
			<c:if test="${param.tab == 4 }">
				<jsp:include page="/services/bases/index"/>
			</c:if>
		</div>
	</div>
	
	<div id="inbox" style="display:none;width:400px;">
		<div class="ui-widget">
			<div class="ui-widget-header" style="line-height:2em;text-align:center">
				Introduce tus sugerencias:
			</div>
			<div class="ui-widget-content" style="text-align:center">
				<div id="error" class="ui-state-error" style="display:none;width:98%;text-align:center">
					Error al enviar el correo.
				</div>
				<form id="emailForm">
					<textarea  name="hint" rows="10" style="width:98%"></textarea>
					<br/>
					<input id="sendHints" type="button" value="Enviar sugerencias"/>
				</form>
				
			</div>
		</div>
		
	</div>

	<script>
		$(document).ready(function(){
			$('#menu').tabs();
			<c:if test="${param.tab == 0 }">
				$('#menu').tabs('select',0);
			</c:if>
			<c:if test="${param.tab == 1 }">
				$('#menu').tabs('select',1);
			</c:if>
			<c:if test="${param.tab == 2 }">
				$('#menu').tabs('select',2);
			</c:if>
			<c:if test="${param.tab == 3 }">
				$('#menu').tabs('select',3);
			</c:if>
			<c:if test="${param.tab == 4 }">
				$('#menu').tabs('select',4);
			</c:if>
			$('#menu').bind('tabsselect',function(event,tab){
				if (tab.index == 0) location.href='${basePath}services/home?tab=0';
				else if (tab.index == 1) location.href='${basePath}services/home?tab=1';
				else if (tab.index == 2) location.href='${basePath}services/home?tab=2';
				else if (tab.index == 3) location.href='${basePath}services/home?tab=3';
				else if (tab.index == 4) location.href='${basePath}services/home?tab=4';
			});
		});
		$('#openInbox a').colorbox({
			inline:true,
			content:$(this).attr('href'),
			onOpen:function(){
				$('#inbox').show();
				$('textarea').val('')
			},
			onCleanup:function(){
				$('#inbox').hide();
			}
		});
		
		$('#sendHints').button().click(function(){
			$.post('${basePath}services/actions/sendHint',$('#emailForm').serialize(),function(){
				$.colorbox.close()
			}).error(function(){
				$('#error').show();
			});
		
		});
		
	</script>
</body>
</html>