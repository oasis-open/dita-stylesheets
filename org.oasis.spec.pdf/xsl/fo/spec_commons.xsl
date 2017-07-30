<?xml version='1.0' encoding='utf-8'?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:fo="http://www.w3.org/1999/XSL/Format"
  xmlns:opentopic="http://www.idiominc.com/opentopic"
  xmlns:opentopic-index="http://www.idiominc.com/opentopic/index"
  xmlns:opentopic-func="http://www.idiominc.com/opentopic/exsl/function"
  xmlns:dita2xslfo="http://dita-ot.sourceforge.net/ns/200910/dita2xslfo"
  xmlns:spdf="org.oasis.spec.pdf" xmlns:dita-ot="http://dita-ot.sourceforge.net/ns/201007/dita-ot"
  xmlns:ot-placeholder="http://suite-sol.com/namespaces/ot-placeholder"
  exclude-result-prefixes="dita-ot spdf ot-placeholder opentopic opentopic-index opentopic-func dita2xslfo xs"
  version="2.0">
  
  <xsl:import href="spec_topic.xsl"/>

  <xsl:template match="*" mode="insertChapterFirstpageStaticContent">
    <xsl:param name="type" as="xs:string"/>
    <!-- spec.pdf: This block and its id are needed to furnish a link target for bookmarks and
         the TOC. All other template content from the base has been removed. -->
    <fo:block>
      <xsl:attribute name="id">
        <xsl:call-template name="generate-toc-id"/>
      </xsl:attribute>
    </fo:block>
  </xsl:template>

  <xsl:template name="processTopicAppendix">
    <fo:page-sequence master-reference="body-sequence"
      xsl:use-attribute-sets="page-sequence.appendix">
      <xsl:call-template name="startPageNumbering"/>
      <xsl:call-template name="insertBodyStaticContents"/>
      <fo:flow flow-name="xsl-region-body">
        <fo:block xsl:use-attribute-sets="topic">
          <xsl:call-template name="commonattributes"/>
          <xsl:variable name="level" as="xs:integer">
            <xsl:apply-templates select="." mode="get-topic-level"/>
          </xsl:variable>
          <xsl:if test="$level eq 1">
            <fo:marker marker-class-name="current-topic-number">
              <xsl:variable name="topicref"
                select="key('map-id', ancestor-or-self::*[contains(@class, ' topic/topic ')][1]/@id)"/>
              <xsl:for-each select="$topicref">
                <xsl:apply-templates select="." mode="topicTitleNumber"/>
              </xsl:for-each>
            </fo:marker>
            <xsl:apply-templates select="." mode="insertTopicHeaderMarker"/>
          </xsl:if>
          <xsl:apply-templates select="*[contains(@class, ' topic/prolog ')]"/>
          <xsl:apply-templates select="." mode="insertChapterFirstpageStaticContent">
            <xsl:with-param name="type" select="'appendix'"/>
          </xsl:apply-templates>
          <fo:block xsl:use-attribute-sets="topic.title">
            <xsl:call-template name="pullPrologIndexTerms"/>
            <!-- spec.pdf: Added this call to get the string for Appendix. -->
            <xsl:call-template name="getVariable">
              <xsl:with-param name="id" select="'Appendix with number'"/>
            </xsl:call-template>
            <xsl:for-each select="*[contains(@class, ' topic/title ')]">
              <xsl:apply-templates select="." mode="getTitle"/>
            </xsl:for-each>
          </fo:block>
          <xsl:choose>
            <xsl:when test="$appendixLayout = 'BASIC'">
              <xsl:apply-templates
                select="
                  *[not(contains(@class, ' topic/topic ') or contains(@class, ' topic/title ') or
                  contains(@class, ' topic/prolog '))]"/>
              <!--xsl:apply-templates select="." mode="buildRelationships"/-->
            </xsl:when>
            <xsl:otherwise>
              <xsl:apply-templates select="." mode="createMiniToc"/>
            </xsl:otherwise>
          </xsl:choose>
          <xsl:apply-templates select="*[contains(@class, ' topic/topic ')]"/>
          <xsl:call-template name="pullPrologIndexTerms.end-range"/>
        </fo:block>
      </fo:flow>
    </fo:page-sequence>
  </xsl:template>
  
  <xsl:template match="*[contains(@class, ' topic/topic ')][child::ditaval-startprop[count(preceding-sibling::*) = 0]]">
    <fo:block xsl:use-attribute-sets="revised">
      <xsl:text>►</xsl:text>
      <xsl:variable name="topicType" as="xs:string">
        <xsl:call-template name="determineTopicType"/>
      </xsl:variable>
      <xsl:choose>
        <xsl:when test="$topicType = 'topicChapter'">
          <xsl:call-template name="processTopicChapter"/>
        </xsl:when>
        <xsl:when test="$topicType = 'topicAppendix'">
          <xsl:call-template name="processTopicAppendix"/>
        </xsl:when>
        <xsl:when test="$topicType = 'topicAppendices'">
          <xsl:call-template name="processTopicAppendices"/>
        </xsl:when>
        <xsl:when test="$topicType = 'topicPart'">
          <xsl:call-template name="processTopicPart"/>
        </xsl:when>
        <xsl:when test="$topicType = 'topicPreface'">
          <xsl:call-template name="processTopicPreface"/>
        </xsl:when>
        <xsl:when test="$topicType = 'topicNotices'">
          <xsl:if test="$retain-bookmap-order">
            <xsl:call-template name="processTopicNotices"/>
          </xsl:if>
        </xsl:when>
        <xsl:when test="$topicType = 'topicTocList'">
          <xsl:call-template name="processTocList"/>
        </xsl:when>
        <xsl:when test="$topicType = 'topicIndexList'">
          <xsl:call-template name="processIndexList"/>
        </xsl:when>
        <xsl:when test="$topicType = 'topicFrontMatter'">
          <xsl:call-template name="processFrontMatterTopic"/>
        </xsl:when>
        <xsl:when test="$topicType = 'topicSimple'">
          <xsl:call-template name="processTopicSimple"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:apply-templates select="." mode="processUnknowTopic">
            <xsl:with-param name="topicType" select="$topicType"/>
          </xsl:apply-templates>
        </xsl:otherwise>
      </xsl:choose>      
      <xsl:text>◄</xsl:text>
    </fo:block></xsl:template>

<!--  <!-\- override definiton list handling; table layout is unreliable with some fo processors -\->
  <xsl:template match="*[contains(@class, ' topic/dl ')]">
    <xsl:choose>
      <xsl:when test="*[contains(@class, ' topic/dlhead ')]">
        <fo:table xsl:use-attribute-sets="dl" id="{@id}">
          <xsl:apply-templates select="*[contains(@class, ' topic/dlhead ')]"/>
          <fo:table-body xsl:use-attribute-sets="dl__body">
            <xsl:choose>
              <xsl:when test="contains(@otherprops, 'sortable')">
                <xsl:apply-templates select="*[contains(@class, ' topic/dlentry ')]">
                  <xsl:sort
                    select="opentopic-func:getSortString(normalize-space(opentopic-func:fetchValueableText(*[contains(@class, ' topic/dt ')])))"
                    lang="{$locale}"/>
                </xsl:apply-templates>
              </xsl:when>
              <xsl:otherwise>
                <xsl:apply-templates select="*[contains(@class, ' topic/dlentry ')]"/>
              </xsl:otherwise>
            </xsl:choose>
          </fo:table-body>
        </fo:table>
      </xsl:when>
      <xsl:otherwise>
        <fo:block>
          <xsl:apply-templates/>
        </fo:block>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <!-\- if it contains dlhead, we must treat it like a table, so we need this -\->
  <xsl:template match="*[contains(@class, ' topic/dl ')]/*[contains(@class, ' topic/dlhead ')]">
    <fo:table-header xsl:use-attribute-sets="dl.dlhead" id="{@id}">
      <fo:table-row xsl:use-attribute-sets="dl.dlhead__row">
        <xsl:apply-templates/>
      </fo:table-row>
    </fo:table-header>
  </xsl:template>
  <!-\- if it contains dlhead, we must treat it like a table, so we need this -\->
  <xsl:template match="*[contains(@class, ' topic/dlhead ')]/*[contains(@class, ' topic/dthd ')]">
    <fo:table-cell xsl:use-attribute-sets="dlhead.dthd__cell" id="{@id}">
      <fo:block xsl:use-attribute-sets="dlhead.dthd__content">
        <xsl:apply-templates/>
      </fo:block>
    </fo:table-cell>
  </xsl:template>
  <!-\- if it contains dlhead, we must treat it like a table, so we need this -\->
  <xsl:template match="*[contains(@class, ' topic/dlhead ')]/*[contains(@class, ' topic/ddhd ')]">
    <fo:table-cell xsl:use-attribute-sets="dlhead.ddhd__cell" id="{@id}">
      <fo:block xsl:use-attribute-sets="dlhead.ddhd__content">
        <xsl:apply-templates/>
      </fo:block>
    </fo:table-cell>
  </xsl:template>
  <!-\- adding choose statement to keep table output if a dlhead is used; otherwise, treat as a "simple" defintion list -\->
  <xsl:template match="*[contains(@class, ' topic/dlentry ')]">
    <xsl:choose>
      <xsl:when test="preceding-sibling::*[contains(@class, ' topic/dlhead ')]">
        <fo:table-row xsl:use-attribute-sets="dlentry" id="{@id}">
          <fo:table-cell xsl:use-attribute-sets="dlentry.dt" id="{@id}">
            <xsl:apply-templates select="*[contains(@class, ' topic/dt ')]"/>
          </fo:table-cell>
          <fo:table-cell xsl:use-attribute-sets="dlentry.dd" id="{@id}">
            <xsl:apply-templates select="*[contains(@class, ' topic/dd ')]"/>
          </fo:table-cell>
        </fo:table-row>
      </xsl:when>
      <xsl:otherwise>
        <fo:block>
          <xsl:call-template name="commonattributes"/>
          <xsl:apply-templates/>
        </fo:block>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="*[contains(@class, ' topic/dt ')]">
    <fo:block xsl:use-attribute-sets="dt__block">
      <xsl:apply-templates/>
    </fo:block>
  </xsl:template>

  <xsl:template match="*[contains(@class, ' topic/dd ')]">
    <fo:block xsl:use-attribute-sets="dd__block">
      <xsl:apply-templates/>
    </fo:block>
  </xsl:template>
  <!-\- end definition list handling override -\->
-->
</xsl:stylesheet>
