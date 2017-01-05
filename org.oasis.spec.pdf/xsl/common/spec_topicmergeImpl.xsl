<?xml version="1.0" encoding="UTF-8" ?>

<!--
Copyright © 2004-2005 by Idiom Technologies, Inc. All rights reserved.
IDIOM is a registered trademark of Idiom Technologies, Inc. and WORLDSERVER
and WORLDSTART are trademarks of Idiom Technologies, Inc. All other
trademarks are the property of their respective owners.

IDIOM TECHNOLOGIES, INC. IS DELIVERING THE SOFTWARE "AS IS," WITH
ABSOLUTELY NO WARRANTIES WHATSOEVER, WHETHER EXPRESS OR IMPLIED,  AND IDIOM
TECHNOLOGIES, INC. DISCLAIMS ALL WARRANTIES, EXPRESS OR IMPLIED, INCLUDING
BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
PURPOSE AND WARRANTY OF NON-INFRINGEMENT. IDIOM TECHNOLOGIES, INC. SHALL NOT
BE LIABLE FOR INDIRECT, INCIDENTAL, SPECIAL, COVER, PUNITIVE, EXEMPLARY,
RELIANCE, OR CONSEQUENTIAL DAMAGES (INCLUDING BUT NOT LIMITED TO LOSS OF
ANTICIPATED PROFIT), ARISING FROM ANY CAUSE UNDER OR RELATED TO  OR ARISING
OUT OF THE USE OF OR INABILITY TO USE THE SOFTWARE, EVEN IF IDIOM
TECHNOLOGIES, INC. HAS BEEN ADVISED OF THE POSSIBILITY OF SUCH DAMAGES.

Idiom Technologies, Inc. and its licensors shall not be liable for any
damages suffered by any person as a result of using and/or modifying the
Software or its derivatives. In no event shall Idiom Technologies, Inc.'s
liability for any damages hereunder exceed the amounts received by Idiom
Technologies, Inc. as a result of this transaction.

These terms and conditions supersede the terms and conditions in any
licensing agreement to the extent that such terms and conditions conflict
with those set forth herein.

This file is part of the DITA Open Toolkit project.
See the accompanying LICENSE file for applicable license.
-->

<!-- An adaptation of the Toolkit topicmerge.xsl for FO plugin use. -->

<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:ot-placeholder="http://suite-sol.com/namespaces/ot-placeholder"
    xmlns:dita-ot="http://dita-ot.sourceforge.net/ns/201007/dita-ot"
    exclude-result-prefixes="xs dita-ot">

    <xsl:variable name="numbered-titles" as="xs:boolean"
        select="
            if (/dita-merge/*[contains(@class, ' map/map ')]/*[contains(@class, ' map/topicmeta ')]/data[@name = 'numbered-titles']/@value = 'true') then
                true()
            else
                false()"/>

    <xsl:template match="*[contains(@class, ' map/topicref ')]" mode="build-tree">
        <xsl:choose>
            <xsl:when test="not(normalize-space(@first_topic_id) = '')">
                <xsl:apply-templates select="key('topic', @first_topic_id)">
                    <xsl:with-param name="parentId" select="generate-id()"/>
                </xsl:apply-templates>
                <xsl:if test="@first_topic_id != @href">
                    <xsl:apply-templates select="key('topic', @href)">
                        <xsl:with-param name="parentId" select="generate-id()"/>
                    </xsl:apply-templates>
                </xsl:if>
            </xsl:when>
            <xsl:when test="not(normalize-space(@href) = '')">
                <xsl:apply-templates select="key('topic', @href)">
                    <xsl:with-param name="parentId" select="generate-id()"/>
                </xsl:apply-templates>
            </xsl:when>
            <xsl:when
                test="
                    contains(@class, ' bookmap/part ') or
                    (normalize-space(@navtitle) != '' or *[contains(@class, ' map/topicmeta ')]/*[contains(@class, ' topic/navtitle ')])">
                <xsl:variable name="isNotTopicRef" as="xs:boolean">
                    <xsl:call-template name="isNotTopicRef"/>
                </xsl:variable>
                <xsl:if test="not($isNotTopicRef)">
                    <topic id="{generate-id()}" class="+ topic/topic pdf2-d/placeholder ">
                        <title class="- topic/title ">
                            <xsl:if test="$numbered-titles">
                                <xsl:value-of select="processing-instruction(tsnum)"/>
                                <xsl:text> </xsl:text>
                            </xsl:if>
                            <xsl:choose>
                                <xsl:when
                                    test="*[contains(@class, ' map/topicmeta ')]/*[contains(@class, ' topic/navtitle ')]">
                                    <xsl:copy-of
                                        select="*[contains(@class, ' map/topicmeta ')]/*[contains(@class, ' topic/navtitle ')]/node()"
                                    />
                                </xsl:when>
                                <xsl:when test="@navtitle">
                                    <xsl:value-of select="@navtitle"/>
                                </xsl:when>
                            </xsl:choose>
                        </title>
                        <xsl:copy-of select="processing-instruction(tsnum)"/>
                        <xsl:copy-of select="processing-instruction(tsstruct)"/>
                        <!--body class=" topic/body "/-->
                        <xsl:apply-templates mode="build-tree"/>
                    </topic>
                </xsl:if>
            </xsl:when>
            <xsl:otherwise>
                <xsl:apply-templates mode="build-tree"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <!-- These booklist templates have all been copied to fix a precedence problem where
         none of the following templates would match. Before doing this, these templates
         were matching on the topicref template in this file. -->
    <xsl:template match="*[contains(@class,' bookmap/toc ')][not(@href)]" priority="2" mode="build-tree">
        <ot-placeholder:toc id="{generate-id()}">
            <xsl:apply-templates mode="build-tree"/>
        </ot-placeholder:toc>
    </xsl:template>
    <xsl:template match="*[contains(@class,' bookmap/indexlist ')][not(@href)]" priority="2" mode="build-tree">
        <ot-placeholder:indexlist id="{generate-id()}">
            <xsl:apply-templates mode="build-tree"/>
        </ot-placeholder:indexlist>
    </xsl:template>
    
    <xsl:template match="*[contains(@class,' bookmap/glossarylist ')][not(@href)]" priority="2" mode="build-tree">
        <ot-placeholder:glossarylist id="{generate-id()}">
            <xsl:apply-templates mode="build-tree"/>
        </ot-placeholder:glossarylist>
    </xsl:template>
    
    <xsl:template match="*[contains(@class,' bookmap/tablelist ')][not(@href)]" priority="2" mode="build-tree">
        <ot-placeholder:tablelist id="{generate-id()}">
            <xsl:apply-templates mode="build-tree"/>
        </ot-placeholder:tablelist>
    </xsl:template>
    
    <xsl:template match="*[contains(@class,' bookmap/figurelist ')][not(@href)]" priority="2" mode="build-tree">
        <ot-placeholder:figurelist id="{generate-id()}">
            <xsl:apply-templates mode="build-tree"/>
        </ot-placeholder:figurelist>
    </xsl:template>

</xsl:stylesheet>
