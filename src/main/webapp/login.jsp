<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
	<div class="container" style="position:relative;">
		<div id="logo"></div>
		<div class="span-24 ui-widget">	
			<div class="ui-widget-header banner" style="text-align:center;height:100px;line-height:50px">
				<h1 class="alt">Mis Apuestas De La Eurocopa 2012</h1>
			</div>
		</div>
		<hr/>
		<hr/>
		<div class="prepend-6 span-10 ui-widget" >
			<div class="ui-widget-header ui-corner-top" style="text-align:center;line-height:2em">
				Introduce tus credenciales en Mis Apuestas
			</div>
			<div class="ui-widget-content ui-corner-bottom">
				<form action="/j_spring_security_check" method="post">
					<table cellpadding="5px" width="100%">
						<tbody>
							<c:if test="${param.failure == true}">
								<tr>
									<td colspan="2" align="center" class="ui-state-error">
										Auteticación errónea
									</td>
								</tr>
								
							</c:if>
							<tr>
								<td>Usuario:</td>
								<td><input name="j_username" type="text" style="width:150px" class="ui-button-text"/>
							</tr>
							<tr>
								<td>Contraseña:</td>
								<td><input name="j_password" type="password" style="width:150px"/>
							</tr>
							<tr>
								<td colspan="2">
									<input type="checkbox" name="_spring_security_remember_me"/> 
									<span id="rememeber_me">Recuérdame</span>
									<a href="#forgetPassword">¿Olvidaste la contraseña?</a>
								</td>
							</tr>
							<tr>
								<td colspan="2" align="center">
									<input type='submit' value="Abrir sesión"/>
								</td>
							</tr>
							
						</tbody>
					</table>
				</form>
			</div>
		</div>
		
	</div>
	
	
	
		
	<div id="forgetPassword" style="display:none;width:400px">
		<div class="ui-widget">
			<div class="ui-widget-content" style="padding:5px">
				<form action="#">
					<fieldset style="width:80%">
						<legend>Recuperación de contraseña</legend>
						<label for="username">Introduce tu email:</label>
						<input name="username" type="text" value="" size="20"/><br/><br/>
						<input id="sendPassword" type="button" value="Enviar contraseña"/>
					</fieldset>
					
				</form>
				
			</div>
		</div>
	</div>
	<script>
		
		$('input[type=submit]').button();
		$('a[href*=forgetPassword]').colorbox({
			inline:true,
			content:$(this).attr('href'),
			onOpen:function(){$('#forgetPassword').show()},
			onCleanup:function(){$('#forgetPassword').hide()}
		});
		$('#sendPassword').button().click(function(){
			showAjaxLogo();
			$.get('${basePath}services/actions/sendPassword',$('#forgetPassword form').serialize(),
					function(){
				$('#forgetPassword').hide();
				$.colorbox.close();
				hideAjaxLogo();
			}).error(function(){
				
			});
			
		});
	</script>
</body>
</html>