<?xml version='1.0'?>

<!-- ===================== CHANGE LOG ================================ -->
<!--                                                                   -->
<!-- 05 Sep 2015 KJE: Added change log.                                -->
<!-- 29 Oct 2016 KJE: Added import for XML mention domain attrs.       -->
<!-- 25 May 2017 KJE: Added import for programming domain attrs.       -->
<!-- 15 Aug 2017 KJE: Removed import statements, which were moved      -->
<!--                  to oasis-cn-topic2fo-shell.xsl.                  -->
<!-- ================================================================= -->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:fo="http://www.w3.org/1999/XSL/Format" version="2.0">
  
 <!-- Formerly used in the topic.title and __toc__header attribute sets. Now set in region-before -->
 <xsl:attribute-set name="horizontal-rule">
  <xsl:attribute name="border-top-color">#888888</xsl:attribute>
  <xsl:attribute name="border-top-style">solid</xsl:attribute>
  <xsl:attribute name="border-top-width">1px</xsl:attribute>
 </xsl:attribute-set>
 
 <!-- New OASIS template does not have footer rule -->
 <xsl:attribute-set name="committee-note-footer">
<!--  <xsl:attribute name="border-top-color">#888888</xsl:attribute>
  <xsl:attribute name="border-top-style">solid</xsl:attribute>
  <xsl:attribute name="border-top-width">1px</xsl:attribute>-->
  <xsl:attribute name="margin-bottom">0.625in</xsl:attribute>
  <xsl:attribute name="margin-left">1in</xsl:attribute>
  <xsl:attribute name="margin-right">1in</xsl:attribute>
 </xsl:attribute-set>
 
 

</xsl:stylesheet>