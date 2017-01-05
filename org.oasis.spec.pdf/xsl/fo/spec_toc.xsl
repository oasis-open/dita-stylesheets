<?xml version='1.0' encoding='utf-8'?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns:spdf="org.oasis.spec.pdf"
  xmlns:fo="http://www.w3.org/1999/XSL/Format"
  xmlns:opentopic="http://www.idiominc.com/opentopic"
  xmlns:opentopic-func="http://www.idiominc.com/opentopic/exsl/function"
  xmlns:opentopic-index="http://www.idiominc.com/opentopic/index"
  xmlns:ot-placeholder="http://suite-sol.com/namespaces/ot-placeholder"
  exclude-result-prefixes="spdf xs opentopic opentopic-func ot-placeholder opentopic-index"
  version="2.0">
  <!--toc-->
  
  <xsl:template match="*[contains(@class, ' bookmap/chapter ')] |
    *[contains(@class, ' bookmap/bookmap ')]/opentopic:map/*[contains(@class, ' map/topicref ')]" mode="tocPrefix" priority="-1"/>
  
  <xsl:template match="*[contains(@class, ' bookmap/appendix ')]" mode="tocPrefix"/>
  
  <xsl:template match="*[contains(@class, ' bookmap/part ')]" mode="tocPrefix"/>
  
  <xsl:template match="*[contains(@class, ' bookmap/preface ')]" mode="tocPrefix"/>
  
  <xsl:template match="*[contains(@class, ' bookmap/appendix ')]" mode="tocText">
    <xsl:param name="tocItemContent"/>
    <xsl:param name="currentNode"/>
    <xsl:for-each select="$currentNode">
      <fo:block xsl:use-attribute-sets="__toc__appendix__content">
        <xsl:copy-of select="$tocItemContent"/>
      </fo:block>
    </xsl:for-each>
  </xsl:template>

  <xsl:template match="*[contains(@class, ' bookmap/part ')]" mode="tocText">
    <xsl:param name="tocItemContent"/>
    <xsl:param name="currentNode"/>
    <xsl:for-each select="$currentNode">
      <fo:block xsl:use-attribute-sets="__toc__part__content">
        <xsl:copy-of select="$tocItemContent"/>
      </fo:block>
    </xsl:for-each>
  </xsl:template>

  <xsl:template match="*[contains(@class, ' bookmap/preface ')]" mode="tocText">
    <xsl:param name="tocItemContent"/>
    <xsl:param name="currentNode"/>
    <xsl:for-each select="$currentNode">
      <fo:block xsl:use-attribute-sets="__toc__preface__content">
        <xsl:copy-of select="$tocItemContent"/>
      </fo:block>
    </xsl:for-each>
  </xsl:template>

  <xsl:template match="*[contains(@class, ' bookmap/notices ')]" mode="tocText">
    <xsl:param name="tocItemContent"/>
    <xsl:param name="currentNode"/>
    <xsl:for-each select="$currentNode">
      <fo:block xsl:use-attribute-sets="__toc__notices__content">
        <xsl:copy-of select="$tocItemContent"/>
      </fo:block>
    </xsl:for-each>
  </xsl:template>

  <xsl:template match="node()" mode="tocText" priority="-10">
    <xsl:param name="tocItemContent"/>
    <xsl:param name="currentNode"/>
    <xsl:for-each select="$currentNode">
      <xsl:variable name="level"
        select="count(ancestor-or-self::*[contains(@class, ' topic/topic ')])"/>
      <xsl:choose>
        <xsl:when test="$level eq 1">
          <fo:block xsl:use-attribute-sets="__toc__topic__content">
            <xsl:copy-of select="$tocItemContent"/>
          </fo:block>
        </xsl:when>
        <xsl:when test="$level eq 2">
          <fo:block xsl:use-attribute-sets="__toc__topic__content_2">
            <xsl:copy-of select="$tocItemContent"/>
          </fo:block>
        </xsl:when>
        <xsl:when test="$level eq 3">
          <fo:block xsl:use-attribute-sets="__toc__topic__content_3">
            <xsl:copy-of select="$tocItemContent"/>
          </fo:block>
        </xsl:when>
        <xsl:when test="$level eq 4">
          <fo:block xsl:use-attribute-sets="__toc__topic__content_4">
            <xsl:copy-of select="$tocItemContent"/>
          </fo:block>
        </xsl:when>
      </xsl:choose>
    </xsl:for-each>
  </xsl:template>

</xsl:stylesheet>
