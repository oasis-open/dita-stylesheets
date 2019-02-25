<?xml version="1.0" encoding="utf-8"?>

<!-- ===================== CHANGE LOG ================================ -->
<!--                                                                   -->
<!-- 05 Feb 2019 KJE: Added changed log                                -->
<!--                                                                   -->
<!-- ================================================================= --> 

<!-- Thomas: This file was cloned from org.dita.xhtml/xsl/dita2xhtml so 
     that overrides specific to committee notes do not affect other
     xhtml outputs that may be run from this dita-ot instance. -->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">

  <xsl:import href="plugin:org.dita.xhtml:xsl/dita2html-base.xsl"/>

  <xsl:param name="ARGS.INPUT"/>
  <xsl:param name="DITA.TEMP.DIR"/>
  

  <xsl:output method="xhtml" encoding="UTF-8" indent="no"
    doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"
    doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN"/>

  <xsl:include href="plugin:org.dita.xhtml:xsl/dita2xhtml-util.xsl"/>

  <!-- Overrides specific to committee notes xhtml output -->
  <xsl:include href="oasis-cn-dita2htmlImpl.xsl"/>
  <xsl:include href="oasis-cn-dita2htmlToc.xsl"/>

  <!-- Add both lang and xml:lang attributes -->
  <xsl:template match="@xml:lang" name="generate-lang">
    <xsl:param name="lang" select="."/>
    <xsl:attribute name="xml:lang">
      <xsl:value-of select="$lang"/>
    </xsl:attribute>
    <xsl:attribute name="lang">
      <xsl:value-of select="$lang"/>
    </xsl:attribute>
  </xsl:template>


</xsl:stylesheet>
