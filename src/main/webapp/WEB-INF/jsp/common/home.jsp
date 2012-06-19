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
	<div class="container" style="position:relative">
		<div id="logo"></div>
		<div class="span-24 ui-widget">
			<div class="ui-widget-header banner " style="text-align:center;height:100px;line-height:50px;">
					<h1 class="alt">Mis Apuestas De La Eurocopa 2012</h1>
			</div>
			<div id="openInbox">
				<a href="#inbox">
					<img src="${basePath}images/inbox.png" title="Enviar sugerencias" border="0"/>
				</a>
			</div>
			<div id="disconnect" class="ui-state-active ui-corner-all" >
				<a href="/j_spring_security_logout">Desconectar</a>
			</div>
		</div>
		<hr/>
		<hr/>
		<div class="span-24" id="menu">
			<ul>
				<li><a href="#myBets1">Mis apuestas (1º Fase)</a></li>
				<li><a href="#myBets2">Mis apuestas (Fase final)</a></li>
				<li><a href="#score">Puntuación</a></li>
				<li><a href="#groupsScoring">Así va la Eurocopa</a></li>
				<li><a href="#bases">Bases del concurso</a></li>
			</ul>
			<div id="myBets1">
				<c:if test="${param.tab == 0 }">
					<jsp:include page="/services/bet/index" />
				</c:if>
			</div>
			<div id="myBets2">
				<c:if test="${param.tab == 1 }">
					<jsp:include page="/services/bet/betsTwoPhase"/>
				</c:if>
			</div>
			<div id="score">
				<c:if test="${param.tab == 2 }">
					<jsp:include page="/services/scoring/index"/>
				</c:if>
			</div>
			<div id="groupsScoring">
				<c:if test="${param.tab == 3 }">
					<jsp:include page="/services/scoring/groupsScoring"/>
				</c:if>
			</div>
			<!--<div id="changePassword">
				<c:if test="${param.tab == 4 }">
					<jsp:include page="/services/changePassword/index"/>
				</c:if>
			</div>-->
			<div id="bases">
				<c:if test="${param.tab == 4 }">
					<jsp:include page="/services/bases/index"/>
				</c:if>
			</div>
		</div>
	</div>
	

	
	
	<div id="inbox" style="display:none;width:350px;">
		<div class="ui-widget">
			<div class="ui-widget-header" style="line-height:2em;text-align:center">
				Introduce tus sugerencias:
			</div>
			<div class="ui-widget-content" style="text-align:center">
				<div id="error" class="ui-state-error" style="display:none;width:98%;text-align:center">
					Error al enviar el correo.
				</div>
				<form action="#" id="emailForm">
					<textarea  name="hint" rows="5" style="width:98%"></textarea>
					<br/>
					<input id="sendHints" type="button" value="Enviar sugerencias"/>
				</form>
				
			</div>
		</div>
		
	</div>
	
	<div id="introduceWinnerCountry" style="display:none">
		<div class="ui-widget">
			<div class="ui-state-highlight" style="line-height:2em;text-align:center">
				Elige la selección del siguiente despegable:
				<br/>
				<select id="countryToSelect" name="countryToSelect" style="width:150px">
					
				</select>
				
			</div>
			(*) Una vez hecho la elección no se podrá rectificar.
		</div>
		
	</div>

	<script>
		$(document).ready(function(){
			$('#menu').tabs({
				selected:${param.tab}
			});
		
			$('#menu').bind('tabsselect',function(event,tab){
				location.href='${basePath}services/home?tab='+tab.index;
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
			showAjaxLogo();
			$(this).addClass('ui-state-disabled');
			$.post('${basePath}services/actions/sendHint',$('#emailForm').serialize(),function(){
				$('#sendHints').removeClass('ui-state-disabled');
				$.colorbox.close();
				hideAjaxLogo();
			}).error(function(){
				$('#error').show();
				hideAjaxLogo();
			});
		
		});
	
		$.getJSON('${basePath}services/bet/isFirstPhaseFinished',null,function(resp1){
			if (!resp1.true) $('#menu').tabs('disable',1);
			else{
				$.getJSON('${basePath}services/bet/isMyTurn',null,function(resp2){
					if (resp2.true){
						console.log("Introduce winner country");
						$('#introduceWinnerCountry').dialog({
							title:'Congratulations!!!!!!!!!!!! Te has clasificado para la ronda final.',
							modal:true,
							width:550,
							buttons:{
								'Guardar selección':function(){
									
								},
								'Elegir más tarde': function(){
									$('#introduceWinnerCountry').dialog('close');
								}
							},
							open:function(){
								$.getJSON('${basePath}services/bet/countriesToChoose',null,function(resp){
									$.each(resp,function(index,country){
										$('#countryToSelect').append("<option>"+country.name+"</option>");
									});
									
								})
							}
						})
						
						
					}
				});
			}
		});
	</script>
	
</html>