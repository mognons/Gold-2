<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE h2 PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script type="text/JavaScript">
// Groups
var enteUtente = '<s:property value="ente"/>';
var gruppoUtente = '<s:property value="groupId"/>';
<!--  // building select nav for mobile width only -->
$(function(){
	// building select menu
	$('<select />').appendTo('nav');

	// building an option for select menu
	$('<option />', {
		'selected': 'selected',
		'value' : '',
		'text': 'Choise Page...'
	}).appendTo('nav select');

	$('nav ul li a').each(function(){
		var target = $(this);

		$('<option />', {
			'value' : target.attr('href'),
			'text': target.text()
		}).appendTo('nav select');

	});

	// on clicking on link
	$('nav select').on('change',function(){
		window.location = $(this).find('option:selected').val();
	});
});

// show and hide sub menu
$(function(){
	$('nav li').hover(
		function () {
			//show its submenu
			$('ul', this).slideDown(150);
		}, 
		function () {
			//hide its submenu
			$('ul', this).slideUp(150);			
		}
	);
});

//end
$(document).ready(function () {
	// This moves "crumbs" around, based on current selection
	$('nav li').on('click', function(block) {
		if ($(this).hasClass('topLevel')) {
			$(this).parent().find('.current').removeClass('current');
			$(this).addClass('current');
		} else {
			$(this).closest('.topLevel').parent().find('.current').removeClass('current');
			$(this).closest('.topLevel').addClass('current');
			$(this).parent().find('a').removeClass('subCurrent');
			$(this).find('a').addClass('subCurrent');			
		}
		block.stopPropagation();
// 		return false;
	});

	var newMessages = false;
	<s:if test="newMessages">newMessages=true</s:if>
	if (newMessages) {
	    $( "#msg-dialog" ).dialog({
	        resizable: false,
	        height:150,
	        width: 400,
	        modal: true,
	        buttons: {
	          "Vai": function() {
	            $(this).dialog("close");
	      		window.location.replace("home.action");		
	          },
	          "Ignora": function() {
	            $(this).dialog("close");
	          }
	        }
	      });
	}
});

</script>
</head>
<body>
	<!-- Builds Auth switches  -->
	<s:if test="%{groupId == 1}">
		<s:set var="isAdmin" value="%{'true'}" />
	</s:if>
	<s:elseif test="%{groupId == 2}">
		<s:set var="isAdminEnte" value="%{'true'}" />
	</s:elseif>
	<s:elseif test="%{groupId == 3}">
		<s:set var="isUser" value="%{'true'}" />
	</s:elseif>
	<s:elseif test="%{groupId == 4}">
		<s:set var="isRegione" value="%{'true'}" />
	</s:elseif>

	<div class="ui-widget-content" style="position: relative">
		<table border="0" width="100%">
			<tr style="vertical-align:bottom">
				<td width="25%" ><a href="home.action"><img
						src="images/logo-gold.png" height="67"
						width="160"></a></td>
				<td width="40%">
				</td>
				<td align="RIGHT"> <a href="profileLink">
						<span style="color:#FFF2B3; font-size:larger;">
								<s:property value="user.userFirstname"></s:property>
								<s:property value="user.userLastname"></s:property>
						</span>
						<s:if test="user.ente">
				 			<span style="color:#F3971F; font-size:smaller;">
				 				<s:property value="user.descrizioneEnte"/>
				 			</span>
						</s:if>
					</a>
				</td>
			</tr>
		</table>
		<div id="fdw">
		<!--nav-->
			<nav>
				<ul>
					<li class="current topLevel"><a href="home">Home</a></li>
					<li class="topLevel"><a href="#">Assistiti<span class="arrow"></span></a>
						<ul style="display:none;" class="sub_menu">
							<li class="arrow_top"></li>
							<li><a class="singleItem subCurrent" href="assistitiLink">Anagrafica</a></li>
							<li><a class="singleItem" href="candidatureLink">Candidatura Emporio</a></li>
							<li><a class="singleItem" href="rimozioneEmporioLink">Rimozione Emporio</a></li>
						</ul>
					</li>
					<s:if test="(enteEmporio)" >
						<li class="topLevel">><a href="#">Utenti Emporio<span class="arrow"></a>
							<ul style="display: none;" class="sub_menu">
								<li class="arrow_top"></li>	
								<li><a class="subCurrent singleItem" href="accettazioneEmporioLink">Accettazione</a></li>
								<li><a class="singleItem" href="dismissioneEmporioLink">Dimissione</a></li>
								<li><a class="singleItem" href="anagraficaEmporioLink">Anagrafica</a></li>
							</ul>
						</li>
					</s:if>
					<s:if test="(groupId == 2 || groupId == 3)" >
						<li class="topLevel"><a href="#">Eccedenze<span class="arrow"></a>
							<ul style="display: none;" class="sub_menu">
								<li class="arrow_top"></li>	
								<li><a class="subCurrent singleItem" href="eccedenzeLink">Segnalazione</a></li>
								<li><a class="singleItem" href="impegniLink">Prenotazione</a></li>
								<li><a class="singleItem" href="ritiriLink">Elenco Prenotazioni</a></li>
							</ul>
						</li>
					</s:if>
					<s:if test="(groupId != 1)" >
						<li class="topLevel">
							<a href="#">report<span class="arrow"></span></a>
							<ul style="display: none;" class="sub_menu">
								<li class="arrow_top"></li>
								<s:if test="(groupId == 4)" >
									<li> 
										<a class="singleItem" href="anagraficaCompletaReport">Elenco Regionale</a>
									</li>
								</s:if>
								<s:if test="(groupId == 2)" >
									<li> 
										<a class="singleItem" href="anagraficaXProvinciaEnteUserReport">Elenco per Provincia</a>
									</li>
								</s:if>
								<s:if test="(groupId >= 2)" >
									<li> 
										<a class="singleItem" href="graduatoriaProvincialeReport">Elenco per Ente</a>
									</li>
								</s:if>
								<s:if test="(groupId == 2)" >
									<li> 
										<a class="singleItem" href="anagraficaEnteUserReport">Graduatoria Provinciale</a>
									</li>
								</s:if>
								<s:if test="(groupId == 2)" >
									<li> 
										<a class="singleItem" href="situazioneEccedenzeReport">Situazione Eccedenze</a>
									</li>
								</s:if>
							</ul>
						</li>
					</s:if>
					<s:if test="(#isAdmin || #isAdminEnte)">
					<li class="topLevel">
						<a href="#">sistema<span class="arrow"></span></a>
						<ul style="display: none;" class="sub_menu">
							<li class="arrow_top"></li>
							<li><a class="singleItem" href="usersLink">Utenti</a></li>
							<s:if test="(#isAdmin)">
								<li><a class="singleItem" href="entiLink">Tabella Enti</a></li>
								<li><a class="singleItem" href="nazioniLink">Tabella Nazioni</a></li>
								<li><a class="singleItem" href="provinceLink">Tabella Province</a></li>
								<li><a class="singleItem" href="uni_misuraLink">Tabella Unità di misura</a></li>
								<li><a class="singleItem" href="gradi_parentelaLink">Tabella Gradi di Parentela</a></li>
								<li><a class="singleItem" href="stati_civiliLink">Tabella Stati Civili</a></li>
								<li><a class="singleItem" href="messagesLink">Messaggi</a></li>
								<li><a class="singleItem" href="exportLink">Export Dati</a></li>
							</s:if>
						</ul>
					</li>
					</s:if>
					<li class="topLevel">
						<img src="icons/Power-Shutdown.png" align="top" height="22" width="22">
						<a href="Logout">logout</a>
					</li>
				</ul>
			</nav>
			
	</div><!-- end fdw -->
	</div>
	<div style="display:none;" id="msg-dialog" title="Informazione dal sistema">
	  <p><span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;">
	  </span>Ci sono nuovi messaggi: vuoi vederli?</p>
	</div>	
</body>
</html>