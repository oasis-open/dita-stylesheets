<?xml version='1.0' encoding='utf-8'?>
<xsl:stylesheet version="2.0" xmlns:ditaarch="http://dita.oasis-open.org/architecture/2005/"
  xmlns:dita-ot="http://dita-ot.sourceforge.net/ns/201007/dita-ot"
  xmlns:spdf="org.oasis.spec.pdf" xmlns:fo="http://www.w3.org/1999/XSL/Format"
  xmlns:opentopic="http://www.idiominc.com/opentopic"
  xmlns:opentopic-mapmerge="http://www.idiominc.com/opentopic/mapmerge"
  xmlns:opentopic-func="http://www.idiominc.com/opentopic/exsl/function"
  xmlns:related-links="http://dita-ot.sourceforge.net/ns/200709/related-links"
  xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  exclude-result-prefixes="ditaarch opentopic spdf dita-ot opentopic-mapmerge opentopic-func related-links xs">

  <xsl:template match="*[contains(@class, ' topic/link ')]" mode="related-links:result-group"
    name="related-links:group-result." as="element()" priority="-10">
    <xsl:param name="links" as="node()*"/>
    <xsl:if test="exists($links)">
      <linklist class="- topic/linklist " outputclass="relinfo">
        <!-- Add rellinktitle outputclass -->
        <title class="- topic/title " outputclass="rellinktitle">
          <xsl:call-template name="getVariable">
            <xsl:with-param name="id" select="'Related information'"/>
          </xsl:call-template>
        </title>
        <xsl:copy-of select="$links"/>
      </linklist>
    </xsl:if>
  </xsl:template>

  <xsl:template match="*[contains(@class, ' topic/link ')][@type = 'concept']"
    mode="related-links:result-group" name="related-links:result.concept" as="element()">
    <xsl:param name="links" as="node()*"/>
    <xsl:if test="normalize-space(string-join($links, ''))">
      <linklist class="- topic/linklist " outputclass="relinfo relconcepts">
        <!-- Add rellinktitle outputclass -->
        <title class="- topic/title " outputclass="rellinktitle">
          <xsl:call-template name="getVariable">
            <xsl:with-param name="id" select="'Related concepts'"/>
          </xsl:call-template>
        </title>
        <xsl:copy-of select="$links"/>
      </linklist>
    </xsl:if>
  </xsl:template>

  <xsl:template match="*[contains(@class, ' topic/link ')][@type = 'reference']"
    mode="related-links:result-group" name="related-links:result.reference" as="element()">
    <xsl:param name="links"/>
    <xsl:if test="normalize-space(string-join($links, ''))">
      <linklist class="- topic/linklist " outputclass="relinfo relref">
        <!-- Add rellinktitle outputclass -->
        <title class="- topic/title " outputclass="rellinktitle">
          <xsl:call-template name="getVariable">
            <xsl:with-param name="id" select="'Related reference'"/>
          </xsl:call-template>
        </title>
        <xsl:copy-of select="$links"/>
      </linklist>
    </xsl:if>
  </xsl:template>

  <xsl:template match="*[contains(@class, ' topic/link ')][@type = 'task']"
    mode="related-links:result-group" name="related-links:result.task" as="element()">
    <xsl:param name="links" as="node()*"/>
    <xsl:if test="normalize-space(string-join($links, ''))">
      <linklist class="- topic/linklist " outputclass="relinfo reltasks">
        <!-- Add rellinktitle outputclass -->
        <title class="- topic/title " outputclass="rellinktitle">
          <xsl:call-template name="getVariable">
            <xsl:with-param name="id" select="'Related tasks'"/>
          </xsl:call-template>
        </title>
        <xsl:copy-of select="$links"/>
      </linklist>
    </xsl:if>
  </xsl:template>
  
  <xsl:template match="*[contains(@class, ' topic/xref ')]" name="topic.xref">
    <fo:inline>
      <xsl:call-template name="commonattributes"/>
    </fo:inline>

    <xsl:variable name="destination" select="opentopic-func:getDestinationId(@href)"/>
    <xsl:variable name="element" select="key('key_anchor', $destination, $root)[1]"/>

    <xsl:variable name="referenceTitle" as="node()*">
      <xsl:apply-templates select="." mode="insertReferenceTitle">
        <xsl:with-param name="href" select="@href"/>
        <xsl:with-param name="titlePrefix" select="''"/>
        <xsl:with-param name="destination" select="$destination"/>
        <xsl:with-param name="element" select="$element"/>
      </xsl:apply-templates>
    </xsl:variable>

    <fo:basic-link xsl:use-attribute-sets="xref">
      <xsl:call-template name="buildBasicLinkDestination">
        <xsl:with-param name="scope" select="@scope"/>
        <xsl:with-param name="format" select="@format"/>
        <xsl:with-param name="href" select="@href"/>
      </xsl:call-template>
      <xsl:if  test="ancestor::*[contains(@outputclass, 'cover')]">        
        <xsl:attribute name="color">blue</xsl:attribute>
        <xsl:attribute name="text-decoration">underline</xsl:attribute>        
      </xsl:if>

      <xsl:choose>
        <xsl:when
          test="not(@scope = 'external' or not(empty(@format) or @format = 'dita')) and exists($referenceTitle)">
          <xsl:copy-of select="$referenceTitle"/>
        </xsl:when>
        <xsl:when test="not(@scope = 'external' or not(empty(@format) or @format = 'dita'))">
          <xsl:call-template name="insertPageNumberCitation">
            <xsl:with-param name="isTitleEmpty" select="true()"/>
            <xsl:with-param name="destination" select="$destination"/>
            <xsl:with-param name="element" select="$element"/>
          </xsl:call-template>
        </xsl:when>
        <xsl:otherwise>
          <xsl:choose>
            <xsl:when test="*[not(contains(@class, ' topic/desc '))] | text()">
              <xsl:apply-templates select="*[not(contains(@class, ' topic/desc '))] | text()"/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:value-of select="@href"/>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:otherwise>
      </xsl:choose>
    </fo:basic-link>

    <!--
        Disable because of the CQ#8102 bug
        <xsl:if test="*[contains(@class,' topic/desc ')]">
          <xsl:call-template name="insertLinkDesc"/>
        </xsl:if>
    -->

    <xsl:if
      test="not(@scope = 'external' or not(empty(@format) or @format = 'dita')) and exists($referenceTitle) and not($element[contains(@class, ' topic/fn ')])">
      <!-- SourceForge bug 1880097: should not include page number when xref includes author specified text -->
      <!-- spec.pdf: Always include page number
        <xsl:if test="not(processing-instruction()[name() = 'ditaot'][. = 'usertext'])">-->
        <xsl:call-template name="insertPageNumberCitation">
          <xsl:with-param name="destination" select="$destination"/>
          <xsl:with-param name="element" select="$element"/>
        </xsl:call-template>
      <!--</xsl:if>-->
    </xsl:if>

  </xsl:template>
  
  <xsl:template name="insertLinkShortDesc">
    <xsl:param name="destination"/>
    <xsl:param name="element"/>
    <xsl:param name="linkScope"/>
    <xsl:choose>
      <!-- User specified description (from map or topic): use that. -->
      <xsl:when test="*[contains(@class,' topic/desc ')] and
        processing-instruction()[name()='ditaot'][.='usershortdesc']">
        <fo:block xsl:use-attribute-sets="link__shortdesc">
          <xsl:apply-templates select="*[contains(@class, ' topic/desc ')]"/>
        </fo:block>
      </xsl:when>
      <!-- External: do not attempt to retrieve. -->
      <xsl:when test="$linkScope='external'">
      </xsl:when>
      <!-- When the target has a short description and no local override, use the target -->
      <xsl:when test="$element/*[contains(@class, ' topic/shortdesc ')]">
        <fo:block xsl:use-attribute-sets="link__shortdesc">
          <xsl:apply-templates select="$element/*[contains(@class, ' topic/shortdesc ')]">
            <!-- spec.pdf: pass new parameter "forlink" to get inline processing for shortdesc content -->
            <xsl:with-param name="forlink" select="true()"/>
          </xsl:apply-templates>
        </fo:block>
      </xsl:when>
    </xsl:choose>
  </xsl:template>

</xsl:stylesheet>
