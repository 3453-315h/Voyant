<% request.setAttribute("lang", "fr"); %><%@ include file="../resources/jsp/pre_app.jsp" %>

<script>
	Ext.Loader.setConfig({
		enabled : true,
		paths : {
			'Voyant' : '../app',
			'resources': '../resources'
		}
	});

 	Ext.define('Voyant.panel.Pblit', {
 	 	extend: 'Voyant.panel.Catalogue',
 	 	statics: {
 	 	 	i18n: {
 	 	 	 	"facet.extra.collectionTitle": "Collections",
 	 	 	 	helpTip: "PBLit (PolyBase litt�raire) est un projet exp�rimental qui vise � d�velopper des strat�gies pour l'exploitation simultan�e de multiples base de donn�es et sources de textes num�ris�s. De nombreuses ressources existent pour les litt�raires, mais les donn�es sont presque toujours disponibles uniquement � partir de l'interface de chaque ressource individuelle. PBLit offre un mod�le prototype pour la navigation et la recherche dans de multiples ressources litt�raires."
 	 	 	}
 	 	},
		alias: 'widget.pblit',
		helpToolClick: function() {
			panel = this.up('panel');
			Ext.Msg.alert('PBLit', panel.localize('helpTip')+"<p>Pour plus d'informations, visiter <a href='http://digihum.mcgill.ca/pblit/' target='_blank'>digihum.mcgill.ca/pblit</a>.</p>")
		}
	})
	
	Ext.application({
		extend : 'Voyant.VoyantCorpusApp',
		requires: ['Voyant.panel.Subset'],
		name: 'VoyantDreamApp',
		config: {
			baseUrl: '<%= org.voyanttools.voyant.Voyant.getBaseUrlString(request) %>',
			version: '<%= application.getInitParameter("version") %>',
			build: '<%= application.getInitParameter("build") %>'			
		},
		statics: {
	    	i18n: {
	    		pubDateTip: {en: "Workset Builder"},
	    		pubDate: {en: "Publication Year"},
	    		pubDateCountTip: {en: "This is the number of documents whose publication year matches the specified range."},
	    		pubDateHelpTip: {en: "Use the slider to determine the start and end year range of publications."}
	    	}
		},
	    launch: function() {

	    	if (!this.hasQueryToLoad()) {
		    	location.replace("?corpus=dream")
	    	}

			// get current markup and then dispose of it
			var headerEl = document.querySelector("body > section");
			var introHtml = headerEl.outerHTML;
			headerEl.remove();
			
			var me = this;

			
			Ext.create('Ext.container.Viewport', {
			    layout: 'fit',
			    cls: 'dream-body',
			    items: [{
				    xtype: 'pblit',
				    title: 'PBLit',
				    customResultsHtml:introHtml,
				    listeners: {
					    beforerender: function() {
						    this.setApiParam('facet', ['facet.extra.collection', 'facet.author', 'facet.title', 'facet.extra.topos'])
						}
					}
			    }]
			});

			this.callParent(arguments);

		}
	});
</script>
<style>
/* Page */
div#page {
	padding: 0px;
	position: relative;
	min-height: 100%;
	background-color: #FFFFF3;
}

/* Header */
#header {
	background-color: #E2F3FF;
	width: 100%;
	height: 100px;
}

#header a {
	color: #36393D;
	text-decoration: none;
	font-size: 16px;
	letter-spacing: -1px;
}
/* HEADER */
#logo {
	display: block;
	float: left;
	margin: 0px 0px 0px 10px;
	width: 226px;
	height: 100px;
	cursor: pointer;
	background-image: url('pblit_logo.png');
	background-repeat: no-repeat;
}
div#content {
	width: 100%;
	height: 100%;
	border-top: 3px solid #36393D;
	margin: 0px;
	padding: 0px;
}
#fullCol {
	margin: 10px;
	padding: 15px;
	background-color: #FFFFFF;
	border: 1px solid #EEEEEE;
}

</style>
<title>PBLit</title>
</head>
<body>

<section>
<div id="page">
		<div id="header">
			<a id="logo" href="./" style="cursor: pointer;"></a>
		</div>
		<div id="content">

<div>
	<!-- LEFT COLUMN -->
	<div id="fullCol">
			<h2>Pr�sentation</h2>
			<div>
				<p>PBLit (PolyBase litt�raire) est un projet exp�rimental qui vise �
					d�velopper des strat�gies pour l'exploitation simultan�e de
					multiples base de donn�es et sources de textes num�ris�s. De
					nombreuses ressources existent pour les litt�raires, mais les
					donn�es sont presque toujours disponibles uniquement � partir de
					l'interface de chaque ressource individuelle. PBLit offre un mod�le
					prototype pour la navigation et la recherche dans de multiples
					ressources litt�raires.</p>
				<p>Les cinq ressources disponibles actuellement sont les suivantes:</p>
				<ol>
					<li><a href="http://www.satorbase.org/">SatorBase</a>, une base de
						donn�es relationnelle de topo� dans la
						litt�rature fran�aise de 1200 � 1800</li>
					<li><a href="http://tapor.mcmaster.ca/%7Ehyperliste/">Hyperliste</a>,
						une base de donn�es d'�num�rations
						dans la litt�rature fran�aise de 1200 � 1500</li>
					<li>Le Th�saurus du motif merveilleux</li>
					<li><a href="http://digihum.mcgill.ca/toucher/">Toucher</a>, une
						s�lection de textes litt�raires int�graux</li>
					<li>Articles savants relatifs � la topique narrative</li>
				</ol>
			</div>
	</div>
</div>

	</div>
</section>

</body>
</html>