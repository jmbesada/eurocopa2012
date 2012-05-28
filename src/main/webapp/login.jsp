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
	<div id="logo"></div>
	<div  class="ui-widget">
		<div class="ui-widget-header" style="text-align:center;height:100px;line-height:50px">
			<h1>Mis Apuestas De La Eurocopa 2012</h1>
		</div>
	</div>
	<div id="loginPanel" class="ui-widget">
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
							<td colspan="2" align="center">
								<input type='submit' value="Abrir sesión"/>
							</td>
						</tr>
					</tbody>
				</table>
			</form>
		</div>
	</div>
	<script>
		$('body').height(screen.height);
		$('#loginPanel').position({
			of:'body',
			at:'center center',
			my:'center center',
			offset:'0 -100px'
		});
		$('input[type=submit]').button();
	</script>
</body>
</html>