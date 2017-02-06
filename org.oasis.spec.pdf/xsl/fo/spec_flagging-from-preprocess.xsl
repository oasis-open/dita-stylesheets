<?xml version="1.0" encoding="UTF-8"?>
<!--
This file is part of the DITA Open Toolkit project.

Copyright 2015 IBM Corporation
See the accompanying LICENSE file for applicable license.
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:fo="http://www.w3.org/1999/XSL/Format"
  xmlns:dita-ot="http://dita-ot.sourceforge.net/ns/201007/dita-ot"
  xmlns:xs="http://www.w3.org/2001/XMLSchema" version="2.0" exclude-result-prefixes="xs dita-ot">

  <xsl:template match="*" mode="flag-images">
    <xsl:if test="*//startflag | *//endflag">
      <xsl:variable name="flags" as="element()*">
        <xsl:for-each select=".//startflag | .//endflag">
          <xsl:choose>
            <xsl:when test="@imageref">
              <image class="+ topic/image ditaot-d/flagimage " href="{@imageref}" placement="inline">
                <alt class="- topic/alt ">
                  <xsl:value-of select="alt-text"/>
                </alt>
              </image>
            </xsl:when>
            <xsl:when test="alt-text">
              <!-- spec.pdf: Remove [ ] characters from either side of alt-text.  -->
              <text class="+ topic/text ditaot-d/flagtext ">
                <xsl:value-of select="alt-text"/>
              </text>
            </xsl:when>
          </xsl:choose>
        </xsl:for-each>
      </xsl:variable>
      <xsl:choose>
        <xsl:when
          test="
            parent::*[contains(@class, ' topic/dl ') or
            contains(@class, ' topic/image ')]">
          <fo:inline xsl:use-attribute-sets="image__inline">
            <xsl:apply-templates select="$flags"/>
          </fo:inline>
        </xsl:when>
        <xsl:when test="parent::*[contains(@class, ' topic/topic ')]">
          <!-- spec.pdf: Topic flagging is handled in spec_commons.xsl -->
        </xsl:when>
        <xsl:otherwise>
          <xsl:apply-templates select="$flags"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:if>
  </xsl:template>

</xsl:stylesheet>
