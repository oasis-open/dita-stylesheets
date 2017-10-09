<?xml version="1.0"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns:dita-ot="http://dita-ot.sourceforge.net/ns/201007/dita-ot"
  exclude-result-prefixes="xs dita-ot">

  <xsl:param name="OASIS-COVERPAGE"/>

  <!-- Override processing for next/previous links. Ignore @collection-type; create next/previous
       from the first topic to the last. -->
  <xsl:template
    match="
      *[contains(@class, ' map/topicref ')]
      [ancestor::*[contains(@class, ' map/map ')][@outputclass = 'specification']]
      [not(ancestor::*[contains(concat(' ', @chunk, ' '), ' to-content ')])]
      [not(ancestor::*[contains(@class, ' map/reltable ')])]"
    mode="link-to-next-prev">
    <xsl:param name="pathBackToMapDirectory"/>

    <xsl:choose>
      <xsl:when
        test="contains(@class, ' bookmap/chapter ') and count(preceding-sibling::*[contains(@class, ' bookmap/chapter ')]) = 0">
        <link class="- topic/link " format="html" role="previous">
          <xsl:attribute name="href">
            <xsl:value-of select="$pathBackToMapDirectory"/>
            <xsl:value-of select="$OASIS-COVERPAGE"/>
          </xsl:attribute>
          <linktext class="- topic/linktext ">
            <xsl:apply-templates
              select="
                /*/*[@outputclass = 'specificationTitles']/*[@outputclass = 'specificationShorttitle']/* |
                /*/*[@outputclass = 'specificationTitles']/*[@outputclass = 'specificationShorttitle']/text()"/>
            <xsl:text> cover page</xsl:text>
          </linktext>
        </link>
      </xsl:when>
      <xsl:when
        test="
          preceding-sibling::*[contains(@class, ' map/topicref ')][1]
          //*[contains(@class, ' map/topicref ')]
          [@href]
          [not(@href = '')]
          [not(@linking = 'none' or @linking = 'sourceonly')]
          [not(@processing-role = 'resource-only')]">
        <xsl:apply-templates mode="link"
          select="(preceding-sibling::*[contains(@class, ' map/topicref ')]//*[contains(@class, ' map/topicref ')][@href][not(@href = '')][not(@linking = 'none')][not(@linking = 'sourceonly')][not(@processing-role = 'resource-only')])[last()]">
          <xsl:with-param name="role">previous</xsl:with-param>
          <xsl:with-param name="pathBackToMapDirectory" select="$pathBackToMapDirectory"/>
        </xsl:apply-templates>
      </xsl:when>
      <xsl:when
        test="preceding-sibling::*[contains(@class, ' map/topicref ')][@href][not(@href = '')][not(@linking = 'none')][not(@linking = 'sourceonly')][not(@processing-role = 'resource-only')]">
        <xsl:apply-templates mode="link"
          select="preceding-sibling::*[contains(@class, ' map/topicref ')][@href][not(@href = '')][not(@linking = 'none')][not(@linking = 'sourceonly')][not(@processing-role = 'resource-only')][1]">
          <xsl:with-param name="role">previous</xsl:with-param>
          <xsl:with-param name="pathBackToMapDirectory" select="$pathBackToMapDirectory"/>
        </xsl:apply-templates>
      </xsl:when>
      <xsl:when test="contains(@class, ' bookmap/chapter ')">
        <!-- This is a chapter, with no previous chapters or topics; link to coverpage -->
        <link class="- topic/link " format="html" role="previous">
          <xsl:attribute name="href">
            <xsl:value-of select="$pathBackToMapDirectory"/>
            <xsl:value-of select="$OASIS-COVERPAGE"/>
          </xsl:attribute>
          <linktext class="- topic/linktext ">
            <xsl:apply-templates
              select="
                /*/*[@outputclass = 'specificationTitles']/*[@outputclass = 'specificationShorttitle']/* |
                /*/*[@outputclass = 'specificationTitles']/*[@outputclass = 'specificationShorttitle']/text()"/>
            <xsl:text> cover page</xsl:text>
          </linktext>
        </link>
      </xsl:when>
      <xsl:otherwise>
        <xsl:apply-templates mode="link"
          select="parent::*[contains(@class, ' map/topicref ')][@href][not(@href = '')][not(@linking = 'none')][not(@linking = 'sourceonly')][not(@processing-role = 'resource-only')][1]">
          <xsl:with-param name="role">previous</xsl:with-param>
          <xsl:with-param name="pathBackToMapDirectory" select="$pathBackToMapDirectory"/>
        </xsl:apply-templates>
      </xsl:otherwise>
    </xsl:choose>

    <!--<xsl:apply-templates mode="link" 
          select="following::*[contains(@class, ' map/topicref ')][@href][not(@href='')][not(@linking='none')][not(@linking='sourceonly')][not(@processing-role='resource-only')][not(ancestor::*[contains(@class,' map/reltable ')])][1]">
          <xsl:with-param name="role">next</xsl:with-param>
          <xsl:with-param name="pathBackToMapDirectory" 
            select="$pathBackToMapDirectory"/>
        </xsl:apply-templates>-->

    <xsl:choose>
      <xsl:when
        test="*[contains(@class, ' map/topicref ')][@href][not(@href = '')][not(@linking = 'none')][not(@linking = 'sourceonly')][not(@processing-role = 'resource-only')]">
        <xsl:apply-templates mode="link"
          select="*[contains(@class, ' map/topicref ')][@href][not(@href = '')][not(@linking = 'none')][not(@linking = 'sourceonly')][not(@processing-role = 'resource-only')][1]">
          <xsl:with-param name="role">next</xsl:with-param>
          <xsl:with-param name="pathBackToMapDirectory" select="$pathBackToMapDirectory"/>
        </xsl:apply-templates>
      </xsl:when>
      <xsl:when
        test="following-sibling::*[contains(@class, ' map/topicref ')][@href][not(@href = '')][not(@linking = 'none')][not(@linking = 'sourceonly')][not(@processing-role = 'resource-only')]">
        <xsl:apply-templates mode="link"
          select="following-sibling::*[contains(@class, ' map/topicref ')][@href][not(@href = '')][not(@linking = 'none')][not(@linking = 'sourceonly')][not(@processing-role = 'resource-only')][1]">
          <xsl:with-param name="role">next</xsl:with-param>
          <xsl:with-param name="pathBackToMapDirectory" select="$pathBackToMapDirectory"/>
        </xsl:apply-templates>
      </xsl:when>
      <xsl:when
        test="../following-sibling::*[contains(@class, ' map/topicref ')][@href][not(@href = '')][not(@linking = 'none')][not(@linking = 'sourceonly')][not(@processing-role = 'resource-only')]">
        <xsl:apply-templates mode="link"
          select="../following-sibling::*[contains(@class, ' map/topicref ')][@href][not(@href = '')][not(@linking = 'none')][not(@linking = 'sourceonly')][not(@processing-role = 'resource-only')][1]">
          <xsl:with-param name="role">next</xsl:with-param>
          <xsl:with-param name="pathBackToMapDirectory" select="$pathBackToMapDirectory"/>
        </xsl:apply-templates>
      </xsl:when>
      <xsl:when
        test="../../following-sibling::*[contains(@class, ' map/topicref ')][@href][not(@href = '')][not(@linking = 'none')][not(@linking = 'sourceonly')][not(@processing-role = 'resource-only')]">
        <xsl:apply-templates mode="link"
          select="../../following-sibling::*[contains(@class, ' map/topicref ')][@href][not(@href = '')][not(@linking = 'none')][not(@linking = 'sourceonly')][not(@processing-role = 'resource-only')][1]">
          <xsl:with-param name="role">next</xsl:with-param>
          <xsl:with-param name="pathBackToMapDirectory" select="$pathBackToMapDirectory"/>
        </xsl:apply-templates>
      </xsl:when>
      <xsl:when
        test="../../../following-sibling::*[contains(@class, ' map/topicref ')][@href][not(@href = '')][not(@linking = 'none')][not(@linking = 'sourceonly')][not(@processing-role = 'resource-only')]">
        <xsl:apply-templates mode="link"
          select="../../../following-sibling::*[contains(@class, ' map/topicref ')][@href][not(@href = '')][not(@linking = 'none')][not(@linking = 'sourceonly')][not(@processing-role = 'resource-only')][1]">
          <xsl:with-param name="role">next</xsl:with-param>
          <xsl:with-param name="pathBackToMapDirectory" select="$pathBackToMapDirectory"/>
        </xsl:apply-templates>
      </xsl:when>
      <xsl:when
        test="../../../../following-sibling::*[contains(@class, ' map/topicref ')][@href][not(@href = '')][not(@linking = 'none')][not(@linking = 'sourceonly')][not(@processing-role = 'resource-only')]">
        <xsl:apply-templates mode="link"
          select="../../../../following-sibling::*[contains(@class, ' map/topicref ')][@href][not(@href = '')][not(@linking = 'none')][not(@linking = 'sourceonly')][not(@processing-role = 'resource-only')][1]">
          <xsl:with-param name="role">next</xsl:with-param>
          <xsl:with-param name="pathBackToMapDirectory" select="$pathBackToMapDirectory"/>
        </xsl:apply-templates>
      </xsl:when>
      <xsl:when
        test="../../../../../following-sibling::*[contains(@class, ' map/topicref ')][@href][not(@href = '')][not(@linking = 'none')][not(@linking = 'sourceonly')][not(@processing-role = 'resource-only')]">
        <xsl:apply-templates mode="link"
          select="../../../../../following-sibling::*[contains(@class, ' map/topicref ')][@href][not(@href = '')][not(@linking = 'none')][not(@linking = 'sourceonly')][not(@processing-role = 'resource-only')][1]">
          <xsl:with-param name="role">next</xsl:with-param>
          <xsl:with-param name="pathBackToMapDirectory" select="$pathBackToMapDirectory"/>
        </xsl:apply-templates>
      </xsl:when>
    </xsl:choose>
  </xsl:template>
  
  <xsl:template mode="link" 
              match="*[@href and not(@href = '')][not(@linking = ('none', 'sourceonly'))][not(@processing-role = 'resource-only')]">
    <xsl:param name="role" as="xs:string?" select="()"/>
    <xsl:param name="otherrole" as="xs:string?" select="()"/>
    <xsl:param name="pathBackToMapDirectory" as="xs:string" tunnel="yes"/>
    <!-- child found tag -->
    <xsl:param name="found" select="true()" as="xs:boolean"/>
    <!-- If going to print, and @print=no, do not create links for this topicref -->
    <xsl:if test="not(($FINALOUTPUTTYPE = 'PDF' or $FINALOUTPUTTYPE = 'IDD') and @print = 'no') and 
                  not(@processing-role = 'resource-only') and $found">
      <link class="- topic/link ">
        <xsl:if test="@class">
          <xsl:attribute name="mapclass" select="@class"/>
        </xsl:if>
        <xsl:choose>
          <xsl:when test="ancestor-or-self::*[@scope]">
            <xsl:copy-of select="ancestor-or-self::*[@scope][1]/@scope"/>    
          </xsl:when>
          <xsl:otherwise>
            <xsl:attribute name="scope">local</xsl:attribute>
          </xsl:otherwise>
        </xsl:choose>
        <xsl:choose>
          <xsl:when test="ancestor-or-self::*[@format]">
            <xsl:copy-of select="ancestor-or-self::*[@format][1]/@format"/>    
          </xsl:when>
          <xsl:otherwise>
            <xsl:attribute name="format">dita</xsl:attribute>
          </xsl:otherwise>
        </xsl:choose>
        <xsl:copy-of select="ancestor-or-self::*[@type][1]/@type |
                             ancestor-or-self::*[@platform][1]/@platform |
                             ancestor-or-self::*[@product][1]/@product |
                             ancestor-or-self::*[@audience][1]/@audience |
                             ancestor-or-self::*[@otherprops][1]/@otherprops |
                             ancestor-or-self::*[@rev][1]/@rev"/>
        <xsl:copy-of select="@importance | @xtrf | @xtrc"/>
        <xsl:attribute name="href">
          <xsl:choose>
            <xsl:when test="starts-with(@href,'http://') or starts-with(@href,'/') or
                            starts-with(@href,'https://') or starts-with(@href,'ftp:/') or @scope = 'external'">
              <xsl:value-of select="@href"/>
            </xsl:when>
            <!-- If the target has a copy-to value, link to that -->
            <xsl:when test="@copy-to and not(contains(@chunk, 'to-content'))">
              <xsl:value-of select="dita-ot:normalize-uri(concat($pathBackToMapDirectory, @copy-to))"/>
            </xsl:when>
            <!--ref between two local paths - adjust normally-->
            <xsl:otherwise>
              <xsl:value-of select="dita-ot:normalize-uri(concat($pathBackToMapDirectory, @href))"/>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:attribute>
        <xsl:if test="exists($role)">
          <xsl:attribute name="role" select="$role"/>
        </xsl:if>
        <xsl:if test="exists($otherrole)">
          <xsl:attribute name="otherrole" select="$otherrole"/>
        </xsl:if>
        <!--figure out the linktext and desc-->
        <xsl:if test="*[contains(@class, ' map/topicmeta ')]/*[contains(@class, ' map/linktext ')]">
          <!--Do not output linktext when The final output type is PDF or IDD
            The target of the HREF is a local DITA file
            The user has not specified locktitle to override the title -->
          <xsl:if test="not(($FINALOUTPUTTYPE = 'PDF' or $FINALOUTPUTTYPE = 'IDD') and (not(@scope) or @scope = 'local') and (not(@format) or @format = 'dita') and (not(@locktitle) or @locktitle = 'no'))">
            <linktext class="- topic/linktext ">
              <xsl:choose>
                <xsl:when
                  test="
                  *[contains(@class, ' map/topicmeta ')]
                  /processing-instruction()[name() = 'ditaot'][. = 'usertext']">
                  <!-- Do not add section number to hard-coded link text -->
                </xsl:when>
                <xsl:when
                  test="
                  *[contains(@class, ' map/topicmeta ')]
                  /*[contains(@class, ' topic/data ')][@name = 'topicid']
                  /*[contains(@class, ' topic/data ')][@name = 'number']/@value"><xsl:value-of
                    select="
                    (*[contains(@class, ' map/topicmeta ')]
                    /*[contains(@class, ' topic/data ')][@name = 'topicid']
                    /*[contains(@class, ' topic/data ')][@name = 'number']/@value)[1]"/>
                  <xsl:text> </xsl:text>
                </xsl:when>
                <xsl:otherwise>
                  <xsl:variable name="thishref" select="@href"/>
                  <xsl:if
                    test="
                    //*[contains(@class, ' map/topicref ')][@href = $thishref]
                    /*[contains(@class, ' map/topicmeta ')]
                    /*[contains(@class, ' topic/data ')][@name = 'topicid']
                    /*[contains(@class, ' topic/data ')][@name = 'number']/@value">
                    <xsl:value-of
                      select="
                      //*[contains(@class, ' map/topicref ')][@href = $thishref]
                      /*[contains(@class, ' map/topicmeta ')]
                      /*[contains(@class, ' topic/data ')][@name = 'topicid']
                      /*[contains(@class, ' topic/data ')][@name = 'number']/@value"/>
                    <xsl:text> </xsl:text>
                  </xsl:if>
                </xsl:otherwise>
              </xsl:choose>
              <xsl:copy-of
                select="*[contains(@class, ' map/topicmeta ')]/processing-instruction()[name() = 'ditaot'][. = 'usertext' or . = 'gentext']"/>
              <!-- edited by Alan for bug ID: 2875373 on Date: 2009-10-12 begin-->
              <!-- xsl:value-of 
                select="normalize-space(*[contains(@class, ' map/topicmeta ')]/*[contains(@class, ' map/linktext ')])"/ -->
              <xsl:copy-of
                select="*[contains(@class, ' map/topicmeta ')]/*[contains(@class, ' map/linktext ')]/node()"/>
              <!-- edited by Alan for bug ID: 2875373 on Date: 2009-10-12 end-->
            </linktext>
          </xsl:if>
        </xsl:if>
        <xsl:if test="*[contains(@class, ' map/topicmeta ')]/*[contains(@class, ' map/shortdesc ')]">
          <!-- add desc node and text -->
          <xsl:apply-templates select="*[contains(@class, ' map/topicmeta ')]/*[contains(@class, ' map/shortdesc ')]"/>
        </xsl:if>
      </link>
    </xsl:if>
  </xsl:template>

  <!-- Drop IDs from elements pulled in to shortdesc -->
  <xsl:template
    match="*[contains(@class, ' map/topicmeta ')]/*[contains(@class, ' map/shortdesc ')]"
    name="node">
    <!--xsl:copy-of select="*[contains(@class, ' map/topicmeta ')]/*[contains(@class, ' map/shortdesc ')]"/-->
    <xsl:choose>
      <xsl:when test="../processing-instruction()[name() = 'ditaot'][. = 'genshortdesc']">
        <xsl:copy-of
          select="../processing-instruction()[name() = 'ditaot'][. = 'usershortdesc' or . = 'genshortdesc']"/>
        <desc class="- topic/desc ">
          <xsl:apply-templates select="node()" mode="oasis-drop-ids"/>
        </desc>
      </xsl:when>
      <xsl:otherwise>
        <!--xsl:copy-of select="*[contains(@class, ' map/topicmeta ')]/*[contains(@class, ' map/shortdesc ')]"/-->
        <xsl:copy-of
          select="../processing-instruction()[name() = 'ditaot'][. = 'usershortdesc' or . = 'genshortdesc']"/>
        <desc class="- topic/desc ">
          <!-- get child node and text -->
          <xsl:copy-of select="node()"/>
        </desc>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <!-- Drop @id from elements that were pulled in with shortdesc from another topic -->
  <xsl:template match="@id" mode="oasis-drop-ids"/>
  <xsl:template match="* | @* | comment() | processing-instruction() | text()" mode="oasis-drop-ids">
    <xsl:copy>
      <xsl:apply-templates select="@*" mode="oasis-drop-ids"/>
      <xsl:apply-templates select="* | comment() | processing-instruction() | text()"
        mode="oasis-drop-ids"/>
    </xsl:copy>
  </xsl:template>

</xsl:stylesheet>
