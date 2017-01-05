<?xml version='1.0' encoding='utf-8'?>
<xsl:stylesheet exclude-result-prefixes="ditaarch opentopic spdf" version="2.0"
  xmlns:ditaarch="http://dita.oasis-open.org/architecture/2005/"
  xmlns:spdf="org.oasis.spec.pdf" xmlns:fo="http://www.w3.org/1999/XSL/Format"
  xmlns:opentopic="http://www.idiominc.com/opentopic"
  xmlns:opentopic-func="http://www.idiominc.com/opentopic/exsl/function"
  xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <!--list-->
  <xsl:template match="*[contains(@class, ' topic/ul ')]/*[contains(@class, ' topic/li ')]">
    <xsl:variable name="depth" select="count(ancestor::*[contains(@class, ' topic/ul ')])"/>
    <fo:list-item xsl:use-attribute-sets="ul.li">
      <fo:list-item-label xsl:use-attribute-sets="ul.li__label">
        <fo:block xsl:use-attribute-sets="ul.li__label__content">
          <fo:inline>
            <xsl:call-template name="commonattributes"/>
          </fo:inline>
          <xsl:call-template name="getVariable">
            <xsl:with-param name="id" select="concat('Unordered List bullet ', $depth)"/>
          </xsl:call-template>
        </fo:block>
      </fo:list-item-label>
      <fo:list-item-body xsl:use-attribute-sets="ul.li__body">
        <fo:block xsl:use-attribute-sets="ul.li__content">
          <xsl:apply-templates/>
        </fo:block>
      </fo:list-item-body>
    </fo:list-item>
  </xsl:template>
  <xsl:template match="*[contains(@class, ' topic/ol ')]/*[contains(@class, ' topic/li ')]">
    <xsl:variable name="depth" select="count(ancestor::*[contains(@class, ' topic/ol ')])"/>
    <xsl:variable name="format">
      <xsl:call-template name="getVariable">
        <xsl:with-param name="id" select="concat('Ordered List Format ', $depth)"/>
      </xsl:call-template>
    </xsl:variable>
    <fo:list-item xsl:use-attribute-sets="ol.li">
      <fo:list-item-label xsl:use-attribute-sets="ol.li__label">
        <fo:block xsl:use-attribute-sets="ol.li__label__content">
          <fo:inline>
            <xsl:call-template name="commonattributes"/>
          </fo:inline>
          <xsl:call-template name="getVariable">
            <xsl:with-param name="id" select="concat('Ordered List Number ', $depth)"/>
            <xsl:with-param as="element()*" name="params">
              <number>
                <xsl:number format="{$format}"/>
              </number>
            </xsl:with-param>
          </xsl:call-template>
        </fo:block>
      </fo:list-item-label>
      <fo:list-item-body xsl:use-attribute-sets="ol.li__body">
        <fo:block xsl:use-attribute-sets="ol.li__content">
          <xsl:apply-templates/>
        </fo:block>
      </fo:list-item-body>
    </fo:list-item>
  </xsl:template>
</xsl:stylesheet>
