<?xml version="1.0" encoding="UTF-8"?>
<!--
This file is part of the DITA Open Toolkit project.

Copyright 2014 Jarno Elovirta

See the accompanying LICENSE file for applicable license.
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:fo="http://www.w3.org/1999/XSL/Format" version="2.0">

  <xsl:template match="*[contains(@class, ' xml-d/xmlatt ')]">
    <fo:inline xsl:use-attribute-sets="xmlatt">
      <xsl:call-template name="commonattributes"/>
      <xsl:apply-templates/>
    </fo:inline>
  </xsl:template>

  <!-- Tagsmiths: Move @ insertion to the text node so that flagging will not separate
        the @ symbol from the attribute name. 30jul17-->
  <xsl:template match="*[contains(@class, ' xml-d/xmlatt ')]/text()">
    <xsl:if test="normalize-space(.) != ''">
      <!-- Tagsmiths: Only insert the @ symbol when the text node isn't white-space. 30jul17 -->
      <xsl:text>@</xsl:text>
    </xsl:if>
    <xsl:value-of select="."/>
  </xsl:template>

</xsl:stylesheet>
