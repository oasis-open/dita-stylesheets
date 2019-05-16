<?xml version='1.0' encoding='ASCII'?>

<!-- ===================== CHANGE LOG ================================ -->
<!--                                                                   -->
<!-- 05 Sep 2015 KJE: Added change log.                                -->
<!-- 16 May 2019 KJE: Replaced templates for definition lists          -->
<!--                                                                   -->
<!-- ================================================================= --> 

<xsl:stylesheet 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:opentopic-func="http://www.idiominc.com/opentopic/exsl/function"
  xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns:dita2xslfo="http://dita-ot.sourceforge.net/ns/200910/dita2xslfo"
  xmlns:dita-ot="http://dita-ot.sourceforge.net/ns/201007/dita-ot"
  exclude-result-prefixes="opentopic-func xs dita2xslfo dita-ot" version="2.0">

  <!-- OVERRIDE TO RENDER COLUMN AND ROW SEPARATORS BY DEFAULT -->
  <xsl:variable name="table.rowsep-default" select="'1'"/>
  <xsl:variable name="table.colsep-default" select="'1'"/>

  <!-- OVERRIDE FOR DEFINITION LISTS -->
  <!-- From old committee note plug-in  -->

  <!--<xsl:template match="*[contains(@class, ' topic/dl ')]">
        <fo:block xsl:use-attribute-sets="dl">
            <xsl:call-template name="commonattributes" />
            <xsl:apply-templates select="*[contains(@class, ' topic/dlentry ')]" />
        </fo:block>
    </xsl:template>
    <xsl:template match="*[contains(@class, ' topic/dlentry ')]">
        <fo:block>
            <xsl:apply-templates select="*[contains(@class, ' topic/dt ')]" />
            <xsl:apply-templates select="*[contains(@class, ' topic/dd ')]" />
        </fo:block>
    </xsl:template>
    <xsl:template match="*[contains(@class, ' topic/dt ')]">
        <fo:block xsl:use-attribute-sets="dlentry.dt__content">
            <xsl:apply-templates />
        </fo:block>
    </xsl:template>
    <xsl:template match="*[contains(@class, ' topic/dd ')]">
        <fo:block xsl:use-attribute-sets="dlentry.dd__content">
            <xsl:apply-templates />
        </fo:block>
    </xsl:template>-->

  <!-- From old spec plug-in -->
  <!-- Use table format for <dl> when <dlhead> is specified, otherwise format
       <dl> as stacked <dt>-<dd> blocks with the block for <dd> indented. -->

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
        <fo:block xsl:use-attribute-sets="dl__as__list">
          <xsl:apply-templates/>
        </fo:block>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <!-- if it contains dlhead, we must treat it like a table, so we need this -->
  <xsl:template match="*[contains(@class, ' topic/dl ')]/*[contains(@class, ' topic/dlhead ')]">
    <fo:table-header xsl:use-attribute-sets="dl.dlhead" id="{@id}">
      <fo:table-row xsl:use-attribute-sets="dl.dlhead__row">
        <xsl:apply-templates/>
      </fo:table-row>
    </fo:table-header>
  </xsl:template>
  <!-- if it contains dlhead, we must treat it like a table, so we need this -->
  <xsl:template match="*[contains(@class, ' topic/dlhead ')]/*[contains(@class, ' topic/dthd ')]">
    <fo:table-cell xsl:use-attribute-sets="dlhead.dthd__cell" id="{@id}">
      <fo:block xsl:use-attribute-sets="dlhead.dthd__content">
        <xsl:apply-templates/>
      </fo:block>
    </fo:table-cell>
  </xsl:template>
  <!-- if it contains dlhead, we must treat it like a table, so we need this -->
  <xsl:template match="*[contains(@class, ' topic/dlhead ')]/*[contains(@class, ' topic/ddhd ')]">
    <fo:table-cell xsl:use-attribute-sets="dlhead.ddhd__cell" id="{@id}">
      <fo:block xsl:use-attribute-sets="dlhead.ddhd__content">
        <xsl:apply-templates/>
      </fo:block>
    </fo:table-cell>
  </xsl:template>
  <!-- adding choose statement to keep table output if a dlhead is used; otherwise, treat as a "simple" defintion list -->
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
        <fo:block xsl:use-attribute-sets="dlentry__as__listitem">
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

</xsl:stylesheet>
