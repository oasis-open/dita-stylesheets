<?xml version='1.0'?>

<!-- ===================== CHANGE LOG ================================ -->
<!--                                                                   -->
<!-- 27 Aug 2015 KJE: Removed indentation from cover page              -->
<!-- 05 Sep 2015 KJE: Consolidated attribute sets. Added attribute     -->
<!--                  sets for the left flow on the cover.             -->
<!-- 01 Feb 2019 KJE: Implemented OASIS redesign for committee note:   -->
<!--                  removed attribute sets for cover page sidebar;   -->
<!--                  added attribute set for cover page header        -->
<!-- 07 Mar 2019 KJE: Changed serif to sans-serif                      -->
<!--                                                                   -->
<!-- ================================================================= -->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:fo="http://www.w3.org/1999/XSL/Format" 
                version="2.0">
 
 <!-- KJE: This styles the content immediately above the document title. -->
 <xsl:attribute-set name="oasis-cover-header">
  <xsl:attribute name="border-bottom-color">#888888</xsl:attribute>
  <xsl:attribute name="border-bottom-style">solid</xsl:attribute>
  <xsl:attribute name="border-bottom-width">1px</xsl:attribute>
  <xsl:attribute name="color">#707070</xsl:attribute>
  <xsl:attribute name="font-family">sans-serif</xsl:attribute>
  <xsl:attribute name="font-size">18pt</xsl:attribute>
  <xsl:attribute name="font-weight">bold</xsl:attribute>
  <xsl:attribute name="keep-with-next">always</xsl:attribute>
  <xsl:attribute name="padding-top">10pt</xsl:attribute>
  <xsl:attribute name="text-align">left</xsl:attribute>
 </xsl:attribute-set>
 
 <xsl:attribute-set name="oasis-cover-font">
  <xsl:attribute name="color">#446CAA</xsl:attribute>
  <xsl:attribute name="font-family">sans-serif</xsl:attribute>
  <xsl:attribute name="font-weight">bold</xsl:attribute>
  <xsl:attribute name="keep-with-next">always</xsl:attribute>
  <xsl:attribute name="text-align">left</xsl:attribute>
 </xsl:attribute-set>
 
 <xsl:attribute-set name="main-document-title" use-attribute-sets="oasis-cover-font">  
  <xsl:attribute name="border">none</xsl:attribute>
  <xsl:attribute name="font-size">24pt</xsl:attribute>  
  <xsl:attribute name="margin-bottom">10pt</xsl:attribute>
  <xsl:attribute name="margin-top">10pt</xsl:attribute>
  <xsl:attribute name="padding-before">4pt</xsl:attribute>
 </xsl:attribute-set>
 
 <xsl:attribute-set name="oasis-h2" use-attribute-sets="oasis-cover-font">
  <xsl:attribute name="font-size">18pt</xsl:attribute>
  <xsl:attribute name="margin-bottom">11pt</xsl:attribute>
 </xsl:attribute-set>
 
 <xsl:attribute-set name="oasis-h3" use-attribute-sets="oasis-cover-font">
  <xsl:attribute name="font-size">12pt</xsl:attribute>
 </xsl:attribute-set>
 
 <xsl:attribute-set name="cover_category_label" use-attribute-sets="oasis-cover-font">
  <xsl:attribute name="font-size">12pt</xsl:attribute>
  <xsl:attribute name="margin-top">8pt</xsl:attribute>
 </xsl:attribute-set>
 
 <xsl:attribute-set name="cover_p">  
  <xsl:attribute name="space-after">0.6em</xsl:attribute>
  <xsl:attribute name="text-indent">0em</xsl:attribute>
 </xsl:attribute-set>
 
 <xsl:attribute-set name="cover_sl">
  <xsl:attribute name="keep-with-previous.within-page">always</xsl:attribute>
  <xsl:attribute name="provisional-distance-between-starts">0mm</xsl:attribute>
  <xsl:attribute name="provisional-label-separation">0mm</xsl:attribute>
 </xsl:attribute-set>
 
 <xsl:attribute-set name="cover_xref" use-attribute-sets="common.link">
  <xsl:attribute name="font-style">normal</xsl:attribute>
  <xsl:attribute name="text-decoration">underline</xsl:attribute>
 </xsl:attribute-set>
 
 <xsl:attribute-set name="frontmatter-indent">
  <!-- Eberlein 27 August 2015: Commented this out to remove identation from cover page. -->
  <!-- <xsl:attribute name="margin-left">0.5in</xsl:attribute>-->
 </xsl:attribute-set>

</xsl:stylesheet>