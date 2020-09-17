<?xml version='1.0'?>

<!-- ===================== CHANGE LOG ================================ -->
<!--                                                                   -->
<!-- 08 May 2019 KJE: Original creation                                -->
<!-- 16 May 2019 KJE: Changed name of plug-in                          -->
<!--                                                                   -->
<!-- ================================================================= --> 

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                version="2.0">

    <xsl:import href="plugin:org.oasis-open.pdf:cfg/fo/xsl/oasis-cn-topic2fo-shell.xsl"/>
    
    <xsl:import href="plugin:org.oasis-open.pdf:cfg/fo/xsl/oasis-spec-front-matter.xsl"/>
    <xsl:import href="plugin:org.oasis-open.pdf:cfg/fo/xsl/oasis-spec-footers.xsl"/>
    <xsl:import href="plugin:org.oasis-open.pdf:cfg/fo/attrs/oasis-spec-topic-attr.xsl"/>
    <!--<xsl:import href="plugin:org.oasis-open.pdf:cfg/fo/xsl/oasis-rfclist.xsl"/>-->
    
    <xsl:output method="xml" encoding="utf-8" indent="no"/>

</xsl:stylesheet>