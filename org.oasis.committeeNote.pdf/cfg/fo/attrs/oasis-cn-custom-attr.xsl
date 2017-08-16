<?xml version='1.0'?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:fo="http://www.w3.org/1999/XSL/Format" version="2.0">
 
 <!-- ===================== CHANGE LOG ================================ -->
 <!--                                                                   -->
 <!-- 05 Sep 2015: Eberlein, added change log.                          -->
 <!-- 29 Oct 2016: Eberlein, added import for XML mention domain attrs. -->
 <!-- 25 May 2017: Eberlein, added import for programming domain attrs. -->
 <!-- 15 Aug 2017: Eberlein, removed import statements, which were      -->
 <!--              moved to oasis-cn-topic2fo-shell.xsl.                -->
 <!-- ================================================================= -->
  
 <!-- Used in the topic.title and __toc__header attribute sets -->
 <xsl:attribute-set name="horizontal-rule">
  <xsl:attribute name="border-top-color">#888888</xsl:attribute>
  <xsl:attribute name="border-top-style">solid</xsl:attribute>
  <xsl:attribute name="border-top-width">1px</xsl:attribute>
 </xsl:attribute-set>
 
</xsl:stylesheet>