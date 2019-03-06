<?xml version='1.0'?>

<!-- ===================== CHANGE LOG ================================ -->
<!--                                                                   -->
<!-- 05 Sep 2015KJE: Added change log. Added $toc.toc-indent.          -->
<!-- ================================================================= --> 

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:fo="http://www.w3.org/1999/XSL/Format"
                version="2.0">
    
    <!-- Controls indentation within the TOC -->
    <xsl:variable name="toc.toc-indent" select="'.2in'"/>
    
    <!-- Common formatting for many items in the TOC -->  
    <xsl:attribute-set name="default-TOC">
        <xsl:attribute name="font-size">11pt</xsl:attribute>
        <xsl:attribute name="font-weight">normal</xsl:attribute>
        <xsl:attribute name="padding-top">0pt</xsl:attribute>
    </xsl:attribute-set>

    <!-- Controls formatting of the auto-generated title on first page of TOC -->
    <xsl:attribute-set name="__toc__header" use-attribute-sets="common.title">
        <xsl:attribute name="font-size">18pt</xsl:attribute>
        <xsl:attribute name="margin-top">0pt</xsl:attribute>
        <xsl:attribute name="margin-bottom">8.4pt</xsl:attribute>
        <xsl:attribute name="padding-top">2pt</xsl:attribute>
    </xsl:attribute-set>
    
    <!-- Controls formatting of the topic titles in the TOC -->
    <xsl:attribute-set name="__toc__title" use-attribute-sets="default-TOC">
    </xsl:attribute-set>
    
    <!-- Controls formatting of the chapter titles in the TOC -->
    <xsl:attribute-set name="__toc__chapter__content" use-attribute-sets="default-TOC">
    </xsl:attribute-set>
    
    <!-- Controls formatting of the appendix titles in the TOC -->   
    <xsl:attribute-set name="__toc__appendix__content" use-attribute-sets="default-TOC">
    </xsl:attribute-set>

</xsl:stylesheet>