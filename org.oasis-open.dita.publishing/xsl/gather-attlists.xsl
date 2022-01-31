<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:rng="http://relaxng.org/ns/structure/1.0"
    exclude-result-prefixes="xs rng"
    version="2.0">
    
    <xsl:variable name="allgrammar">
        <xsl:message>Reading RNG files</xsl:message>
        <rng:grammar>
            <xsl:apply-templates select="/*" mode="gather-grammar"/>
            <!--<xsl:apply-templates select="document('../../org.oasis-open.dita.v2_0/rng/base/basemap.rng')/*" mode="gather-grammar"/>-->
            <xsl:apply-templates select="document('plugin:org.oasis-open.dita.v2_0:rng/base/basemap.rng')/*" mode="gather-grammar"/>
        </rng:grammar>
    </xsl:variable>
    
    <xsl:output method="xml" doctype-public="-//OASIS//DTD DITA 2.x Topic//EN" doctype-system="topic.dtd"/>
    
    <xsl:template match="/">
        <xsl:variable name="attrlists" as="element()">
            <rng:grammar>
                <xsl:for-each select="$allgrammar//rng:define[contains(@name,'.attributes')]
                                          [not(@name='dita.colspec.attributes' or @name='dita.entry.attributes' or @name='dita.table.attributes')]">
                    <xsl:sort select="@name"/>
                    <xsl:variable name="thisgroup" select="@name"/>
                    <xsl:if test="empty(preceding::rng:define[@name = $thisgroup])">
                        <xsl:copy-of select="."/>
                    </xsl:if>
                </xsl:for-each>
            </rng:grammar>
        </xsl:variable>
        <xsl:variable name="attrlists-expand" as="element()">
            <rng:grammar>
                <xsl:for-each select="$allgrammar//rng:define[contains(@name,'.attributes')]
                    [not(@name='dita.colspec.attributes' or @name='dita.entry.attributes' or @name='dita.table.attributes')]">
                    <xsl:sort select="@name"/>
                    <xsl:variable name="thisgroup" select="@name"/>
                    <xsl:if test="empty(preceding::rng:define[@name = $thisgroup])">
                        <xsl:copy>
                            <xsl:copy-of select="@*"/>
                            <xsl:attribute name="element" select="substring-before(@name,'.attributes')"/>
                            <xsl:apply-templates mode="expand-group"/>
                        </xsl:copy>
                    </xsl:if>
                </xsl:for-each>
            </rng:grammar>
        </xsl:variable>
        <xsl:variable name="attributegroups" as="element()">
            <rng:grammar>
                <!-- For each group that is used by an element, copy the group in, and
                    expand attribute lists to nested groups -->
                <xsl:for-each select="$attrlists//rng:ref">
                    <xsl:sort select="@name"/>
                    <xsl:variable name="thisname" select="@name"/>
                    <xsl:if test="empty(preceding::rng:ref[@name = $thisname])">
                        <xsl:apply-templates select="$allgrammar//rng:define[@name = $thisname]
                            [not(@name='dita.colspec.attributes' or @name='dita.entry.attributes' or @name='dita.table.attributes')]" mode="expand-group"/>
                    </xsl:if>
                </xsl:for-each>
            </rng:grammar>
        </xsl:variable>
        
        <xsl:message>Generating attribute topic (BETA)</xsl:message>
        <topic id="attributeappendix">
            <title>All about the attributes</title>
            <shortdesc>A list of all attributes defined in the base DITA grammar, sorted for some reason</shortdesc>
            <body>
                <section><title>All attributes, sorted</title><ol>
                    <xsl:for-each select="$allgrammar//rng:attribute">
                        <xsl:sort select="@name"/>
                        <xsl:variable name="attrname" select="@name"/>
                        <xsl:if test="empty(preceding::rng:attribute[@name = $attrname]) and string-length(@name) > 0">
                        <xsl:variable name="uses" as="element()*">
                            <xsl:for-each select="$attrlists-expand//rng:attribute[@name = $attrname]">
                                <!--<xsl:message>Found a use of <xsl:value-of select="@name"/>
In define group: <xsl:value-of select="ancestor::*[contains(@name,'.attributes')]/@name"/>
element attr: <xsl:value-of select="ancestor::*[contains(@name,'.attributes')]/@element"/></xsl:message>-->
                                <xmlelement><xsl:value-of select="ancestor::rng:define[@element]/@element"/></xmlelement>
                            </xsl:for-each>
                        </xsl:variable>
                        <xsl:variable name="doesnotuse" as="element()*">
                            <xsl:for-each select="$attrlists-expand//rng:define[@element][empty(.//rng:attribute[@name = $attrname])]">
                                <xmlelement><xsl:value-of select="@element"/></xmlelement>
                            </xsl:for-each>
                        </xsl:variable>
                        <xsl:variable name="exceptions" as="element()*">
                            <xsl:for-each select="$attrlists//rng:attribute[@name = $attrname]">
                                <!--<xsl:message>Matched an exception / one off thing</xsl:message>-->
                                <xmlelement><xsl:value-of select="substring-before(ancestor::*[contains(@name,'.attributes')]/@name, '.attributes')"/></xmlelement>
                            </xsl:for-each>
                        </xsl:variable>
                        <!--<xsl:variable name="ingroup">
                            <xsl:for-each select="$attributegroups"></xsl:for-each>
                        </xsl:variable>-->
                        <li><xmlatt><xsl:value-of select="$attrname"/></xmlatt>
                            <ul>
                                <li>What uses this? 
                                    <xsl:choose>
                                        <xsl:when test="count($uses) > 50"><i>More than 50 elements</i></xsl:when>
                                        <xsl:otherwise><xsl:for-each select="$uses"><xsl:sequence select="."/><xsl:if test="position() != last()">, </xsl:if></xsl:for-each></xsl:otherwise>
                                    </xsl:choose></li>
                                <li>What does not this? <xsl:choose>
                                    <xsl:when test="count($doesnotuse) > 50"><i>More than 50 elements</i></xsl:when>
                                    <xsl:otherwise><xsl:for-each select="$doesnotuse"><xsl:sequence select="."/><xsl:if test="position() != last()">, </xsl:if></xsl:for-each></xsl:otherwise>
                                </xsl:choose></li>
                                <xsl:if test="count($exceptions) > 0">
                                    <li>What defines this as a one-off? <xsl:choose>
                                        <xsl:when test="count($exceptions) > 50"><i>More than 50 elements</i></xsl:when>
                                        <xsl:otherwise><xsl:for-each select="$exceptions"><xsl:sequence select="."/><xsl:if test="position() != last()">, </xsl:if></xsl:for-each></xsl:otherwise>
                                    </xsl:choose></li>
                                </xsl:if>
                            </ul>
                        </li>
                        </xsl:if>
                    </xsl:for-each>
                </ol></section>
            </body>
        </topic>
    </xsl:template>
    
    <xsl:template match="rng:include" mode="gather-grammar">
        <!--<xsl:message>Go get <xsl:value-of select="@href"/></xsl:message>-->
        <xsl:apply-templates select="document(@href)/*/*" mode="gather-grammar"/>
    </xsl:template>
    
    <xsl:template match="@*|*|text()" mode="gather-grammar">
        <!--<xsl:message>What? working on <xsl:value-of select="name()"/></xsl:message>-->
        <xsl:copy>
            <xsl:apply-templates select="@*|*|text()" mode="gather-grammar"/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="rng:ref[@name]" mode="expand-group">
        <xsl:variable name="groupname" select="@name"/>
        <xsl:apply-templates select="$allgrammar//rng:define[@name = $groupname]/*" mode="expand-group"/>
    </xsl:template>
    
    <xsl:template match="node()" mode="expand-group">
        <xsl:copy>
            <xsl:apply-templates select="@*|node()" mode="gather-grammar"/>
        </xsl:copy>
    </xsl:template>
    
</xsl:stylesheet>