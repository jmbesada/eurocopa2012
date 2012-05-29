<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ page contentType="text/html; charset=UTF-8" %>

<div id="notification" class="ui-state-error"
	style="width:550px;display:none;line-height:2em;padding-left:3px"></div>

<table cellspading="5px" cellspacing="20px">
	<tr>
		<td>
			<div id="group1" class="ui-widget">
				<div class="ui-widget-header">
					Grupo 1
				</div>
				<div class="ui-widget-content">
					<table id="groupATable">
						<c:forEach items="${countriesA}" var="country">
							<tr>
								<td>
									<img src="${basePath }images/flags/${country.iconPath }"/>
								</td>  
								<td width="150px"> 
									${country.name }
								</td>
								<td>
									<select data-country="${country.id }">
										<c:forEach items="${positions}" var="position" varStatus="status">
											<option value="${status.count }">${position }</option>
										</c:forEach>
									</select>
								</td>
							</tr>
						</c:forEach>
					</table>
				</div>
			</div>
		</td>
		
		<td>
			<div id="group2" class="ui-widget">
				<div class="ui-widget-header">
					Grupo 2
				</div>
				<div class="ui-widget-content">
					<table id="groupBTable">
						<c:forEach items="${countriesB}" var="country">
							<tr>
								<td>
									<img src="${basePath }images/flags/${country.iconPath }"/>
								</td>
								<td width="150px"> 
									${country.name }
								</td>
								<td>
									<select data-country="${country.id }">
										<c:forEach items="${positions}" var="position" varStatus="status">
											<option value="${status.count }">${position }</option>
										</c:forEach>
									</select>
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
			<div id="group3" class="ui-widget">
				<div class="ui-widget-header">
					Grupo 3
				</div>
				<div class="ui-widget-content">
					<table id="groupCTable">
						<c:forEach items="${countriesC}" var="country">
							<tr>
								<td>
									<img src="${basePath }images/flags/${country.iconPath }"/>
								</td>
								<td width="150px"> 
									${country.name }
								</td>
								<td>
									<select data-country="${country.id }">
										<c:forEach items="${positions}" var="position" varStatus="status">
											<option value="${status.count }">${position }</option>
										</c:forEach>
									</select>
								</td>
							</tr>
						</c:forEach>
					</table>
				</div>
			</div>
		</td>
		 
		<td>
			<div id="group4" class="ui-widget">
				<div class="ui-widget-header">
					Grupo 4
				</div>
				<div class="ui-widget-content">
					<table id="groupDTable">
						<c:forEach items="${countriesD}" var="country">
							<tr>
								<td>
									<img src="${basePath }images/flags/${country.iconPath }"/>
								</td>
								<td width="150px"> 
									${country.name }
								</td>
								<td>
									<select data-country="${country.id }">
										<c:forEach items="${positions}" var="position" varStatus="status">
											<option value="${status.count }">${position }</option>
										</c:forEach>
									</select>
								</td>
							</tr>
						</c:forEach>
					</table>
				</div>
			</div>
		</td>
	</tr>
	<tr>
		<td><input id="saveBets" type="button" value="Guardar apuestas"/></td>
	</tr>
</table>

<div id="betsSaved" title="Mensaje del sistema">
	Tus apuestas han sido guardadas con éxito. Que la suerte te acompañe.
</div>


<script>
	$(document).ready(function(){
		fillBets();
		<c:if test="${today > lastDayToBet}">
			disableSaveBets();
		</c:if>
	});
	$('input[type=button]').button();
	$('input[type=button]').click(function(){
		if (validateBets()){
			$.get('${basePath}services/bet/saveBets','bets='+createBets(),function(resp){
				if (resp.code == 0){
					$('#betsSaved').dialog('open');
				}
				else{
					$('#notification').html('Mecachis, se ha producido un error en el servidor.').show();
				}
			}).error(function(){
				$('#notification').html('Mecachis, se ha producido un error desconocido en el servidor.').show();
			});
			
		}
	});
	$('#betsSaved').dialog({
		autoOpen:false,
		modal:true,
		buttons:{
			Aceptar:function(){$('#betsSaved').dialog('close')}
		}
	});
	
	function validateBets(){
		var bets=[];
		$('#notification').hide();
		var validate=true;
		$('select[data-country]').each(function(){
			if ($(this).val() == 1){
				$('#notification').html('No te pases de listo, tienes apuestas sin rellenar.').show();
				validate=false;
				return false;
			}
			else{
				bets[bets.length]=$(this).val();
			}
		});
		if (validate){
			validate=($.unique([bets[0],bets[1],bets[2],bets[3]]).length == 4) && 
				($.unique([bets[4],bets[5],bets[6],bets[7]]).length == 4) &&
				($.unique([bets[8],bets[9],bets[10],bets[11]]).length == 4) &&
				($.unique([bets[12],bets[13],bets[14],bets[15]]).length == 4);
			if (!validate){
				$('#notification').html('No te pases de listo, '+
						'no puedes repetir posición dentro de un mismo grupo.').show();
				
				
			}
			
		}
		return validate;
	}
	function createBets(){
		var bets="";
		$('select[data-country]').each(function(){
			bets+=$(this).attr('data-country')+":"+($(this).val()-1)+";";
		});
		return bets;
	}
	
	function fillBets(){
		<c:forEach items="${bets}" var="bet" varStatus="status">
			<c:set var="countryId" value="${bet.country.id}"/>
			$('select[data-country=${countryId}]').val((${bet.position}+1));
		</c:forEach>
	}
	function disableSaveBets(){
		$('#saveBets').addClass('ui-state-disabled').unbind('click');
		
	}
	
</script>