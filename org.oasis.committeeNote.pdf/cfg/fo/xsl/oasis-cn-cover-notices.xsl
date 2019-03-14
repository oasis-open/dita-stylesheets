<?xml version='1.0'?>

<!-- ===================== CHANGE LOG ================================ -->
<!--                                                                   -->
<!-- 05 Sep 2015 KJE: Added change log.                                -->
<!-- 31 Jan 2016 KJE: Replaced call to deprecated template             -->
<!-- 12 Jul 2016  BT: Changed xref from fo:inline to fo:basic-link     -->
<!-- 06 Mar 2019 KJE: Removed indentation from <dd>; made <dt> bold    -->
<!--                  and added padding-top                            -->
<!-- 14 Mar 2019 KJE: Restored code for suppressing map author on cover -->
<!--                                                                   -->
<!-- ================================================================= --> 

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:fo="http://www.w3.org/1999/XSL/Format" 
                xmlns:opentopic-func="http://www.idiominc.com/opentopic/exsl/function"
                version="2.0">
  
  <!-- Tagsmiths: The next several templates with mode="cover" are responsible for outputting
    the cover topic -29oct13 -->

  <!-- 06 Mar 2019 KJE: Targets oasis-cover.dita -->
  <xsl:template match="*[contains(@class, ' topic/topic ') and contains(@outputclass, 'cover')]" mode="cover">
    <xsl:apply-templates mode="cover"/>
  </xsl:template>

  <!--14 Mar 2019 KJE: Suppress rendering the map author under "Specification URIs"--> 
  <xsl:template match="*[contains(@class, ' topic/author ')]" mode="cover notices">
  </xsl:template>

  <!-- 06 Mar 2019 KJE: Applies oasis-h3 attribute set to oasis-cover.dita -->
  <xsl:template
    match="*[contains(@class, ' topic/topic ') and contains(@outputclass, 'cover')]/*[contains(@class, ' topic/title ')]"
    mode="cover">
    <fo:block xsl:use-attribute-sets="oasis-h3">
      <xsl:value-of select="."/>
    </fo:block>
  </xsl:template>

  <!-- 06 Mar 2019 KJE: Targets oasis-cover.dita -->
  <xsl:template match="*[contains(@class, ' topic/section ')]" mode="cover">
    <xsl:for-each select="*">
      <xsl:choose>
        <!-- 06 Mar 2019 KJE: Applies cover_category_label attribute set and adds a colon to title in oasis-cover.dita  -->
        <xsl:when test="contains(@class, ' topic/title ')">
          <fo:block xsl:use-attribute-sets="cover_category_label"
            ><xsl:apply-templates/>:</fo:block>
        </xsl:when>
        <!--  06 Mar 2019 KJE: Applies template to definition list used in "Citation format" -->
        <xsl:when test="contains(@class, ' topic/dl ')">
          <xsl:apply-templates select="." mode="cover"/>
        </xsl:when>
        <xsl:otherwise>
          <!--  06 Mar 2019 KJE:If it'a NOT a title or dl, apply attribute set -->
          <fo:block xsl:use-attribute-sets="frontmatter-indent">
            <xsl:apply-templates select="."/>
          </fo:block>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:for-each>
  </xsl:template>

  <xsl:template match="*[contains(@class, ' topic/dl ')]" mode="cover">
    <xsl:apply-templates mode="cover"/>
  </xsl:template>

  <xsl:template match="*[contains(@class, ' topic/dlentry ')]" mode="cover">
    <fo:block xsl:use-attribute-sets="frontmatter-indent">
      <xsl:apply-templates mode="cover"/>
    </fo:block>
  </xsl:template>

  <!--  06 Mar 2019 KJE: Apply bold formatting to dt on cover page -->
  <xsl:template match="*[contains(@class, ' topic/dt ')]" mode="cover">
    <fo:block>
      <xsl:attribute name="font-weight">bold</xsl:attribute>
      <xsl:apply-templates/>
    </fo:block>
  </xsl:template>

  <!--  06 Mar 2019 KJE: For dt on cover page, make flush left with margin and add some padding -->
  <xsl:template match="*[contains(@class, ' topic/dd ')]" mode="cover">
    <fo:block>
      <xsl:attribute name="margin-left">0in</xsl:attribute>      
      <xsl:attribute name="padding-top">5pt</xsl:attribute>
      <xsl:apply-templates/>
    </fo:block>
  </xsl:template>

  <!-- Tagsmiths: The next several templates with mode="notices" are responsible for outputting
    the notices topic -29oct13 -->

  <xsl:template match="*[contains(@class, ' topic/section ')]" mode="notices">
    <xsl:for-each select="*">
      <xsl:choose>
        <xsl:when test="contains(@class, ' topic/title ')">
          <fo:block xsl:use-attribute-sets="cover_category_label"
            ><xsl:apply-templates/>:</fo:block>
        </xsl:when>
        <xsl:otherwise>
          <fo:block>
            <xsl:apply-templates select="."/>
          </fo:block>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:for-each>
  </xsl:template>

  <xsl:template match="*[contains(@class, ' topic/topic ') and contains(@outputclass, 'frontmatternotices')]"
    mode="notices">
    <xsl:apply-templates mode="notices"/>
  </xsl:template>
  <xsl:template
    match="*[contains(@class, ' topic/topic ') and contains(@outputclass, 'frontmatternotices')]/*[contains(@class, ' topic/title ')]"
    mode="notices">
    <fo:block xsl:use-attribute-sets="oasis-h2">
      <xsl:apply-templates/>
    </fo:block>
  </xsl:template>

  <!-- Apply styling for xrefs on cover page -->
  <xsl:template match="*[contains(@class, ' topic/xref ') and contains(@outputclass, 'no-italics')]">
    <fo:basic-link xsl:use-attribute-sets="cover_xref">
      <xsl:call-template name="buildBasicLinkDestination">
        <xsl:with-param name="scope" select="@scope"/>
        <xsl:with-param name="format" select="@format"/>
        <xsl:with-param name="href" select="@href"/>
      </xsl:call-template>
      <xsl:apply-templates/>
    </fo:basic-link>
  </xsl:template>

  <xsl:template
    match="*[contains(@class, ' topic/xref ') and contains(@outputclass, 'no-italics')]/*[contains(@class, ' topic/keyword ')]">
    <xsl:apply-templates/>
  </xsl:template>

  <!-- Tagsmiths override sl for outputclass=no-indent used in cover. Also, fire keep
    rule when sl is in cover. -30oct13 -->
  <xsl:template name="insertPageNumberCitation">
    <xsl:param name="isTitleEmpty"/>
    <xsl:param name="destination"/>
    <xsl:param name="element"/>

    <xsl:choose>
      <xsl:when test="not($element) or ($destination = '')"/>
      <xsl:when test="$isTitleEmpty">
        <fo:inline>
          <xsl:call-template name="getVariable">
            <xsl:with-param name="id" select="'Page'"/>
            <xsl:with-param name="params">
              <pagenum>
                <fo:inline>
                  <fo:page-number-citation ref-id="{$destination}"/>
                </fo:inline>
              </pagenum>
            </xsl:with-param>
          </xsl:call-template>
        </fo:inline>
      </xsl:when>
      <xsl:otherwise>
        <fo:inline xsl:use-attribute-sets="pagenum">
          <xsl:call-template name="getVariable">
            <xsl:with-param name="id" select="'On the page'"/>
            <xsl:with-param name="params">
              <pagenum>
                <fo:inline>
                  <fo:page-number-citation ref-id="{$destination}"/>
                </fo:inline>
              </pagenum>
            </xsl:with-param>
          </xsl:call-template>
        </fo:inline>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <!-- Tagsmiths override p for outputclass=no-space-before used on cover. -30oct13 -->
  <!-- <xsl:template match="*[contains(@class, ' topic/xref ')][@type = 'fn']" priority="2">
    <xsl:variable name="href-fragment" select="substring-after(@href, '#')"/>
    <xsl:variable name="footnote-target"
      select="
        //*[contains(@class, ' topic/fn ')]
        [@id = substring-after($href-fragment, '/')]
        [ancestor::*[contains(@class, ' topic/topic ')]
        [1]/@id = substring-before($href-fragment, '/')]"/>
    <xsl:variable name="destination" select="opentopic-func:getDestinationId(@href)"/>
    <xsl:variable name="element" select="key('key_anchor', $destination)[1]"/>
    <xsl:variable name="referenceTitle">
      <xsl:apply-templates select="$footnote-target" mode="footnote-callout"/>
    </xsl:variable>
    <!-\- Tagsmiths: Make callout an active link. 05jun15 -\->
    <fo:basic-link xsl:use-attribute-sets="xref">
      <xsl:call-template name="xref_guts">
        <xsl:with-param name="destination" select="$destination"/>
        <xsl:with-param name="element" select="$element"/>
        <xsl:with-param name="referenceTitle" select="$referenceTitle"/>
      </xsl:call-template>
    </fo:basic-link>
  </xsl:template>-->

  <xsl:template match="*[contains(@class, ' topic/fn ')]" mode="footnote-callout">
    <fo:inline xsl:use-attribute-sets="fn__callout">
      <xsl:choose>
        <xsl:when test="@callout">
          <xsl:value-of select="@callout"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:number level="any" count="*[contains(@class, ' topic/fn ') and not(@callout)]"/>
        </xsl:otherwise>
      </xsl:choose>

    </fo:inline>
  </xsl:template>

  <!-- Tagsmiths override sl for outputclass=no-indent used in cover. Also, fire keep
    rule when sl is in cover. -30oct13 -->
  <xsl:template match="*[contains(@class, ' ut-d/imagemap ')]">
    <fo:inline>
      <xsl:call-template name="commonattributes"/>
    </fo:inline>
    <xsl:apply-templates select="*[contains(@class, ' topic/image ')]"/>
    <!-- Tagsmiths: Suppress the numbered list for xrefs in the imagemap. 17jun15 -->
    <!--<fo:list-block xsl:use-attribute-sets="ol">
      <xsl:apply-templates select="*[contains(@class,' ut-d/area ')]"/>
    </fo:list-block>-->
  </xsl:template>

  <!-- Tagsmiths override sl for outputclass=no-indent used in cover. Also, fire keep
    rule when sl is in cover. -30oct13 -->
  <xsl:template match="*[contains(@class, ' topic/sl ')]">
    <xsl:choose>
      <xsl:when test="@outputclass = 'no-indent'">
        <fo:list-block xsl:use-attribute-sets="cover_sl">
          <xsl:call-template name="commonattributes"/>
          <xsl:apply-templates/>
        </fo:list-block>
      </xsl:when>
      <xsl:otherwise>
        <fo:list-block xsl:use-attribute-sets="sl">
          <xsl:if test="ancestor::*[@outputclass = 'cover']">
            <xsl:attribute name="keep-with-previous.within-page">always</xsl:attribute>
          </xsl:if>
          <xsl:call-template name="commonattributes"/>
          <xsl:apply-templates/>
        </fo:list-block>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <!-- Tagsmiths override p for outputclass=no-space-before used on cover. -30oct13 -->
  <xsl:template match="*[contains(@class, ' topic/p ')]">
    <xsl:choose>
      <xsl:when
        test="
          ancestor::*[contains(@class, ' topic/topic ')][@outputclass = 'cover'] and
          preceding-sibling::*[contains(@class, ' topic/title ')]">
        <fo:block xsl:use-attribute-sets="cover_p">
          <xsl:call-template name="commonattributes"/>
          <xsl:apply-templates/>
        </fo:block>
      </xsl:when>
      <xsl:otherwise>
        <fo:block xsl:use-attribute-sets="p">
          <xsl:call-template name="commonattributes"/>
          <xsl:apply-templates/>
        </fo:block>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

</xsl:stylesheet>

