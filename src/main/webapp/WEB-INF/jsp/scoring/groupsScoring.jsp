<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page contentType="text/html; charset=UTF-8" %>

<div class="ui-widget" style="width:750px">
	<div class="ui-widget-header" style="line-height:2em;text-align:center">
		Clasificación de grupos de la Eurocopa 2012 (
		<fmt:formatDate value="${now }" timeStyle="medium" />)
	</div>
	<div class="ui-widget-content">
		<table cellspading="5px" cellspacing="20px">
			<tr>
				<td>
					<div id="group1" class="ui-widget">
						<div class="ui-widget-header">
							Grupo 1
						</div>
						<div class="ui-widget-content">
							<table id="groupATable">
								<c:forEach items="${groupA}" var="country">
									<tr>
										<td>
											<img src="${basePath }images/flags/${country.iconPath }"/>
										</td>  
										<td width="150px"> 
											${country.name }
										</td>
										<td>
											${country.points } puntos
										</td>
									</tr>
								</c:forEach>
							</table>
						</div>
					</div>
				</td>
				
				<td>
					<div id="group1" class="ui-widget">
						<div class="ui-widget-header">
							Grupo 2
						</div>
						<div class="ui-widget-content">
							<table id="groupATable">
								<c:forEach items="${groupB}" var="country">
									<tr>
										<td>
											<img src="${basePath }images/flags/${country.iconPath }"/>
										</td>  
										<td width="150px"> 
											${country.name }
										</td>
										<td>
											${country.points } puntos
										</td>
									</tr>
								</c:forEach>
							</table>
						</div>
					</div>
				</td>
			</tr>
			<tr>
				<td>
					<div id="group1" class="ui-widget">
						<div class="ui-widget-header">
							Grupo 1
						</div>
						<div class="ui-widget-content">
							<table id="groupATable">
								<c:forEach items="${groupC}" var="country">
									<tr>
										<td>
											<img src="${basePath }images/flags/${country.iconPath }"/>
										</td>  
										<td width="150px"> 
											${country.name }
										</td>
										<td>
											${country.points } puntos
										</td>
									</tr>
								</c:forEach>
							</table>
						</div>
					</div>
				</td>
				<td>
					<div id="group1" class="ui-widget">
						<div class="ui-widget-header">
							Grupo 1
						</div>
						<div class="ui-widget-content">
							<table id="groupATable">
								<c:forEach items="${groupD}" var="country">
									<tr>
										<td>
											<img src="${basePath }images/flags/${country.iconPath }"/>
										</td>  
										<td width="150px"> 
											${country.name }
										</td>
										<td>
											${country.points } puntos
										</td>
									</tr>
								</c:forEach>
							</table>
						</div>
					</div>
				</td>
			</tr>
		</table>
	</div>
</div>