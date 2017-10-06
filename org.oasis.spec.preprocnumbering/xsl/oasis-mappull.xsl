<?xml version="1.0"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns:mappull="http://dita-ot.sourceforge.net/ns/200704/mappull"
  xmlns:ditamsg="http://dita-ot.sourceforge.net/ns/200704/ditamsg"
  exclude-result-prefixes="mappull ditamsg xs">

  <xsl:template name="getmetadata">
    <xsl:param name="type" as="xs:string"/>
    <xsl:param name="scope" as="xs:string">#none#</xsl:param>
    <xsl:param name="format" as="xs:string">#none#</xsl:param>
    <xsl:param name="file" as="xs:string"/>
    <xsl:param name="topicpos" as="xs:string"/>
    <xsl:param name="topicid" as="xs:string"/>
    <xsl:param name="classval" as="xs:string"/>
    <xsl:param name="navtitle" as="item()*"/>
    <xsl:param name="doc" as="document-node()?"/>
    <!--navtitle-->
    <xsl:choose>
      <xsl:when test="not($navtitle = '#none#')">
        <navtitle class="- topic/navtitle ">
          <xsl:copy-of select="$navtitle"/>
        </navtitle>
      </xsl:when>
      <xsl:otherwise>
        <xsl:apply-templates
          select="*[contains(@class, ' map/topicmeta ')]/*[contains(@class, ' topic/navtitle ')]"/>
      </xsl:otherwise>
    </xsl:choose>
    <!--linktext-->
    <xsl:apply-templates select="." mode="mappull:getmetadata_linktext">
      <xsl:with-param name="type" select="$type"/>
      <xsl:with-param name="scope" select="$scope"/>
      <xsl:with-param name="format" select="$format"/>
      <xsl:with-param name="file" select="$file"/>
      <xsl:with-param name="topicpos" select="$topicpos"/>
      <xsl:with-param name="topicid" select="$topicid"/>
      <xsl:with-param name="classval" select="$classval"/>
      <xsl:with-param name="doc" select="$doc"/>
    </xsl:apply-templates>
    <!--shortdesc-->
    <xsl:apply-templates select="." mode="mappull:getmetadata_shortdesc">
      <xsl:with-param name="type" select="$type"/>
      <xsl:with-param name="scope" select="$scope"/>
      <xsl:with-param name="format" select="$format"/>
      <xsl:with-param name="file" select="$file"/>
      <xsl:with-param name="topicpos" select="$topicpos"/>
      <xsl:with-param name="topicid" select="$topicid"/>
      <xsl:with-param name="classval" select="$classval"/>
      <xsl:with-param name="doc" select="$doc"/>
    </xsl:apply-templates>
    <!--metadata to be written - if we add logic at some point to pull metadata from topics into the map-->
    <xsl:apply-templates
      select="
        *[contains(@class, ' map/topicmeta ')]/*[not(contains(@class, ' map/linktext '))][not(contains(@class, ' map/shortdesc '))][not(contains(@class, ' topic/navtitle '))] |
        *[contains(@class, ' map/topicmeta ')]/processing-instruction()"/>

    <!-- BEGIN OASIS SPECIFIC PROCESSING -->
    <!-- If this is a local topic and in the TOC, figure out the section # -->
    <xsl:if test="$file != '' and $scope != 'peer' and $scope != 'external'">
      <xsl:variable name="localtoc">
        <xsl:call-template name="inherit">
          <xsl:with-param name="attrib">toc</xsl:with-param>
        </xsl:call-template>
      </xsl:variable>
      <xsl:variable name="localprocrole">
        <xsl:call-template name="inherit">
          <xsl:with-param name="attrib">processing-role</xsl:with-param>
        </xsl:call-template>
      </xsl:variable>
      <xsl:if
        test="
          not($localprocrole = 'resource-only') and
          not(ancestor::*[contains(@class, ' map/reltable ')]) and
          not($localtoc = 'no')">
        <xsl:variable name="section-number">
          <xsl:variable name="isAppendix">
            <xsl:choose>
              <xsl:when test="contains(@class, ' bookmap/appendix ')">yes</xsl:when>
              <!--<xsl:when test="ancestor::[@href or @navtitle or *[contains(@class, ' map/topicmeta ')]/*[contains(@class, ' topic/navtitle ')]]">no</xsl:when>
              <xsl:when test="ancestor::*[contains(@class,' bookmap/appendix ')]">yes</xsl:when>-->
              <xsl:otherwise>no</xsl:otherwise>
            </xsl:choose>
          </xsl:variable>
          <xsl:choose>
            <xsl:when test="$isAppendix = 'yes'">
              <xsl:variable name="appcount"
                select="
                  count(preceding-sibling::*[contains(@class, ' bookmap/appendix ')][name()!='submap']
                  [not(@processing-role = 'resource-only' or @toc = 'no')]
                  [@href or @navtitle or */*[contains(@class, ' map/topicmeta ')]]) + 1"/>
              <xsl:text>Appendix </xsl:text>
              <xsl:number value="number($appcount)" format="A"/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:number
                count="topicref|chapter[not(parent::submap)]|submap[child::*[1][name()='chapter']]"
                level="multiple"/>
              <!--<xsl:apply-templates select="parent::*" mode="count-section-number"/>
              <xsl:value-of
                select="
                  count(preceding-sibling::*[contains(@class, ' map/topicref ')]
                  [name()!='submap']
                  [not(@processing-role = 'resource-only' or @toc = 'no' or contains(@class, ' bookmap/frontmatter '))]
                  [@href or @navtitle or */*[contains(@class, ' map/topicmeta ')]] | preceding-sibling::submap/*[contains(@class, ' map/topicref ')][name()!='submap']) + 1"
              />-->
            </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <data class="- topic/data " name="topicid">
          <xsl:attribute name="value">
            <xsl:value-of select="document($file, /)/*[1]/@xtrf"/>
            <xsl:text>#</xsl:text>
            <xsl:choose>
              <xsl:when test="$topicid != '#none#'">
                <xsl:value-of select="$topicid"/>
              </xsl:when>
              <xsl:otherwise>
                <xsl:value-of
                  select="document($file, /)//*[contains(@class, ' topic/topic ')][1]/@id"/>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:attribute>
          <data class="- topic/data " name="number" value="{$section-number}"/>
        </data>
      </xsl:if>
    </xsl:if>
  </xsl:template>

  <xsl:template match="*[contains(@class, ' map/map ')]" mode="count-section-number"/>
  
  <xsl:template match="submap" mode="count-section-number">
    <xsl:apply-templates mode="count-section-number"/>
  </xsl:template>
  
  <xsl:template match="*[contains(@class, ' map/topicref ')]" mode="count-section-number">
    <xsl:variable name="isAppendix">
      <xsl:choose>
        <xsl:when test="contains(@class, ' bookmap/appendix ')">yes</xsl:when>
        <!--<xsl:when test="ancestor::[@href or @navtitle or *[contains(@class, ' map/topicmeta ')]/*[contains(@class, ' topic/navtitle ')]]">no</xsl:when>
        <xsl:when test="ancestor::*[contains(@class,' bookmap/appendix ')]">yes</xsl:when>-->
        <xsl:otherwise>no</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:choose>
      <xsl:when test="$isAppendix = 'yes'">
        <xsl:variable name="appcount"
          select="
            count(preceding-sibling::*[contains(@class, ' bookmap/appendix ')]
            [not(@processing-role = 'resource-only' or @toc = 'no')]
            [@href or @navtitle or */*[contains(@class, ' map/topicmeta ')]]) + 1"/>
        <xsl:number value="number($appcount)" format="A"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:apply-templates select="parent::*" mode="count-section-number"/>
        <xsl:value-of
          select="
          count(preceding-sibling::*[contains(@class, ' map/topicref ')][name()!='submap']
            [not(@processing-role = 'resource-only' or @toc = 'no' or contains(@class, ' bookmap/frontmatter '))]
            [@href or @navtitle or */*[contains(@class, ' map/topicmeta ')]]) + 1"
        />
      </xsl:otherwise>
    </xsl:choose>
    <xsl:text>.</xsl:text>
  </xsl:template>

</xsl:stylesheet>
