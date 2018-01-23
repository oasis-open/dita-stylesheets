<?xml version="1.0" encoding="UTF-8" ?>
<!-- This file is part of the DITA Open Toolkit project hosted on 
     Sourceforge.net. See the accompanying license.txt file for 
     applicable licenses.-->
<!-- (c) Copyright IBM Corp. 2004, 2005 All Rights Reserved. -->
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns:dita-ot="http://dita-ot.sourceforge.net/ns/201007/dita-ot"
  xmlns:dita2html="http://dita-ot.sourceforge.net/ns/200801/dita2html"
  xmlns:ditamsg="http://dita-ot.sourceforge.net/ns/200704/ditamsg"
  xmlns:oa-cn="org.oasis.committeenote" exclude-result-prefixes="xs dita-ot dita2html ditamsg">

  <!-- Author, VRM, prodname templates are here to work around DITA OT issue
       where metadata cascades (as a copy) to every topic, but then the single 
       chunked result file puts all of those copies into the result. 
       Overrides here ensure only one copy of duplicate metadata goes into metadata. --> 
  <xsl:key name="authors" match="*[contains(@class,' topic/author ')]" use="."/>
  <xsl:key name="vrms" match="*[contains(@class,' topic/vrm ')]" use="@version"/>
  <xsl:key name="prodnames" match="*[contains(@class,' topic/prodname ')]" use="."/>
  <xsl:template match="*[contains(@class,' topic/prodname ')]" mode="gen-metadata">
    <xsl:choose>
      <xsl:when test="normalize-space(.)=''"/>
      <xsl:when test="generate-id(key('prodnames',.)[1])!=generate-id(.)"/>
      <xsl:otherwise><xsl:next-match/></xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <xsl:template match="*[contains(@class,' topic/vrm ')]/@version" mode="gen-metadata">
    <xsl:choose>
      <xsl:when test="normalize-space(.)=''"/>
      <xsl:when test="generate-id(key('vrms',.)[1])!=generate-id(parent::*)"/>
      <xsl:otherwise><xsl:next-match/></xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <xsl:template match="*[contains(@class,' topic/author ')]" mode="gen-metadata">
    <xsl:choose>
      <xsl:when test="normalize-space(.)=''"/>
      <xsl:when test="generate-id(key('authors',.)[1])!=generate-id(.)"/>
      <xsl:otherwise><xsl:next-match/></xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <!-- child topics get a div wrapper and fall through -->
  <xsl:template match="*[contains(@class, ' topic/topic ')]" mode="child.topic" name="child.topic">
    <xsl:param name="nestlevel" as="xs:integer">
      <xsl:choose>
        <!-- Limit depth for historical reasons, could allow any depth. Previously limit was 5. -->
        <xsl:when test="count(ancestor::*[contains(@class, ' topic/topic ')]) > 9">9</xsl:when>
        <xsl:otherwise>
          <xsl:sequence select="count(ancestor::*[contains(@class, ' topic/topic ')])"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:param>
    <article class="nested{$nestlevel}">
      <xsl:attribute name="aria-labelledby">
        <xsl:apply-templates select="*[contains(@class, ' topic/title ')]"
          mode="return-aria-label-id"/>
      </xsl:attribute>
      <xsl:call-template name="gen-topic">
        <xsl:with-param name="nestlevel" select="$nestlevel"/>
      </xsl:call-template>
    </article>
    <xsl:value-of select="$newline"/>
    <!-- Thomas: Insert TOC -->
    <xsl:if test="contains(@outputclass, 'frontmatternotices')">
      <xsl:call-template name="gen-toc"/>
    </xsl:if>
  </xsl:template>

  <!-- NESTED TOPIC TITLES (sensitive to nesting depth, but are still processed for contained markup) -->
  <!-- 1st level - topic/title -->
  <!-- Condensed topic title into single template without priorities; use $headinglevel to set heading.
     If desired, somebody could pass in the value to manually set the heading level -->
  <xsl:template match="*[contains(@class, ' topic/topic ')]/*[contains(@class, ' topic/title ')]">
    <xsl:param name="headinglevel" as="xs:integer">
      <xsl:choose>
        <xsl:when test="count(ancestor::*[contains(@class, ' topic/topic ')]) > 6">6</xsl:when>
        <xsl:otherwise>
          <xsl:sequence select="count(ancestor::*[contains(@class, ' topic/topic ')])"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:param>
    <xsl:if test="contains(../@outputclass, 'cover')">
      <xsl:call-template name="committe-note-pubinfo"/>
    </xsl:if>
    <xsl:element name="h{$headinglevel}">
      <xsl:call-template name="commonattributes">
        <xsl:with-param name="default-output-class">topictitle<xsl:value-of select="$headinglevel"
          /></xsl:with-param>
      </xsl:call-template>
      <xsl:attribute name="id">
        <xsl:apply-templates select="." mode="return-aria-label-id"/>
      </xsl:attribute>
      <xsl:choose>
        <xsl:when
          test="ancestor::*[contains(@outputclass, 'cover') or contains(@outputclass, 'frontmatternotices')]">
          <xsl:attribute name="class">frontmatter-topic-title</xsl:attribute>
        </xsl:when>
        <xsl:otherwise>
          <xsl:attribute name="class">topictitle<xsl:value-of select="$headinglevel"
            /></xsl:attribute>
          <xsl:call-template name="get-section-number"/>
          <xsl:text> </xsl:text>
        </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates/>
    </xsl:element>
    <xsl:value-of select="$newline"/>
  </xsl:template>

  <xsl:template
    match="
      *[contains(@class, ' topic/section ')]/*[contains(@class, ' topic/title ')] |
      *[contains(@class, ' topic/example ')]/*[contains(@class, ' topic/title ')]"
    name="topic.section_title">
    <xsl:param name="headLevel">
      <xsl:variable name="headCount"
        select="count(ancestor::*[contains(@class, ' topic/topic ')]) + 1"/>
      <xsl:choose>
        <xsl:when test="$headCount > 6">h6</xsl:when>
        <xsl:otherwise>h<xsl:value-of select="$headCount"/></xsl:otherwise>
      </xsl:choose>
    </xsl:param>
    <xsl:element name="{$headLevel}">
      <xsl:attribute name="class">
        <xsl:choose>
          <xsl:when
            test="ancestor::*[contains(@outputclass, 'cover') or contains(@outputclass, 'frontmatternotices')]"
            >frontmatter-section-title</xsl:when>
          <xsl:otherwise>sectiontitle</xsl:otherwise>
        </xsl:choose>
      </xsl:attribute>
      <xsl:apply-templates/>
    </xsl:element>
  </xsl:template>

  <xsl:template name="get-section-number">
    <xsl:variable name="parentId" select="../@id"/>
    <xsl:choose>
      <xsl:when test="$bookmap/bookmap/appendix[replace(@href, '.*#', '') = $parentId]">
        <xsl:variable name="appendixNode" select="$bookmap/bookmap/appendix[replace(@href, '.*#', '') = $parentId]"/>
        <xsl:value-of select="$appendixNode//data[@name='number']/@value"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:number
          count="*[contains(@class, ' topic/topic ')][not(ancestor-or-self::*[contains(@outputclass, 'cover') or contains(@outputclass, 'frontmatternotices')])]"
          level="multiple" format="1.1"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="committe-note-pubinfo">
    <p class="logo">
      <a href="http://www.oasis-open.org">
        <img src="OASISLogo.jpg" alt="OASIS logo"/>
      </a>
    </p>
    <hr/>
    <div class="committee-note-title">
      <xsl:apply-templates select="$bookmap/bookmap/booktitle/mainbooktitle"/>
    </div>
    <div class="publication-level">
      <xsl:apply-templates
        select="$bookmap/bookmap/booktitle/booktitlealt/keyword[@keyref = 'publication-level']"/>
    </div>
    <div class="approval-date">
      <xsl:apply-templates
        select="$bookmap/bookmap/booktitle/booktitlealt/keyword[@keyref = 'approval-date']"/>
    </div>
  </xsl:template>

  <xsl:template match="text()" mode="committe-note-title"/>
</xsl:stylesheet>
