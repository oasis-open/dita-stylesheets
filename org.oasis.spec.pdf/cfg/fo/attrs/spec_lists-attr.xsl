<?xml version='1.0' encoding='utf-8'?>
<xsl:stylesheet exclude-result-prefixes="xs ditaarch opentopic spdf" version="2.0"
  xmlns:ditaarch="http://dita.oasis-open.org/architecture/2005/"
  xmlns:spdf="org.oasis.spec.pdf" xmlns:opentopic="http://www.idiominc.com/opentopic"
  xmlns:opentopic-func="http://www.idiominc.com/opentopic/exsl/function"
  xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <!--list-->
  <xsl:attribute-set name="common.lists">
    <xsl:attribute name="margin-left">
      <xsl:choose>
        <xsl:when test="ancestor::*[contains(@class, ' topic/entry ')]">
          <xsl:value-of select="$common-list-margin-table"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="$common-list-margin"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:attribute>
  </xsl:attribute-set>

  <xsl:attribute-set name="ol" use-attribute-sets="common.lists">
    <xsl:attribute name="provisional-distance-between-starts">
      <xsl:call-template name="spdf:list-label-length"/>
      <xsl:text>em * 0.7</xsl:text>
    </xsl:attribute>
  </xsl:attribute-set>

  <xsl:template name="spdf:list-label-length">
    <xsl:variable as="xs:integer*" name="labels">
      <xsl:variable name="depth" select="count(ancestor-or-self::*[contains(@class, ' topic/ol ')])"/>
      <xsl:variable as="xs:string" name="format">
        <xsl:call-template name="getVariable">
          <xsl:with-param name="id" select="concat('Ordered List Format ', $depth)"/>
        </xsl:call-template>
      </xsl:variable>
      <xsl:for-each select="*[contains(@class, ' topic/li ')]">
        <xsl:variable name="s">
          <xsl:call-template name="getVariable">
            <xsl:with-param name="id" select="concat('Ordered List Number ', $depth)"/>
            <xsl:with-param as="element()*" name="params">
              <number>
                <xsl:number format="{$format}"/>
              </number>
            </xsl:with-param>
          </xsl:call-template>
        </xsl:variable>
        <xsl:sequence select="string-length(normalize-space($s))"/>
      </xsl:for-each>
    </xsl:variable>
    <xsl:sequence select="max($labels)"/>
  </xsl:template>

  <xsl:attribute-set name="ol.li">
    <xsl:attribute name="space-after">0.6em</xsl:attribute>
    <xsl:attribute name="space-before">0.6em</xsl:attribute>
    <xsl:attribute name="relative-align">baseline</xsl:attribute>
  </xsl:attribute-set>

  <xsl:attribute-set name="sl" use-attribute-sets="common.lists"> </xsl:attribute-set>

  <xsl:attribute-set name="ul" use-attribute-sets="common.lists"> </xsl:attribute-set>

  <xsl:attribute-set name="ul.li">
    <xsl:attribute name="space-after">0.6em</xsl:attribute>
    <xsl:attribute name="space-before">0.6em</xsl:attribute>
    <xsl:attribute name="relative-align">baseline</xsl:attribute>
  </xsl:attribute-set>
</xsl:stylesheet>
