<?xml version="1.0"?>

<!-- ===================== CHANGE LOG ================================ -->
<!--                                                                   -->
<!-- 15 May 2019 KJE: Initial creation                                 -->
<!-- 08 Nov 2021 RDA: Override link__shortdesc                         -->
<!--                                                                   -->
<!-- ================================================================= -->

<xsl:stylesheet 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:fo="http://www.w3.org/1999/XSL/Format" version="2.0">

  <!-- Margin set here affects the "Related information" label and -->
  <!-- the topic title and page number, but not the content of the -->
  <!-- short desc.                                                 -->
  <xsl:attribute-set name="linklist">
    <xsl:attribute name="margin-left">20pt</xsl:attribute>
    <xsl:attribute name="padding-bottom">10pt</xsl:attribute>
  </xsl:attribute-set>

  <!-- Styles the "Related concepts | reference | information" label -->
  <xsl:attribute-set name="linklist.title">
  </xsl:attribute-set>
 
  <!-- Thist styles the content of the shortdesc, also page number -->
  <!-- Adds addiitonal margin past what set for "Related concepts  -->
  <xsl:attribute-set name="link">
    <!--<xsl:attribute name="color">red</xsl:attribute>-->
    <!--<xsl:attribute name="margin-left">20pt</xsl:atribute>-->
  </xsl:attribute-set>
  
  <!-- Override link shortdesc so that start indent is inherited from
       active indent for related links, rather than getting a new indent -->
  <xsl:attribute-set name="link__shortdesc">
    <xsl:attribute name="start-indent">inherit</xsl:attribute>
    <xsl:attribute name="space-after">5pt</xsl:attribute>
  </xsl:attribute-set>

</xsl:stylesheet>
