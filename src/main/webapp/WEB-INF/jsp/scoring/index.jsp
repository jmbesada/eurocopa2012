<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<div class="ui-widget" style="width:35%;text-align:center">
	<div class="ui-widget-header ui-corner-all">
		<h4>Puntuaciones de los concursantes (provisional)</h4>
	</div>
	<div class="ui-widget-content">
		<table cellpadding="5px" id="usersTable" width="100%" class="ui-widget">
			<thead >
				<tr class="ui-state-default" style="font-weight:bold">
					<th >Usuario</th>
					<th align="center">Puntuación</th>
				</tr>
			</thead>
			<tbody class="ui-widget-content">
				<c:forEach items="${users}" var="user" varStatus="status">
					<tr>
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
								<c:when test="${status.index == 3 }">
									<img src="${basePath}images/crying.png" style="margin-right:5px"/>
								</c:when>
								<c:when test="${status.index >= 4 }">
									<img src="${basePath}images/sad.png" style="margin-right:5px"/>
								</c:when>
							</c:choose>
							${user.email }
						</td>
						<td align="center">0</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
</div>
<script>
	//$('#usersTable tbody tr:even').addClass("ui-state-highlight");
</script>