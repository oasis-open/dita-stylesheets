<?xml version="1.0" encoding="utf-8"?>

<!-- ===================== CHANGE LOG ================================ -->
<!--                                                                   -->
<!-- 05 Sep 2015 KJE: Added change log.                                -->
<!-- 03 Mar 2019 ARH: Changed page margins, font sizes, and            -->
<!--                  page-margin-top to accommodated OASIS rebranding -->
<!--                                                                   -->
<!-- ================================================================= --> 

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                version="2.0"
                exclude-result-prefixes="xs">

 <!-- Thomas: Extract the base filename from args.input. 06dec17  -->
  <xsl:param name="args.input"/>
  <!-- Thomas: use regex to strip off the directory portion of the filename and to
       remove the .ditamap file extension. 06dec17-->
  <xsl:variable name="inputfile.basename" select="replace($args.input, '.+[\\/](.+)?.ditamap', '$1')"/>
          
  <!-- Page size -->
  <xsl:variable name="page-width">8.5in</xsl:variable>
  <xsl:variable name="page-height">11.0in</xsl:variable>

  <!-- Page margins -->
  <xsl:variable name="page-margin-inside">1.0in</xsl:variable>
  <xsl:variable name="page-margin-outside">1.0in</xsl:variable>
  <!-- Added .2in to top margin to prevent text crashing into heading rule -->
  <xsl:variable name="page-margin-top">1.2in</xsl:variable>
  <xsl:variable name="page-margin-bottom">1.0in</xsl:variable>
  <xsl:variable name="mirror-page-margins" select="true()"/>
              
  <!--The side column width is the amount that body text is indented relative to the margin. -->
  <xsl:variable name="side-col-width">0pt</xsl:variable>           
     
  <!-- Font size and line height -->
  <xsl:variable name="default-font-size">10pt</xsl:variable>
  <xsl:variable name="default-line-height">11pt</xsl:variable>
                       
</xsl:stylesheet>
