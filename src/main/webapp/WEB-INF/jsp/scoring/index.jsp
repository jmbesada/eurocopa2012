<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<div class="ui-widget" style="text-align:center;width:650px">
	<div class="ui-widget-header ui-corner-all">
		<h4>Puntuaciones de los concursantes (provisional)</h4>
	</div>
	<div >
		<table cellpadding="7px" id="usersTable" style="width:100%">
			<thead >
				<tr class="ui-state-default" style="font-weight:bold">
					<th>Usuario</th>
					<th align="center">Puntuación</th>
					<th>¿Empatado?</th>
				</tr>
			</thead>
			<tbody >
				<c:set var="numItems" value="${fn:length(users)}"/>
				<c:forEach items="${users}" var="user" varStatus="status">
					<tr >
						<td align="left">
							<c:choose>
								<c:when test="${status.index == 0 }">
									<img src="${basePath}images/gold.png" style="margin-right:5px"/>
								</c:when>
								<c:when test="${status.index == 1 }">
									<img src="${basePath}images/silver.png" style="margin-right:5px"/>
								</c:when>
								<c:when test="${status.index == 2 }">
									<img src="${basePath}images/bronze.png" style="margin-right:5px"/>
								</c:when>
								<c:when test="${status.index == (numItems-3) }">
									<img src="${basePath}images/sad.png" style="margin-right:5px"/>
								</c:when>
								<c:when test="${status.index == (numItems-2) }">
									<img src="${basePath}images/crying.png" style="margin-right:5px"/>
								</c:when>
								<c:when test="${status.index == (numItems-1) }">
									<img src="${basePath}images/verySad.png" style="margin-right:5px"/>
								</c:when>
								<c:otherwise>
									<img src="${basePath}images/smile.png" style="margin-right:5px"/>
								</c:otherwise>
							</c:choose>
							${user.email }
						</td>
						<td align="center" width="130">${user.scoring }</td>
						<td align="center" width="75">
							<c:if test="${user.drawed}">
								Si
							</c:if>
							<c:if test="${!user.drawed}">
								No
							</c:if>
						</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
</div>
<script>
	$('#usersTable').dataTable({
		bPaginate:false,
		aaSorting: [[ 1, "desc" ]],
		bAutoWidth: false
	});
</script>