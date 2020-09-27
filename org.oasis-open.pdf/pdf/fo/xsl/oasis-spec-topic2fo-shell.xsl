<?xml version='1.0'?>

<!-- ===================== CHANGE LOG ================================ -->
<!--                                                                   -->
<!-- 08 May 2019 KJE: Original creation                                -->
<!-- 16 May 2019 KJE: Changed name of plug-in                          -->
<!-- 25 Sep 2020 KJE: Added import for oasis-spec-custom-xsl.xsl       -->
<!--                                                                   -->
<!-- ================================================================= --> 

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                version="2.0">

    <xsl:import href="plugin:org.oasis-open.pdf:pdf/fo/xsl/oasis-cn-topic2fo-shell.xsl"/>
    
    <xsl:import href="plugin:org.oasis-open.pdf:pdf/fo/xsl/oasis-spec-front-matter.xsl"/>
    <xsl:import href="plugin:org.oasis-open.pdf:pdf/fo/xsl/oasis-spec-footers.xsl"/>
    <xsl:import href="plugin:org.oasis-open.pdf:pdf/fo/attrs/oasis-spec-topic-attr.xsl"/>
    <xsl:import href="plugin:org.oasis-open.pdf:pdf/fo/xsl/oasis-spec-custom-xsl.xsl"/>
    
    <xsl:output method="xml" encoding="utf-8" indent="no"/>

</xsl:stylesheet>