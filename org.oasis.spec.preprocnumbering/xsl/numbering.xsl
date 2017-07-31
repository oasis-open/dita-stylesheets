<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns:dita-ot="http://dita-ot.sourceforge.net/ns/201007/dita-ot"
  xmlns:mappull="http://dita-ot.sourceforge.net/ns/200704/mappull"
  xmlns:ditamsg="http://dita-ot.sourceforge.net/ns/200704/ditamsg"
  xmlns:saxon="http://saxon.sf.net/" exclude-result-prefixes="xs dita-ot mappull ditamsg saxon">

  <xsl:output method="xml" indent="yes"/>
  <xsl:param name="INDIR"></xsl:param>
  <xsl:param name="OUTDIR"></xsl:param>
  
  <xsl:variable name="indir-uri" select="concat('file:/', replace($INDIR, '\\', '/'))"/>  
  <xsl:variable name="outdir-uri" select="concat('file:/', replace($OUTDIR, '\\', '/'))"/>
  
  <xsl:variable name="numbered-titles" as="xs:boolean"
    select="
      if (/*[contains(@class, ' map/map ')]/*[contains(@class, ' map/topicmeta ')]/data[@name = 'numbered-titles']/@value = 'true') then
        true()
      else
        false()"/>

  <!-- Process the root map -->
  <xsl:template match="/">
    <xsl:apply-templates/>
  </xsl:template>

  <!-- Chapters that are children of part are difficult to count with <xsl:number>
       or with the count() function. This variable contains a flat array of all
       chapter tags in the publication with @id added for matching. -->
  <xsl:variable name="chapter-tags">
    
      <!-- Shallow copies only -->
      <xsl:for-each select="//*[contains(@class, ' bookmap/chapter ')]">
        <xsl:copy>
          <xsl:copy-of select="@*"/>
          <!-- Embed an id for matching with the <chapter> tag that
               is in the bookmap. -->
          <xsl:attribute name="id">
            <xsl:value-of select="generate-id()"/>
          </xsl:attribute>
        </xsl:copy>
      </xsl:for-each>
    
  </xsl:variable>

  <xsl:template match="*[contains(@class, ' bookmap/part ')]" priority="5">
    <xsl:copy>
      <xsl:copy-of select="@*"/>
      <xsl:processing-instruction name="tsnum">
        <xsl:number/>
      </xsl:processing-instruction>
      <xsl:processing-instruction name="tsstruct">
      <xsl:text>part</xsl:text>
      </xsl:processing-instruction>
      <xsl:apply-templates/>
    </xsl:copy>
  </xsl:template>

  <xsl:template match="*[contains(@class, ' bookmap/appendices ')]" priority="5">
    <xsl:copy>
      <xsl:copy-of select="@*"/>
      <xsl:processing-instruction name="tsstruct">
      <xsl:text>appendices</xsl:text>
      </xsl:processing-instruction>
      <xsl:apply-templates/>
    </xsl:copy>
  </xsl:template>

  <xsl:template match="*[contains(@class, ' bookmap/chapter ')]" priority="5">
    <xsl:variable name="thisID" select="generate-id()"/>
    <!-- Find the corresponding chapter tag in the flat $chapter-tags array, then
         count the position in the array rather than in the document. -->
    <xsl:variable name="chapter-number">
      <xsl:apply-templates select="$chapter-tags/*[$thisID = @id]" mode="chapnum"/>
    </xsl:variable>
    <xsl:copy>
      <xsl:copy-of select="@*"/>
      <xsl:processing-instruction name="tsnum">
        <xsl:value-of select="$chapter-number"/>
      </xsl:processing-instruction>
      <xsl:processing-instruction name="tsstruct">
        <xsl:text>chapter</xsl:text>
      </xsl:processing-instruction>
      <xsl:call-template name="process-topic">
        <xsl:with-param name="t_tsnum" select="$chapter-number" tunnel="yes"/>
        <xsl:with-param name="t_tsstruct" tunnel="yes">chapter</xsl:with-param>
      </xsl:call-template>
      <xsl:apply-templates>
        <xsl:with-param name="t_top-level-number" select="$chapter-number" tunnel="yes"/>
      </xsl:apply-templates>
    </xsl:copy>
  </xsl:template>

  <xsl:template match="*" mode="chapnum">
    <xsl:number format="1" count="*[contains(@class, ' bookmap/chapter ')]"/>
  </xsl:template>

  <xsl:template match="*[contains(@class, ' bookmap/appendix ')]" priority="5">
    <xsl:variable name="appendix-number">
      <xsl:number format="A" count="*[contains(@class, ' bookmap/appendix ')]"/>
    </xsl:variable>
    <xsl:copy>
      <xsl:copy-of select="@*"/>
      <xsl:processing-instruction name="tsnum">
        <xsl:value-of select="$appendix-number"/>
      </xsl:processing-instruction>
      <xsl:processing-instruction name="tsstruct">
      <xsl:text>appendix</xsl:text>
      </xsl:processing-instruction>
      <xsl:call-template name="process-topic">
        <xsl:with-param name="t_tsnum" select="$appendix-number" tunnel="yes"/>
        <xsl:with-param name="t_tsstruct" tunnel="yes">appendix</xsl:with-param>
      </xsl:call-template>
      <xsl:apply-templates>
        <xsl:with-param name="t_top-level-number" select="$appendix-number" tunnel="yes"/>
      </xsl:apply-templates>
    </xsl:copy>
  </xsl:template>

  <xsl:template
    match="*[contains(@class, ' map/topicref ')][not(ancestor-or-self::*[contains(@class, ' bookmap/frontmatter ')])]">
    <xsl:param name="t_top-level-number" tunnel="yes"/>
    <xsl:copy>
      <xsl:variable name="this-topic-number">
        <xsl:call-template name="get-topic-number"/>
      </xsl:variable>
      <xsl:copy-of select="@*"/>
      <xsl:processing-instruction name="tsnum">
        <xsl:value-of select="$this-topic-number"/>    
      </xsl:processing-instruction>
      <xsl:processing-instruction name="tsstruct">
        <xsl:choose>
          <xsl:when test="ancestor::*[contains(@class, ' map/topicref ') and @chunk = 'to-content']">
            <xsl:text>topic-in-chunk</xsl:text>
          </xsl:when>
          <xsl:otherwise>
            <xsl:text>topic-standalone</xsl:text>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:processing-instruction>
      <xsl:call-template name="process-topic">
        <xsl:with-param name="t_tsnum" select="$this-topic-number" tunnel="yes"/>
        <xsl:with-param name="t_tsstruct" tunnel="yes">topic</xsl:with-param>
      </xsl:call-template>
      <xsl:apply-templates/>
    </xsl:copy>
  </xsl:template>

  <xsl:template name="get-topic-number">
    <xsl:param name="t_top-level-number" tunnel="yes"/>
    <xsl:variable name="local-number">
      <xsl:number
        count="
          *[contains(@class, ' map/topicref ')][not(
          ancestor-or-self::*[contains(@class, ' bookmap/frontmatter ')]
          )]"
        level="multiple" from="part | appendices"/>
    </xsl:variable>
    <xsl:value-of select="replace($local-number, '^[^\.]+', $t_top-level-number)"/>
  </xsl:template>

  <!-- Process topics -->
  <xsl:template name="process-topic">
    <xsl:variable name="no-id-href" select="replace(@href, '#.*', '')"/>
    <xsl:variable name="topic-in">
      <xsl:value-of select="concat($indir-uri, '/', $no-id-href)"/>
    </xsl:variable>
    <!--<xsl:message>zxzx: topic-in=<xsl:value-of select="$topic-in"/></xsl:message>-->
    <xsl:variable name="topic-out">
      <xsl:value-of select="concat($outdir-uri, '/', $no-id-href)"/>
    </xsl:variable>
    <!--<xsl:message>zxzx: topic-out=<xsl:value-of select="$topic-out"/></xsl:message>-->
    <xsl:variable name="process-this-topic" as="xs:boolean">
      <xsl:choose>
        <xsl:when
          test="preceding::*[contains(@class, ' map/topicref ') and replace(@href, '#.*', '') = $no-id-href]">
          <xsl:value-of select="false()"/>
        </xsl:when>
        <xsl:when test="ancestor::*[contains(@class, ' map/topicref ') and @chunk = 'to-content']">
          <xsl:value-of select="false()"/>
        </xsl:when>
        <xsl:when test="doc-available($topic-out)">
          <xsl:value-of select="false()"/>
        </xsl:when>
        <xsl:when test="doc-available($topic-in)">
          <xsl:value-of select="true()"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="false()"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:if test="$process-this-topic">
      <xsl:result-document href="{$topic-out}">
        <xsl:apply-templates select="doc($topic-in)"/>
      </xsl:result-document>
    </xsl:if>
  </xsl:template>


  <!-- Process single topics -->
  <xsl:template
    match="*[contains(@class, ' topic/topic ') and not(exists(ancestor::*[contains(@class, ' topic/topic ')]))]"
    priority="5">
    <xsl:param name="t_tsnum" tunnel="yes"/>
    <xsl:param name="t_tsstruct" tunnel="yes"/>
    <xsl:copy>
      <xsl:copy-of select="@*"/>
      <xsl:processing-instruction name="tsnum"><xsl:value-of select="$t_tsnum"/></xsl:processing-instruction>
      <xsl:processing-instruction name="tsstruct"><xsl:value-of select="$t_tsstruct"/></xsl:processing-instruction>
      <xsl:apply-templates>
        <xsl:with-param name="t_current-topic-number" tunnel="yes" select="$t_tsnum"/>
      </xsl:apply-templates>
    </xsl:copy>
  </xsl:template>

  <!-- Process topics that are inside of other topics -->
  <xsl:template
    match="*[contains(@class, ' topic/topic ') and exists(ancestor::*[contains(@class, ' topic/topic ')])]"
    priority="5">
    <xsl:param name="t_tsnum" tunnel="yes"/>
    <xsl:variable name="number-in-topic">
      <xsl:number count="*[contains(@class, ' topic/topic ')]" level="multiple"/>
    </xsl:variable>
    <xsl:variable name="this-topic-number" select="replace($number-in-topic, '^[^\.]+', $t_tsnum)"/>
    <xsl:copy>
      <xsl:copy-of select="@*"/>
      <xsl:processing-instruction name="tsnum"><xsl:value-of select="$this-topic-number"/></xsl:processing-instruction>
      <xsl:processing-instruction name="tsstruct">topic-in-chunk</xsl:processing-instruction>
      <xsl:apply-templates>
        <xsl:with-param name="t_current-topic-number" tunnel="yes" select="$this-topic-number"/>
      </xsl:apply-templates>
    </xsl:copy>
  </xsl:template>

  <xsl:template match="*[contains(@class, ' topic/topic ')]/*[contains(@class, ' topic/title ')]">
    <xsl:param name="t_current-topic-number" tunnel="yes"/>
    <xsl:copy>
      <xsl:copy-of select="@*"/>
      <xsl:if test="$numbered-titles">
        <xsl:value-of select="$t_current-topic-number"/>
        <xsl:text> </xsl:text>
      </xsl:if>
      <xsl:apply-templates/>
    </xsl:copy>
  </xsl:template>

  <!-- Default rules -->
  <xsl:template match="*">
    <xsl:copy>
      <xsl:copy-of select="@*"/>
      <xsl:apply-templates/>
    </xsl:copy>
  </xsl:template>

  <xsl:template match="processing-instruction()">
    <xsl:copy/>
  </xsl:template>

</xsl:stylesheet>
