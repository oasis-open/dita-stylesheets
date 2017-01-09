<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                version="2.0"
                exclude-result-prefixes="xs">

 <!-- ===================== CHANGE LOG ================================ -->
 <!--                                                                   -->
 <!-- 5 Sept 2015: Eberlein, added change log.                          -->
 <!-- ================================================================= --> 
              
  <!-- Page size -->
  <xsl:variable name="page-width">8.5in</xsl:variable>
  <xsl:variable name="page-height">11.0in</xsl:variable>

  <!-- Page margins -->
  <xsl:variable name="page-margin-inside">1.25in</xsl:variable>
  <xsl:variable name="page-margin-outside">1.25in</xsl:variable>
  <xsl:variable name="page-margin-top">1in</xsl:variable>
  <xsl:variable name="page-margin-bottom">1in</xsl:variable>
  <xsl:variable name="mirror-page-margins" select="true()"/>
              
  <!--The side column width is the amount that body text is indented relative to the margin. -->
  <xsl:variable name="side-col-width">0pt</xsl:variable>           
     
  <!-- Font size and line height -->
  <xsl:variable name="default-font-size">11pt</xsl:variable>
  <xsl:variable name="default-line-height">12pt</xsl:variable>
                       
</xsl:stylesheet>
