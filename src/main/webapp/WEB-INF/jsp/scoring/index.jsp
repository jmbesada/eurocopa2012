<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<div class="ui-widget" style="width:40%;text-align:center">
	<div class="ui-widget-header" style="line-height:2em;text-align:center">
		Puntuaciones de los concursantes 
	</div>
	<div class="ui-widget-content">
		<table cellpadding="5px">
			<thead>
				<tr>
					<th >Usuario</th>
					<th align="center">Puntuación</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${users}" var="user">
					<tr>
						<td>${user.email }</td>
						<td align="center">0</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
</div>
