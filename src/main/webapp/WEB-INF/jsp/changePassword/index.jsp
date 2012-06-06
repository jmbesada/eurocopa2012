<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<div id="notification" class="ui-state-error" 
	style="width:350px;display:none;line-height:2em;padding-left:3px"></div>
<form action="${basePath}services/changePassword/modify">
	<fieldset>
		<table cellpadding="3">
			<tr>
				<td>Nueva contraseña:</td>
				<td><input type="password" name="newPassword" value=""/></td>
			</tr>
			<tr>  
				<td>Repite nueva contraseña:</td>
				<td><input type="password" name="repeatNewPassword" value=""/></td>
			</tr>
			<tr>
				<td colspan="2">
					<input id="modifyPassword" type="button" value="Modificar"/>
				</td>
			</tr>
		</table>
	</fieldset>
</form>

<div id="credentialsSaved" title="Mensaje del sistema">
	Congratulations !!!!!!!!!!!!!!!. Credenciales correctamente modificados.
</div>
<script>
	$(document).ready(function(){
		$('#modifyPassword').button().click(function(){
			$.getJSON($('form').attr('action'),$('form').serialize(),function(resp){
				if (resp.code == 0) {
					$('#credentialsSaved').dialog('open');
				}
				else $('#notification').html('Los dos campos han de ser iguales borrico !!!!!!').show();
			});
		
		});
		
		$('#credentialsSaved').dialog({
			autoOpen:false,
			modal:true,
			buttons:{
				Aceptar:function(){$('#credentialsSaved').dialog('close')}
			}
		})
	});
	
	
</script>