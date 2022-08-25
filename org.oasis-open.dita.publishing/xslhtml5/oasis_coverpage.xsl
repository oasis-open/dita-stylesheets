<?xml version="1.0"?>
<!-- Tagsmiths: Changed XSLT to version 2.0 -04oct13-->
<xsl:stylesheet version="2.0" xmlns:oa="http://www.oasis-open.org"
  xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs oa"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <!-- Tagsmiths: Eliminated DITAEXT parameter. Now using 2.0 replace() function to capture basename. -04oct13-->
  <xsl:param name="DITAEXT" select="'.dita'"/>
  <xsl:param name="OUTEXT" select="'.html'"/>

  <xsl:param name="oasisDitaUri">http://docs.oasis-open.org/dita/dita</xsl:param>

  <xsl:param name="FOOTER"/>

  <!-- Tagsmiths: The following paramaters are components used for oasis naming conventions. 21jul16 -->
  <xsl:param name="version-id"/>
  <xsl:param name="errata-num"/>
  <xsl:param name="stage-abbrev"/>
  <xsl:param name="revision-num"/>
  <xsl:param name="part-number"/>
  <xsl:param name="spec-release-type"/>

  <xsl:output method="html"
    encoding="UTF-8"
    indent="no"
    doctype-system="about:legacy-compat"
    omit-xml-declaration="yes"/>

  <xsl:variable name="newline">
    <xsl:text>
</xsl:text>
  </xsl:variable>

  <xsl:variable name="pubWorkdir" select="/processing-instruction('workdir-uri')[1]"/>

  <xsl:variable name="specSubtitle1"
    select="
      /*[contains(@class, ' bookmap/bookmap ')]
      /*[contains(@class, ' bookmap/booktitle ')]
      /*[contains(@class, ' bookmap/booktitlealt ')][@outputclass = 'specificationSubtitle1']"/>
  <xsl:variable name="specSubtitle2"
    select="
      /*[contains(@class, ' bookmap/bookmap ')]
      /*[contains(@class, ' bookmap/booktitle ')]
      /*[contains(@class, ' bookmap/booktitlealt ')][@outputclass = 'specificationSubtitle2']"/>
  <xsl:variable name="specLevel"
    select="
      /*[contains(@class, ' bookmap/bookmap ')]
      /*[contains(@class, ' bookmap/booktitle ')]
      /*[contains(@class, ' bookmap/booktitlealt ')][@outputclass = 'specificationLevel']"/>
  <xsl:variable name="specPrefix"
    select="
      /*[contains(@class, ' bookmap/bookmap ')]
      /*[contains(@class, ' bookmap/booktitle ')]
      /*[contains(@class, ' bookmap/booktitlealt ')][@outputclass = 'specificationPrefix']"/>
  <xsl:variable name="specScope"
    select="
      /*[contains(@class, ' bookmap/bookmap ')]
      /*[contains(@class, ' bookmap/booktitle')]
      /*[contains(@class, ' bookmap/booktitlealt ')][@outputclass = 'specificationScope']"/>
  <xsl:variable name="specVersion"
    select="
      /*[contains(@class, ' bookmap/bookmap ')]/*
      /*[contains(@class, ' bookmap/bookmeta')]
      /*[contains(@class, ' topic/prodinfo ')]
      /*[contains(@class, ' topic/vrmlist ')]
      /*[contains(@class, ' topic/vrm ')]/@version"/>

  <xsl:variable name="revName">
    <!-- errata-01-->
    <xsl:if test="($errata-num castable as xs:double) and number($errata-num) &gt; 0">
      <xsl:text>errata-</xsl:text>
      <xsl:value-of select="$errata-num"/>
    </xsl:if>
  </xsl:variable>

  <xsl:template match="/">
    <html>
      <xsl:value-of select="$newline"/>
      <head>
        <xsl:value-of select="$newline"/>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
        <xsl:value-of select="$newline"/>
        <meta content="Copyright © OASIS Open 2022" name="copyright"/>
        <xsl:value-of select="$newline"/>
        <meta content=" Copyright © OASIS 2022" name="DC.rights.owner"/>
        <xsl:value-of select="$newline"/>
        <!-- KJE 18 August 2022: Commented out OASIS Template CSS -->
        <!--<link href="https://docs.oasis-open.org/templates/css/OASIS_Specification_Template_v1-0.css"
          rel="stylesheet" type="text/css"/>-->
        <!-- KJE 18 Aug 2022: Switched order of CSS files -->
        <link href="commonltr.css" rel="stylesheet" type="text/css"/>
        <link href="oasis.css" rel="stylesheet" type="text/css"/>
        <xsl:value-of select="$newline"/>
        <title>
          <xsl:value-of select="$newline"/>
          <xsl:apply-templates
            select="/*/*[@outputclass = 'specificationTitles']/*[@outputclass = 'specificationShorttitle']"/>
          <xsl:value-of select="$newline"/>
        </title>
        <xsl:value-of select="$newline"/>
          <xsl:if
            test="/*/*[contains(@class, ' bookmap/bookmeta ')]/*[@outputclass = 'thisVersion']/*[@format = 'html']/@href">
            <xsl:value-of select="$newline"/>
            <!--<base>
              <xsl:attribute name="href">
                <xsl:value-of select="/*/*[contains(@class,' bookmap/bookmeta ')]/*[@outputclass='thisVersion']/*[@format='html']/@href"/>
              </xsl:attribute>
            </base><xsl:value-of select="$newline"/>-->
          </xsl:if>
        <script type="text/javascript">
          (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
          (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
          m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
          })(window,document,'script','https://www.google-analytics.com/analytics.js','ga');      
          ga('create', 'UA-82127846-1', 'auto');
          ga('send', 'pageview');      
        </script>
      </head>
      <xsl:value-of select="$newline"/>
      <body>
        <xsl:value-of select="$newline"/>
        <!-- KJE 18 Aug 2022: Changed class name and image, removed width and height; added horizontal rule -->
        <!-- KJE 23 Aug 2022: Updated image to version 3, per feedback from Paul Knight -->
        <p class="logo">
          <img src="https://docs.oasis-open.org/templates/OASISLogo-v3.0.png" alt="OASIS logo"/>
            <!-- width="203"
            height="54"-->
        </p>
        <hr/>
        <xsl:value-of select="$newline"/>

        <div>
          <xsl:value-of select="$newline"/>
          <p class="title">
            <xsl:apply-templates
              select="
                /*[contains(@class, ' bookmap/bookmap ')]/
                *[contains(@class, ' bookmap/booktitle ')]/
                *[contains(@class, ' bookmap/mainbooktitle ')]"
            />
          </p>
          <!-- Tagsmiths: Output the cover topic and the notices topic. -31oct13 -->
          <p class="subtitle">
            <!-- Part number >= zero means that this is a spec part document. 06dec17 -->
            <xsl:choose>
              <xsl:when test="($part-number castable as xs:double) and number($part-number) &lt; 0">
                <xsl:choose>
                  <!-- It's a draft -->
                  <xsl:when
                    test="($revision-num castable as xs:double) and number($revision-num) > 0">
                    <span>
                      <xsl:value-of select="$spec-release-type"/>
                    </span>
                  </xsl:when>
                  <!-- It's final -->
                  <xsl:otherwise>
                    <span>OASIS Approved Errata</span>
                  </xsl:otherwise>
                </xsl:choose>
              </xsl:when>
              <!-- If this is an errata and the revision number is non-zero ... -->
              <xsl:when test="($errata-num castable as xs:double) and number($errata-num) > 0">                
                <xsl:text>OASIS Standard </xsl:text>
                <xsl:choose>
                  <xsl:when
                    test="($revision-num castable as xs:double) and number($revision-num) > 0">
                    <span class="revised">
                      <xsl:text>incorporating </xsl:text>
                      <xsl:if test="$stage-abbrev = 'csprd'">
                        <xsl:text> Public Review</xsl:text>
                      </xsl:if>
                      <xsl:text> Draft </xsl:text>
                      <xsl:value-of select="$revision-num"/>
                      <xsl:text> of Errata </xsl:text>
                      <xsl:value-of select="$errata-num"/>
                    </span>
                  </xsl:when>
                  <xsl:otherwise>
                    <xsl:text> </xsl:text>
                    <span class="revised">
                      <xsl:text>incorporating Approved Errata</xsl:text>
                    </span>
                  </xsl:otherwise>
                </xsl:choose>
              </xsl:when>

            </xsl:choose>
          </p>
          <!-- Date -->
          <xsl:if test="not(normalize-space($specSubtitle2) = '')">
            <p class="subtitle">
              <xsl:value-of select="$specSubtitle2"/>
            </p>
          </xsl:if>
          <!-- Tagsmiths: Output the cover topic and the notices topic. -31oct13 -->
          <p class="subtitle topmargin">
            <xsl:value-of
              select="
                /*[contains(@class, ' bookmap/bookmap ')]
                /*[contains(@class, ' bookmap/booktitle ')]
                /*[contains(@class, ' bookmap/booktitlealt ')][@outputclass = 'specificationApproved']"
            />
          </p>
          <!-- Tagsmiths: Output the cover topic and the notices topic. -31oct13 -->
          <xsl:for-each select="/bookmap/frontmatter/notices/topicref">
            <!-- Tagsmiths: Process these topics as frontmatter -->
            <xsl:apply-templates select="document(@href)" mode="process-frontmatter"/>
          </xsl:for-each>
        </div>
        <xsl:value-of select="$newline"/>
        <div>
          <xsl:value-of select="$newline"/>
            <p class="heading1">Table of Contents</p>
            <xsl:value-of select="$newline"/>
            <xsl:apply-templates select="/*/*[contains(@class, ' bookmap/chapter ')]" mode="toc"/>
            <xsl:apply-templates select="/*/*[contains(@class, ' bookmap/appendix ')]" mode="toc"/>
          <p/>
          <xsl:value-of select="$newline"/>
          <div class="familylinks">
            <xsl:value-of select="$newline"/>
            <div class="titlepageinfodescription">
              <xsl:variable name="firstTopic">
                <xsl:value-of select="/*/*[contains(@class, ' bookmap/chapter ')][@href][1]/@href"/>
              </xsl:variable>
              <xsl:variable name="hoverHelp">
                <xsl:apply-templates
                  select="/*/*[contains(@class, ' bookmap/chapter ')][@href][1]/*[contains(@class, ' map/topicmeta ')]/*[contains(@class, ' map/shortdesc ')]"
                />
              </xsl:variable>
              <strong>Next topic:</strong>
              <xsl:text> </xsl:text>
              <a>
                <xsl:attribute name="href">
                  <!-- Tagsmiths: The regular-expression in the following replace() function
                       strips off the file extension from the filename in @href. -04oct13
                  -->
                  <xsl:value-of select="replace($firstTopic, '(.*)\..*', '$1')"/>
                  <xsl:value-of select="$OUTEXT"/>
                </xsl:attribute>
                <xsl:if test="normalize-space($hoverHelp) != ''">
                  <xsl:attribute name="title">
                    <xsl:value-of select="normalize-space($hoverHelp)"/>
                  </xsl:attribute>
                  <xsl:apply-templates
                    select="/*/*[contains(@class, ' bookmap/chapter ')][@href][1]" mode="getNum"/>
                  <xsl:text> </xsl:text>
                  <xsl:apply-templates
                    select="/*/*[contains(@class, ' bookmap/chapter ')][@href][1]" mode="getTitle"/>
                </xsl:if>
              </a>
            </div>
            <xsl:value-of select="$newline"/>
          </div>
          <xsl:value-of select="$newline"/>
        </div>
        <xsl:value-of select="$newline"/>
      </body>
      <xsl:value-of select="$newline"/>
    </html>
  </xsl:template>

  <!-- Tagsmiths: Begining of several templates for rendering cover and notices. -31oct13 -->
  <xsl:template match="/" mode="process-frontmatter">
    <xsl:choose>
      <xsl:when test="*[@outputclass = 'cover']">
        <xsl:apply-templates mode="cover"/>
      </xsl:when>
      <xsl:when test="*[@outputclass = 'frontmatternotices']">
        <xsl:apply-templates mode="notices"/>
      </xsl:when>
    </xsl:choose>
  </xsl:template>

  <!-- Tagsmiths: Process the cover topic. -31oct13 -->
  <xsl:template match="*[contains(@class, ' topic/topic ')]/*[contains(@class, ' topic/title ')]"
    mode="cover">
    <p class="heading4">
      <xsl:apply-templates/>
    </p>
  </xsl:template>

  <xsl:template match="*[contains(@class, ' topic/section ')]" mode="cover">
    <xsl:apply-templates mode="cover"/>
  </xsl:template>

  <xsl:template match="*[contains(@class, ' topic/section ')]/*[contains(@class, ' topic/title ')]"
    mode="cover">
    <p class="titlepageinfo"><xsl:apply-templates/>:</p>
  </xsl:template>

  <xsl:template match="*[contains(@class, ' topic/p ')]" mode="cover">
    <xsl:choose>
      <xsl:when test="@outputclass = 'no-space-before'">
        <p class="titlepageinfodescription">
          <xsl:apply-templates mode="cover"/>
        </p>
      </xsl:when>
      <xsl:otherwise>
        <p class="abstract">
          <xsl:apply-templates mode="cover"/>
        </p>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="*[contains(@class, ' topic/sl ')]" mode="cover #default">
    <xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="*[contains(@class, ' topic/sli ')]">
    <xsl:choose>
      <xsl:when test="parent::*/@outputclass = 'no-indent'">
        <p class="titlepageinfodescription">
          <xsl:apply-templates/>
        </p>
      </xsl:when>
      <xsl:otherwise>
        <p class="relatedwork">
          <xsl:apply-templates/>
        </p>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <!-- Tagsmiths: Process the notices topic. -31oct13 -->
  <xsl:template match="*[contains(@class, ' topic/ul ')]" mode="cover #default">
    <ul class="ul">
      <xsl:apply-templates/>
    </ul>
  </xsl:template>

  <xsl:template match="*[contains(@class, ' topic/li ')]" mode="cover #default">
    <li class="li">
      <xsl:apply-templates/>
    </li>
  </xsl:template>
  <!-- Tagsmiths: End of several templates for rendering cover and notices. -31oct13 -->

  <xsl:template match="*[contains(@class, ' topic/p ')]" mode="notices">
    <p class="normal">
      <xsl:apply-templates/>
    </p>
  </xsl:template>
  <xsl:template match="*[contains(@class, ' topic/topic ')]/*[contains(@class, ' topic/title ')]"
    mode="notices">
    <p class="notices">
      <xsl:apply-templates/>
    </p>
  </xsl:template>
  <xsl:template match="*[contains(@class, ' topic/cite ')]">
    <cite>
      <xsl:apply-templates/>
    </cite>
  </xsl:template>
  <!-- Tagsmiths: End of several templates for rendering cover and notices. -31oct13 -->


  <xsl:template match="*[contains(@class, ' topic/xref ')]" mode="#default cover">
    <xsl:variable name="topicWorkdir" select="/processing-instruction('workdir-uri')[1]"/>
    <a>
      <xsl:attribute name="href">
        <xsl:choose>
          <xsl:when test="matches(@scope, 'external')">
            <xsl:value-of select="@href"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:variable name="absHref" select="resolve-uri(@href, $topicWorkdir)"/>
            <xsl:variable name="hrefRelativeToPub"
              select="oa:abspathToRelpath($absHref, $pubWorkdir)"/>
            <xsl:variable name="hrefRelativeToPubRaw"
              select="replace($hrefRelativeToPub, concat($DITAEXT, '#'), concat($OUTEXT, '#'), 'i')"/>
            <xsl:value-of select="replace($hrefRelativeToPubRaw, '(.*#[^/]*)/(.*)', '$1__$2')"/>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:attribute>
      <xsl:apply-templates/>
    </a>
  </xsl:template>

  <xsl:function name="oa:abspathToRelpath">
    <xsl:param name="abspath" as="xs:string"/>
    <xsl:param name="baseDirectory" as="xs:string"/>
    <xsl:value-of select="replace($abspath, $baseDirectory, '')"/>
  </xsl:function>

  <!-- Tagsmiths: Add rendering for tm. -01nov13-->
  <xsl:template match="*[contains(@class, ' topic/tm ')]">
    <xsl:apply-templates/>
    <xsl:choose>
      <!-- ignore @tmtype=service or anything else -->
      <xsl:when test="@tmtype = 'tm'">&#x2122;</xsl:when>
      <xsl:when test="@tmtype = 'reg'">
        <sup>&#xAE;</sup>
      </xsl:when>
      <xsl:otherwise/>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="*[contains(@class, ' topic/ph ')]">

    <xsl:choose>
      <xsl:when test="@rev = $revName">
        <span>
          <xsl:attribute name="class">revised</xsl:attribute>
          <xsl:apply-templates/>
        </span>
      </xsl:when>
      <xsl:otherwise>
        <xsl:apply-templates/>
      </xsl:otherwise>
    </xsl:choose>

  </xsl:template>

  <xsl:template match="*" mode="getTitle">
    <xsl:choose>
      <xsl:when
        test="*[contains(@class, ' map/topicmeta ')]/*[contains(@class, ' topic/navtitle ')]">
        <xsl:apply-templates
          select="*[contains(@class, ' map/topicmeta ')]/*[contains(@class, ' topic/navtitle ')]"/>
      </xsl:when>
      <xsl:when test="@navtitle">
        <xsl:value-of select="@navtitle"/>
      </xsl:when>
    </xsl:choose>
  </xsl:template>
  <xsl:template match="*[contains(@class, ' bookmap/chapter ')]" mode="getNum">
    <xsl:choose>
      <xsl:when
        test="
          contains(*[contains(@class, ' map/topicmeta ')]
          /*[contains(@class, ' topic/data ')][@name = 'topicid']
          /*[contains(@class, ' topic/data ')][@name = 'number']
          /@value, '.0')">
        <xsl:value-of
          select="
            substring-before(*[contains(@class, ' map/topicmeta ')]
            /*[contains(@class, ' topic/data ')][@name = 'topicid']
            /*[contains(@class, ' topic/data ')][@name = 'number']
            /@value, '.0')"
        />
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of
          select="
            *[contains(@class, ' map/topicmeta ')]
            /*[contains(@class, ' topic/data ')][@name = 'topicid']
            /*[contains(@class, ' topic/data ')][@name = 'number']
            /@value"
        />
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <!--<xsl:template match="*[contains(@class,' bookmap/appendix ')]" mode="getNum">
    <xsl:value-of select="substring-before(*[contains(@class,' map/topicmeta ')]
                                              /*[contains(@class,' topic/data ')][@name='topicid']
                                              /*[contains(@class,' topic/data ')][@name='number']
                                              /@value,'.')"/>
  </xsl:template>-->
  <xsl:template match="*" mode="getNum">
    <xsl:value-of
      select="
        *[contains(@class, ' map/topicmeta ')]
        /*[contains(@class, ' topic/data ')][@name = 'topicid']
        /*[contains(@class, ' topic/data ')][@name = 'number']
        /@value"
    />
  </xsl:template>
  <xsl:template match="*" mode="getId">
    <xsl:value-of select="*/resourceid[@appname='spectocid']/@appid"/>
  </xsl:template>

  <xsl:template match="*" mode="toc">
    <xsl:param name="indent" select="''"/>
    <xsl:variable name="thistitle">
      <xsl:apply-templates select="." mode="getTitle"/>
    </xsl:variable>
    <xsl:choose>
      <xsl:when test="normalize-space($thistitle) != ''">
        <xsl:variable name="topicNum">
          <xsl:apply-templates select="." mode="getNum"/>
        </xsl:variable>
        <xsl:variable name="topicId">
          <xsl:apply-templates select="." mode="getId"/>
        </xsl:variable>
        <!-- Tagsmiths: The regular-expression in the following replace() function
          strips off the file extension from the filename in @href. -04oct13
        -->
        <xsl:variable name="basename" select="replace(@href, '(.*)\..*', '$1')"/>
        <p class="titlepageinfodescription">
          <xsl:value-of select="$indent"/>
          <xsl:value-of select="$topicNum"/>
          <xsl:text> </xsl:text>
          <a id="{$topicId}">
            <xsl:attribute name="href">
              <xsl:value-of select="$basename"/>
              <xsl:value-of select="$OUTEXT"/>
              <xsl:text>#</xsl:text>
              <xsl:choose>
                <xsl:when test="contains(@href, '#')">
                  <xsl:value-of select="substring-after(@href, '#')"/>
                </xsl:when>
                <xsl:otherwise>
                  <xsl:value-of select="$topicId"/>
                </xsl:otherwise>
              </xsl:choose>
            </xsl:attribute>
            <xsl:value-of select="$thistitle"/>
          </a>
        </p>
        <xsl:value-of select="$newline"/>
        <xsl:apply-templates select="*[contains(@class, ' map/topicref ')]" mode="toc">
          <xsl:with-param name="indent">
            <xsl:value-of select="$indent"/>
            <xsl:text>&#xA0;&#xA0;&#xA0;</xsl:text>
          </xsl:with-param>
        </xsl:apply-templates>
      </xsl:when>
      <xsl:otherwise>
        <xsl:apply-templates select="*[contains(@class, ' map/topicref ')]" mode="toc">
          <xsl:with-param name="indent" select="$indent"/>
        </xsl:apply-templates>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="text()">
    <xsl:choose>
      <xsl:when test="normalize-space(.) = ''"/>
      <xsl:otherwise>
        <xsl:value-of select="."/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="*[contains(@class, ' topic/author ')]" mode="cover notices #default">
    <!-- Suppress it -->
  </xsl:template>

  <xsl:template match="*[contains(@class, ' topic/dl ')]" mode="cover notices #default">
    <dl class="cover">
      <xsl:apply-templates/>
    </dl>
  </xsl:template>

  <xsl:template match="*[contains(@class, ' topic/dlentry ')]">
    <xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="*[contains(@class, ' topic/dt ')]">
    <dt class="dlterm oasis-style-reference">
      <xsl:apply-templates/>
    </dt>
  </xsl:template>

  <xsl:template match="*[contains(@class, ' topic/dd ')]">
    <dd class="oasis-style-reference">
      <xsl:apply-templates/>
    </dd>
  </xsl:template>

</xsl:stylesheet>
