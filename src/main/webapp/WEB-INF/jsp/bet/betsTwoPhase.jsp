<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<div class="ui-widget" style="width:580px;padding:5px;">
	<div class="ui-widget-header" style="line-height:2em;text-align:center">
		Listado de participantes que pasan a la fase final.
	</div>
	<div class="ui-widget-content">
		<table cellpadding="3">
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
</div>