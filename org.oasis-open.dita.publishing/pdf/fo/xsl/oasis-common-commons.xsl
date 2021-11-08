<?xml version='1.0'?>

<!-- ===================== CHANGE LOG ================================ -->
<!--                                                                   -->
<!-- 05 Sep 2015 KJE: Added override for chapter titles.               -->
<!-- 05 Sep 2015 KJE: Added override for appendix titles.              -->
<!-- 21 Jun 2015  BT: Added additional override for chapter titles,    -->
<!--                  needed for more recent versions of DITA-OT.      -->
<!-- 16 Aug 2015 KJE: Added additional override for appendix titles.   -->
<!-- 08 Nov 2021 RDA: override indent, font size for link desc.        -->
<!--                                                                   -->
<!-- ================================================================= --> 

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:fo="http://www.w3.org/1999/XSL/Format"
                xmlns:opentopic="http://www.idiominc.com/opentopic"
                xmlns:opentopic-index="http://www.idiominc.com/opentopic/index"
                xmlns:opentopic-func="http://www.idiominc.com/opentopic/exsl/function"
                xmlns:dita2xslfo="http://dita-ot.sourceforge.net/ns/200910/dita2xslfo"
                xmlns:ot-placeholder="http://suite-sol.com/namespaces/ot-placeholder"
                exclude-result-prefixes="ot-placeholder opentopic opentopic-index opentopic-func dita2xslfo xs"
                version="2.0">
    
    <xsl:template match="fo:block/@start-indent|fo:block/@font-size" mode="dropCopiedIds">
        <!-- start indent, font size get copied from <shortdesc> processing into
      link description processing. Drop them and use settings from link__shortdesc.
        
        This processing comes from commons.xsl (thru topic.xsl) so override is here,
        rather than in link module that actually processes topic/link + 
        topic/desc + topic/shortdesc -->
    </xsl:template>

    <!-- OVERRIDE FOR DRAFT COMMENTS -->
    
    <xsl:template match="*[contains(@class,' topic/draft-comment ')]">
        <xsl:if test="$DRAFT='yes'">
            <fo:block xsl:use-attribute-sets="draft-comment">
                <xsl:call-template name="commonattributes"/>
                <fo:block xsl:use-attribute-sets="draft-comment__label">
                    <xsl:choose>
                        <xsl:when test="normalize-space(@author)!=''">
                            Comment by 
                            <xsl:value-of select="@author"/>
                            <xsl:choose>
                                <xsl:when test="normalize-space(@time)!=''">
                                    on  
                                    <xsl:value-of select="@time"/>  
                                </xsl:when>
                                <xsl:otherwise/>
                            </xsl:choose>
                        </xsl:when>
                        <xsl:otherwise/>
                    </xsl:choose>
                </fo:block>
                <xsl:apply-templates/>
            </fo:block>
        </xsl:if>
    </xsl:template>
    
    <!--  Override for bookmap chapter titles  -->
    <xsl:template name="processTopicChapter">
        <fo:page-sequence master-reference="body-sequence"
            xsl:use-attribute-sets="page-sequence.body">
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
                    <!-- Bob: Disable this. 21jun17 -->
                    <!-- <xsl:apply-templates select="." mode="insertChapterFirstpageStaticContent">
                        <xsl:with-param name="type" select="'chapter'"/>
                    </xsl:apply-templates>-->
                    <fo:block xsl:use-attribute-sets="topic.title">
                        <!-- Bob: Attach the chapter toc id to the title. 21jun17 -->
                        <xsl:attribute name="id">
                            <xsl:value-of select="concat('_OPENTOPIC_TOC_PROCESSING_', generate-id())"/>
                        </xsl:attribute>
                        <xsl:call-template name="pullPrologIndexTerms"/>
                        <xsl:for-each select="*[contains(@class, ' topic/title ')]">
                            <xsl:apply-templates select="." mode="getTitle"/>
                        </xsl:for-each>
                    </fo:block>
                    <xsl:choose>
                        <xsl:when test="$chapterLayout = 'BASIC'">
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
    
    <!--  Bookmap Appendix processing  -->
    <xsl:template name="processTopicAppendix">
        <fo:page-sequence master-reference="body-sequence" xsl:use-attribute-sets="page-sequence.appendix">
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
                            <xsl:variable name="topicref" select="key('map-id', ancestor-or-self::*[contains(@class, ' topic/topic ')][1]/@id)"/>
                            <xsl:for-each select="$topicref">
                                <xsl:apply-templates select="." mode="topicTitleNumber"/>
                            </xsl:for-each>
                        </fo:marker>
                        <xsl:apply-templates select="." mode="insertTopicHeaderMarker"/>
                    </xsl:if>
                    
                    <xsl:apply-templates select="*[contains(@class,' topic/prolog ')]"/>
                    
                    <!-- 15 August 2017: Eberlein, disabled this template -->
                    <!--<xsl:apply-templates select="." mode="insertChapterFirstpageStaticContent">
                        <xsl:with-param name="type" select="'appendix'"/>
                    </xsl:apply-templates>-->
                    
                    <fo:block xsl:use-attribute-sets="topic.title">
                        <!-- Bob: Attach the chapter toc id to the title. 21jun17 -->
                        <xsl:attribute name="id">
                            <xsl:value-of select="concat('_OPENTOPIC_TOC_PROCESSING_', generate-id())"/>
                        </xsl:attribute>
                        <xsl:call-template name="pullPrologIndexTerms"/>
                        <xsl:for-each select="*[contains(@class,' topic/title ')]">
                            <xsl:apply-templates select="." mode="getTitle"/>
                        </xsl:for-each>
                    </fo:block>
                    
                    <xsl:choose>
                        <xsl:when test="$appendixLayout='BASIC'">
                            <xsl:apply-templates select="*[not(contains(@class, ' topic/topic ') or contains(@class, ' topic/title ') or
                                contains(@class, ' topic/prolog '))]"/>
                            <!--xsl:apply-templates select="." mode="buildRelationships"/-->
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:apply-templates select="." mode="createMiniToc"/>
                        </xsl:otherwise>
                    </xsl:choose>
                    
                    <xsl:apply-templates select="*[contains(@class,' topic/topic ')]"/>
                    <xsl:call-template name="pullPrologIndexTerms.end-range"/>
                </fo:block>
            </fo:flow>
        </fo:page-sequence>
    </xsl:template>

</xsl:stylesheet>
