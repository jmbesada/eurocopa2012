<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<div class="ui-widget" style="width:900px;padding:5px;">
	<div class="ui-widget-header" style="line-height:2em;text-align:center;width:550px;">
		Listado de participantes que pasan a la fase final.
	</div>
	<div class="ui-widget-content" style="width:550px;">
		<table id="users" cellpadding="7px" cellspacing="0">
			<thead>
				<tr class="ui-state-default">
					<th width="70px">Puesto</th>
					<th width="300px">Participante</th>
					<th width="200px">Equipo ganador</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${users }" var="user">
					<tr>
						<td align="center">${user.finalPos }</td>
						<td align="left">${user.email }</td>
						<td align="center">
							<c:if test="${user.selectedCountryFinalPhase != null}">
								${user.selectedCountryFinalPhase.name }
							</c:if>
							
						</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
	<br/>
		<br/>
		(*) Si eres uno de los agraciados que has pasado a la fase final, la aplicaci�n te pedir� que introduzcas la selecci�n
		  que crees que va a ganar la eurocopa, de entre todas las selecciones que queden por elegir en ese momento.
		  <br/>
		  <br/>
		  Hasta que el concursante que te antecede en la clasificaci�n no eliga pa�s no podr�s seleccionar tu equipo. De esa manera, cuando el primero
		  haya elegido, el sistema automaticamente notificar� al segundo y as� sucesivamente.
		  <br/>
		  <br/>
		(**) El plazo de inscripci�n ser� el mismo Jueves.
</div>
<script>
	$('#users').dataTable({
		bPaginate:false,
		bFilter:false
	});
	
</script>