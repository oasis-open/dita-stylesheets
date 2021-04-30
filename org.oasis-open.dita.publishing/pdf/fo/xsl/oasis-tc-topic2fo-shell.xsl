<?xml version='1.0'?>

<!-- ===================== CHANGE LOG ================================ -->
<!--                                                                   -->
<!-- 16 May 2019 KJE: Original creation                                -->
<!--                                                                   -->
<!-- ================================================================= --> 

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                version="2.0">

    <xsl:import href="plugin:org.oasis-open.dita.publishing:pdf/fo/xsl/oasis-cn-topic2fo-shell.xsl"/>
    
    <xsl:import href="plugin:org.oasis-open.dita.publishing:pdf/fo/xsl/oasis-tc-front-matter.xsl"/>
    <xsl:import href="plugin:org.oasis-open.dita.publishing:pdf/fo/xsl/oasis-tc-static-content.xsl"/>
    <xsl:import href="plugin:org.oasis-open.dita.publishing:pdf/fo/attrs/oasis-tc-custom-attr.xsl"/>
    <xsl:import href="plugin:org.oasis-open.dita.publishing:pdf/fo/xsl/oasis-tc-footers.xsl"/>
    <xsl:import href="plugin:org.oasis-open.dita.publishing:pdf/fo/attrs/oasis-spec-topic-attr.xsl"/>
    
    <xsl:output method="xml" encoding="utf-8" indent="no"/>

</xsl:stylesheet>