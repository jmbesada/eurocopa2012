<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<div class="ui-widget" style="text-align:center;width:650px">
	<div class="ui-widget-header ui-corner-all">
		<h4>Puntuaciones de los concursantes (Definitivo)</h4>
	</div>
	<div >
		<table  cellpadding="7px" cellspacing="0" id="usersTable" style="width:100%">
			<thead >
				<tr class="ui-state-default" style="font-weight:bold">
					<th></th>
					<th>Usuario</th>
					<th align="center">Puntuación</th>
					<th>¿Empatado?</th>
					<th></th>
				</tr>
			</thead>
			<tbody >
				<c:set var="numItems" value="${fn:length(users)}"/>
				<c:forEach items="${users}" var="user" varStatus="status">
					<tr >
						<td align="center" width="30px">
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
									<c:if test="${user.gender == 'MALE' }">
										<img src="${basePath}images/male-removed.png" style="margin-right:5px"/>
									</c:if>
									<c:if test="${user.gender == 'FEMALE' }">
										<img src="${basePath}images/female-removed.png" style="margin-right:5px"/>
									</c:if>
								</c:when>
								<c:when test="${status.index == (numItems-2) }">
									<c:if test="${user.gender == 'MALE' }">
										<img src="${basePath}images/male-removed.png" style="margin-right:5px"/>
									</c:if>
									<c:if test="${user.gender == 'FEMALE' }">
										<img src="${basePath}images/female-removed.png" style="margin-right:5px"/>
									</c:if>
								</c:when>
								<c:when test="${status.index == (numItems-1) }">
									<c:if test="${user.gender == 'MALE' }">
										<img src="${basePath}images/male-removed.png" style="margin-right:5px"/>
									</c:if>
									<c:if test="${user.gender == 'FEMALE' }">
										<img src="${basePath}images/female-removed.png" style="margin-right:5px"/>
									</c:if>
								</c:when>
								<c:otherwise>
									<img src="${basePath}images/smile.png" style="margin-right:5px"/>
								</c:otherwise>
							</c:choose>
							
						</td>
						<td align="left">${user.email }</td>
						<td align="center" width="130">${user.scoring }</td>
						<td align="center" width="100">
							<c:if test="${user.drawed}">
								Si
							</c:if>
							<c:if test="${!user.drawed}">
								No
							</c:if>
						</td>
						<td width="30">
							<a href="#userDetail" data-login="${user.email }">
								<img src="${basePath }images/view-detail.png" border="0" title="Ver detalle puntuación"/>
							</a>
						</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
</div>

<div id="userDetail" class="ui-widget" style="width:500px;height:180px;display:none">
	<div class="ui-widget-header" style="line-height:2em;text-align:center">
		Puntuación por niveles del usuario <span>'\${username }'</span>
	</div>
	<div class="ui-widget-content">
		<table cellpadding="3">
			<tbody>
				<tr>
					<td>Por acertar los dos primeros en el orden correcto:</td>
					<td>\${firstLevelScoring } Puntos</td>
				</tr>
				<tr>
					<td>Por acertar los dos primeros en el orden inverso:</td>
					<td>\${secondLevelScoring } Puntos</td>
				</tr>
				<tr>
					<td>Por acertar el pase a cuartos de uno de los dos:</td>
					<td>\${thirdLevelScoring } Puntos</td>
				</tr>
				<tr>
					<td>Por acertar la posición exacta en el grupo:</td>
					<td>\${fourthLevelScoring } Puntos</td>
				</tr>
				<tr>
					<td align="right">ToTal</td>
					<td style="border-top: 1px solid #aaaaaa">
						<span class="ui-state-highlight" >
							\${firstLevelScoring+secondLevelScoring+thirdLevelScoring+fourthLevelScoring} Puntos
						</span>
					</td>
				</tr>
			</tbody>
		</table>
	</div>
</div>
<script>
	$('#usersTable').dataTable({
		bPaginate:false,
		bFilter:false,
		aaSorting: [[ 2, "desc" ]],
		aoColumns:[{bSortable:false},null,null,{bSortable:false},{bSortable:false}]
	});
	$('a[data-login]').colorbox({
		inline:true,
		onOpen:function(){
			var username=$(this).attr("data-login");
			$.getJSON('${basePath}services/scoring/userDetail','username='+username,function(resp){
				var data={
					username:username,
					firstLevelScoring:resp.firstLevelScoring,
					secondLevelScoring:resp.secondLevelScoring,
					thirdLevelScoring:resp.thirdLevelScoring,
					fourthLevelScoring:resp.fourthLevelScoring
				};
				$('#userDetail').html($('#userDetail').tmpl(data));
			});
			$('#userDetail').show();
		},
		onCleanup:function(){
			$('#userDetail').hide();
		}
	});
	//$('#usersTable tr:eq(${numItems-3})').css('border-top','1px solid #aaaaaa')
</script>