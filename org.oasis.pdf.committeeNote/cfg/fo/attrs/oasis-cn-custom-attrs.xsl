<?xml version='1.0'?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:fo="http://www.w3.org/1999/XSL/Format" version="2.0">
 
 <!-- ===================== CHANGE LOG ================================ -->
 <!--                                                                   -->
 <!-- 05 Sep 2015: Eberlein, added change log.                          -->
 <!-- 29 Oct 2016: Eberlein, added import for XML mention domain attrs. -->
 <!-- ================================================================= -->
 
 <!-- IMPORT OVERRIDES TO DITA-OT ATTRIBUTE FILES -->
 <xsl:import href="oasis-cn-basic-settings.xsl"/>
 <xsl:import href="oasis-cn-commons-attr.xsl"/>
 <xsl:import href="oasis-cn-static-content-attr.xsl"/>
 <xsl:import href="oasis-cn-tables-attr.xsl"/>
 <xsl:import href="oasis-cn-toc-attr.xsl"/>
 <xsl:import href="oasis-xml-domain-attr.xsl"/>
 
 <!-- IMPORT CUSTOM OASIS ATTRIBUTE FILES -->
 <xsl:import href="oasis-cn-cover-attrs.xsl"/>
 
 
 <!-- Used in the topic.title and __toc__header attribute sets -->
 <xsl:attribute-set name="horizontal-rule">
  <xsl:attribute name="border-top-color">#888888</xsl:attribute>
  <xsl:attribute name="border-top-style">solid</xsl:attribute>
  <xsl:attribute name="border-top-width">1px</xsl:attribute>
 </xsl:attribute-set>
 
</xsl:stylesheet>