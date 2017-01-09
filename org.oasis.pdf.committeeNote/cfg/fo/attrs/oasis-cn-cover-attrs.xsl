<?xml version='1.0'?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:fo="http://www.w3.org/1999/XSL/Format" version="2.0">
 
 <!-- ===================== CHANGE LOG ================================ -->
 <!--                                                                   -->
 <!-- 5 Sept 2015: Eberlein, consolidated attribute sets. Added         -->
 <!--              attribute sets for the left flow on the coverr.      -->
 <!-- ================================================================= -->
 
 <!-- LEFT FLOW -->
 <xsl:attribute-set name="cover-sidebar">
  <xsl:attribute name="background-color">#3B006F</xsl:attribute>
  <xsl:attribute name="display-align">center</xsl:attribute>
  <xsl:attribute name="height">100%</xsl:attribute>
  <xsl:attribute name="width">100%</xsl:attribute>
 </xsl:attribute-set>
 
 <xsl:attribute-set name="cover-sidebar-text">
  <xsl:attribute name="color">white</xsl:attribute>
  <xsl:attribute name="line-height">150%</xsl:attribute>
  <xsl:attribute name="margin-left">0.125in</xsl:attribute>
  <xsl:attribute name="margin-right">0.375in</xsl:attribute>
  <xsl:attribute name="text-align">justify</xsl:attribute>
 </xsl:attribute-set>
 
 <!-- RIGHT FLOW -->
 <xsl:attribute-set name="main-document-title" use-attribute-sets="oasis_header_font">
  <xsl:attribute name="text-align">left</xsl:attribute>
  <xsl:attribute name="font-size">24pt</xsl:attribute>
  <xsl:attribute name="padding-before">4pt</xsl:attribute>
  <xsl:attribute name="margin-bottom">10pt</xsl:attribute>
  <xsl:attribute name="border">none</xsl:attribute>
 </xsl:attribute-set>
 
 <xsl:attribute-set name="oasis_header_font">
  <xsl:attribute name="color">#A1985A</xsl:attribute>
  <xsl:attribute name="font-family">serif</xsl:attribute>
  <xsl:attribute name="font-weight">normal</xsl:attribute>
  <xsl:attribute name="keep-with-next">always</xsl:attribute>
  <xsl:attribute name="text-align">left</xsl:attribute>
 </xsl:attribute-set>
 
 <xsl:attribute-set name="oasis-h2" use-attribute-sets="oasis_header_font">
  <xsl:attribute name="font-size">16pt</xsl:attribute>
  <xsl:attribute name="font-weight">normal</xsl:attribute>
  <xsl:attribute name="margin-bottom">11pt</xsl:attribute>
 </xsl:attribute-set>
 
 <xsl:attribute-set name="oasis-h3" use-attribute-sets="oasis_header_font">
  <xsl:attribute name="font-size">14pt</xsl:attribute>
  <xsl:attribute name="font-weight">bold</xsl:attribute>
  <xsl:attribute name="color">#A1985A</xsl:attribute>
  <xsl:attribute name="font-family">serif</xsl:attribute>
 </xsl:attribute-set>
 
 <xsl:attribute-set name="cover_category_label" use-attribute-sets="oasis_header_font">
  <xsl:attribute name="font-size">12pt</xsl:attribute>
  <xsl:attribute name="font-weight">bold</xsl:attribute>
  <xsl:attribute name="margin-top">8pt</xsl:attribute>
 </xsl:attribute-set>
 
 <xsl:attribute-set name="frontmatter-indent">
  <!-- Eberlein 27 Augist 2015: Commented this out to remove identation from cover page. -->
  <!-- <xsl:attribute name="margin-left">0.5in</xsl:attribute>-->
 </xsl:attribute-set>
 
 <xsl:attribute-set name="cover_p">
  <xsl:attribute name="text-indent">0em</xsl:attribute>
  <xsl:attribute name="space-after">0.6em</xsl:attribute>
 </xsl:attribute-set>
 
 <xsl:attribute-set name="cover_sl">
  <xsl:attribute name="provisional-distance-between-starts">0mm</xsl:attribute>
  <xsl:attribute name="provisional-label-separation">0mm</xsl:attribute>
  <xsl:attribute name="keep-with-previous.within-page">always</xsl:attribute>
 </xsl:attribute-set>
 
 <xsl:attribute-set name="cover_xref" use-attribute-sets="common.link">
  <xsl:attribute name="font-style">normal</xsl:attribute>
  <xsl:attribute name="text-decoration">underline</xsl:attribute>
 </xsl:attribute-set>

</xsl:stylesheet>