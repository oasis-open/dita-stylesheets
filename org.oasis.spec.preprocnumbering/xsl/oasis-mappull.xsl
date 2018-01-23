<?xml version="1.0"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns:mappull="http://dita-ot.sourceforge.net/ns/200704/mappull"
  xmlns:ditamsg="http://dita-ot.sourceforge.net/ns/200704/ditamsg"
  exclude-result-prefixes="mappull ditamsg xs">

  <!-- Thomas: The introduction of <submap> in 2.x made it practically impossible to do counting
       ahead of mapplink.xsl without unwrapping <submap> first. Variable counting-map is a
       version of the resolved map the <submap> element has been unwrapped so that it will not
       interfere with counting. The numbered-map variable is a copy of counting-map that has
       been decorated with section numbers. Finally, xsl:key section-number-lookup is a structure that
       makes it easy to access section numbers through the keys() function. Notice that
       that the keys() function has the "top" argument pointing to numbered-map rather than
       to the main document. 09oct17-->

  <!-- Thomas: Begin counting-map -->
  <xsl:variable name="counting-map">
    <map class=" map/map " role="variable-wrapper">
      <xsl:apply-templates select="/*" mode="build-counting-map"/>
    </map>
  </xsl:variable>

  <xsl:template match="*[contains(@class, ' map/map ')]">
    <xsl:copy>
      <xsl:apply-templates select="* | @* | comment() | processing-instruction() | text()"/>
    </xsl:copy>
    <!--<xsl:result-document href="file:/C:/Users/bob/Desktop/counting.xml" method="xml" indent="yes">
      <xsl:copy-of select="$counting-map"/>
    </xsl:result-document>
    <xsl:result-document href="file:/C:/Users/bob/Desktop/numbered.xml" method="xml" indent="yes">
      <xsl:copy-of select="$numbered-map"/>
    </xsl:result-document>-->
  </xsl:template>

  <xsl:template match="*[contains(@class, ' map/map ')]" mode="build-counting-map">
    <xsl:apply-templates mode="build-counting-map"/>
  </xsl:template>

  <xsl:template match="submap" mode="build-counting-map" priority="5">
    <xsl:apply-templates mode="build-counting-map"/>
  </xsl:template>

  <xsl:template match="frontmatter | reltable | backmatter" mode="build-counting-map" priority="5"/>

  <xsl:template match="*[contains(@class, ' map/topicref ')][not(empty(@href))]"
    mode="build-counting-map">
    <xsl:element name="{name(.)}">
      <xsl:attribute name="id" select="generate-id()"/>
      <xsl:copy-of select="@class"/>
      <xsl:apply-templates mode="build-counting-map"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="text() | processing-instruction()" mode="build-counting-map"/>
  <!-- Thomas: End counting-map -->

  <!-- Thomas: Begin numbered-map -->
  <xsl:variable name="numbered-map">
    <map class=" map/map " role="variable-wrapper">
      <xsl:apply-templates select="$counting-map/*" mode="build-numbered-map"/>
    </map>
  </xsl:variable>

  <xsl:template match="*[contains(@class, ' map/map ')]" mode="build-numbered-map">
    <xsl:apply-templates mode="build-numbered-map"/>
  </xsl:template>

  <xsl:template match="*[contains(@class, ' bookmap/appendix ')]" mode="build-numbered-map"
    priority="5">
    <xsl:variable name="chapter-number">
      <xsl:number format="A" count="*[contains(@class, ' bookmap/appendix ')]"/>
    </xsl:variable>
    <xsl:copy>
      <xsl:for-each select="@*">
        <xsl:copy/>
      </xsl:for-each>
      <xsl:attribute name="section-number" select="$chapter-number"/>
      <xsl:apply-templates mode="build-numbered-map">
        <xsl:with-param name="t_top-level-number" select="$chapter-number" tunnel="yes"/>
      </xsl:apply-templates>
    </xsl:copy>
  </xsl:template>

  <xsl:template match="*[contains(@class, ' bookmap/chapter ')]" mode="build-numbered-map"
    priority="5">
    <xsl:variable name="chapter-number">
      <xsl:number format="1" count="*[contains(@class, ' bookmap/chapter ')]"/>
    </xsl:variable>
    <xsl:copy>
      <xsl:for-each select="@*">
        <xsl:copy/>
      </xsl:for-each>
      <xsl:attribute name="section-number" select="$chapter-number"/>
      <xsl:apply-templates mode="build-numbered-map">
        <xsl:with-param name="t_top-level-number" select="$chapter-number" tunnel="yes"/>
      </xsl:apply-templates>
    </xsl:copy>
  </xsl:template>

  <xsl:template match="*[contains(@class, ' map/topicref ')]" mode="build-numbered-map">
    <xsl:param name="t_top-level-number" tunnel="yes"/>
    <xsl:variable name="local-number">
      <xsl:number count="
          *[contains(@class, ' map/topicref ')]" level="multiple"
        from="*[contains(@class, ' bookmap/chapter ')] | *[contains(@class, ' bookmap/appendix ')]"
      />
    </xsl:variable>
    <xsl:copy>
      <xsl:for-each select="@*">
        <xsl:copy/>
      </xsl:for-each>
      <xsl:attribute name="section-number">
        <xsl:value-of select="concat($t_top-level-number, '.', $local-number)"/>
      </xsl:attribute>
      <xsl:apply-templates mode="build-numbered-map">
        <xsl:with-param name="t_top-level-number" select="$t_top-level-number" tunnel="yes"/>
      </xsl:apply-templates>
    </xsl:copy>
  </xsl:template>
  <!-- Thomas: End numbered-map -->

  <!-- Thomas: Use with the top argument set to $numbered-map. -->
  <xsl:key name="section-number-lookup" match="*[not(empty(@section-number))]" use="@id"/>

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
      <xsl:variable name="currentId" select="generate-id(.)"/>
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
          <!-- Thomas: Notice that the "top" argument is pointing to variable $numbered-map rather than
               to the document. 09oct17-->
          <xsl:value-of
            select="key('section-number-lookup', $currentId, $numbered-map)/@section-number"/>
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

  <xsl:template match="*" mode="get-section-number">
    <xsl:apply-templates mode="get-section-number"/>
  </xsl:template>

  <xsl:template match="*[contains(@class, ' map/topicref ')]" mode="get-section-number">
    <xsl:param name="currentId" tunnel="yes"/>
    <xsl:param name="Format" tunnel="yes"/>
    <!--<xsl:message>oasis-mappull.xsl: Received Format=<xsl:value-of select="$Format"/></xsl:message>-->
    <xsl:choose>
      <xsl:when test="@id = $currentId">
        <xsl:number count="*[contains(@class, ' map/topicref ')]" level="multiple"
          format="{$Format}"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:apply-templates mode="get-section-number"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

</xsl:stylesheet>
