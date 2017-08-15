<?xml version='1.0'?>

<!-- ===================== CHANGE LOG ================================ -->
<!--                                                                   -->
<!-- 05 15 Aug 2015: Eberlein, initial creation.                       -->
<!--                                                                   -->
<!-- ================================================================= --> 

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:fo="http://www.w3.org/1999/XSL/Format"
    xmlns:opentopic-i18n="http://www.idiominc.com/opentopic/i18n"
    xmlns:opentopic-index="http://www.idiominc.com/opentopic/index"
    xmlns:opentopic="http://www.idiominc.com/opentopic"
    xmlns:opentopic-func="http://www.idiominc.com/opentopic/exsl/function"
    xmlns:ditaarch="http://dita.oasis-open.org/architecture/2005/"
    exclude-result-prefixes="opentopic-index opentopic opentopic-i18n opentopic-func"
    version="2.0">

    <xsl:import href="plugin:org.dita.base:xsl/common/dita-utilities.xsl"/>
    <xsl:import href="plugin:org.dita.base:xsl/common/dita-textonly.xsl"/>
    <xsl:import href="plugin:org.dita.base:xsl/common/related-links.xsl"/>
  
    <xsl:import href="plugin:org.dita.pdf2:xsl/common/attr-set-reflection.xsl"/>
    <xsl:import href="plugin:org.dita.pdf2:xsl/common/vars.xsl"/>

    <xsl:import href="plugin:org.dita.pdf2:cfg/fo/attrs/basic-settings.xsl"/>
    <xsl:import href="plugin:org.oasis.committeeNote.pdf:cfg/fo/attrs/oasis-cn-basic-settings.xsl"/>
    <xsl:import href="plugin:org.dita.pdf2:cfg/fo/attrs/layout-masters-attr.xsl"/>
    <xsl:import href="plugin:org.dita.pdf2:cfg/fo/layout-masters.xsl"/>
    <xsl:import href="plugin:org.oasis.committeeNote.pdf:cfg/fo/xsl/oasis-cn-layout-masters.xsl"/>
    <xsl:import href="plugin:org.dita.pdf2:cfg/fo/attrs/links-attr.xsl"/>
    <xsl:import href="plugin:org.dita.pdf2:xsl/fo/links.xsl"/>
    <xsl:import href="plugin:org.dita.pdf2:cfg/fo/attrs/lists-attr.xsl"/>
    <xsl:import href="plugin:org.dita.pdf2:xsl/fo/lists.xsl"/>
    <xsl:import href="plugin:org.dita.pdf2:cfg/fo/attrs/tables-attr.xsl"/>
    <xsl:import href="plugin:org.oasis.committeeNote.pdf:cfg/fo/attrs/oasis-cn-tables-attr.xsl"/>
    <xsl:import href="plugin:org.dita.pdf2:xsl/fo/tables.xsl"/>
    <xsl:import href="plugin:org.oasis.committeeNote.pdf:cfg/fo/xsl/oasis-cn-tables.xsl"/>
    <xsl:import href="plugin:org.dita.pdf2:xsl/fo/root-processing.xsl"/>
    <xsl:import href="plugin:org.dita.pdf2:cfg/fo/attrs/commons-attr.xsl"/>
    <xsl:import href="plugin:org.oasis.committeeNote.pdf:cfg/fo/attrs/oasis-cn-commons-attr.xsl"/>
    <xsl:import href="plugin:org.oasis.committeeNote.pdf:cfg/fo/attrs/oasis-cn-custom-attr.xsl"/>
    <xsl:import href="plugin:org.oasis.committeeNote.pdf:cfg/fo/attrs/oasis-cn-topic-attr.xsl"/>
    <xsl:import href="plugin:org.oasis.committeeNote.pdf:cfg/fo/attrs/oasis-cn-cover-attr.xsl"/>
    <xsl:import href="plugin:org.dita.pdf2:xsl/fo/commons.xsl"/>
    <xsl:import href="plugin:org.oasis.committeeNote.pdf:cfg/fo/xsl/oasis-cn-commons.xsl"/>
    <xsl:import href="plugin:org.oasis.committeeNote.pdf:cfg/fo/xsl/oasis-cn-cover-notices.xsl"/>
    <xsl:import href="plugin:org.oasis.committeeNote.pdf:cfg/fo/xsl/oasis-cn-footers.xsl"/>
    <xsl:import href="plugin:org.oasis.committeeNote.pdf:cfg/fo/xsl/oasis-cn-numbering.xsl"/>
    <xsl:import href="plugin:org.dita.pdf2:cfg/fo/attrs/toc-attr.xsl"/>
    <xsl:import href="plugin:org.oasis.committeeNote.pdf:cfg/fo/attrs/oasis-cn-toc-attr.xsl"/>
    <xsl:import href="plugin:org.dita.pdf2:xsl/fo/toc.xsl"/>
    <xsl:import href="plugin:org.oasis.committeeNote.pdf:cfg/fo/xsl/oasis-cn-toc.xsl"/>
    <xsl:import href="plugin:org.dita.pdf2:xsl/fo/bookmarks.xsl"/>
    <xsl:import href="plugin:org.dita.pdf2:cfg/fo/attrs/index-attr.xsl"/>
    <xsl:import href="plugin:org.dita.pdf2:xsl/fo/index.xsl"/>
    <xsl:import href="plugin:org.dita.pdf2:cfg/fo/attrs/front-matter-attr.xsl"/>
    <xsl:import href="plugin:org.oasis.committeeNote.pdf:cfg/fo/xsl/oasis-cn-front-matter.xsl"/>
    <xsl:import href="plugin:org.dita.pdf2:xsl/fo/front-matter.xsl"/>
    <xsl:import href="plugin:org.dita.pdf2:xsl/fo/preface.xsl"/>

    <xsl:import href="plugin:org.dita.pdf2:cfg/fo/attrs/map-elements-attr.xsl"/>
    <xsl:import href="plugin:org.dita.pdf2:xsl/fo/map-elements.xsl"/>

    <xsl:import href="plugin:org.dita.pdf2:cfg/fo/attrs/task-elements-attr.xsl"/>
    <xsl:import href="plugin:org.dita.pdf2:xsl/fo/task-elements.xsl"/>

    <xsl:import href="plugin:org.dita.pdf2:cfg/fo/attrs/reference-elements-attr.xsl"/>
    <xsl:import href="plugin:org.dita.pdf2:xsl/fo/reference-elements.xsl"/>

    <xsl:import href="plugin:org.dita.pdf2:cfg/fo/attrs/sw-domain-attr.xsl"/>
    <xsl:import href="plugin:org.dita.pdf2:xsl/fo/sw-domain.xsl"/>
    <xsl:import href="plugin:org.dita.pdf2:cfg/fo/attrs/pr-domain-attr.xsl"/>
    <xsl:import href="plugin:org.oasis.committeeNote.pdf:cfg/fo/attrs/oasis-cn-pr-domain-attr.xsl"/>
    <xsl:import href="plugin:org.dita.pdf2:xsl/fo/pr-domain.xsl"/>
    <xsl:import href="plugin:org.dita.pdf2:cfg/fo/attrs/hi-domain-attr.xsl"/>
    <xsl:import href="plugin:org.dita.pdf2:xsl/fo/hi-domain.xsl"/>
    <xsl:import href="plugin:org.dita.pdf2:cfg/fo/attrs/ui-domain-attr.xsl"/>
    <xsl:import href="plugin:org.dita.pdf2:xsl/fo/ui-domain.xsl"/>
    <xsl:import href="plugin:org.dita.pdf2:xsl/fo/ut-domain.xsl"/>
    <xsl:import href="plugin:org.dita.pdf2:xsl/fo/abbrev-domain.xsl"/>
    <xsl:import href="plugin:org.dita.pdf2:cfg/fo/attrs/markup-domain-attr.xsl"/>
    <xsl:import href="plugin:org.dita.pdf2:xsl/fo/markup-domain.xsl"/>
    <xsl:import href="plugin:org.dita.pdf2:cfg/fo/attrs/xml-domain-attr.xsl"/>
    <xsl:import href="plugin:org.oasis.committeeNote.pdf:cfg/fo/attrs/oasis-cn-xml-domain-attr.xsl"/>
    <xsl:import href="plugin:org.dita.pdf2:xsl/fo/xml-domain.xsl"/>

    <xsl:import href="plugin:org.dita.pdf2:cfg/fo/attrs/static-content-attr.xsl"/>
    <xsl:import href="plugin:org.oasis.committeeNote.pdf:cfg/fo/attrs/oasis-cn-static-content-attr.xsl"/>
    <xsl:import href="plugin:org.dita.pdf2:xsl/fo/static-content.xsl"/>
    <xsl:import href="plugin:org.oasis.committeeNote.pdf:cfg/fo/xsl/oasis-cn-static-content.xsl"/>
    <xsl:import href="plugin:org.dita.pdf2:cfg/fo/attrs/glossary-attr.xsl"/>
    <xsl:import href="plugin:org.dita.pdf2:xsl/fo/glossary.xsl"/>
    <xsl:import href="plugin:org.dita.pdf2:cfg/fo/attrs/lot-lof-attr.xsl"/>
    <xsl:import href="plugin:org.dita.pdf2:xsl/fo/lot-lof.xsl"/>

    <xsl:import href="plugin:org.dita.pdf2:cfg/fo/attrs/learning-elements-attr.xsl"/>
    <xsl:import href="plugin:org.dita.pdf2:xsl/fo/learning-elements.xsl"/>

    <xsl:import href="plugin:org.dita.pdf2:xsl/fo/flagging.xsl"/>
    <xsl:import href="plugin:org.dita.pdf2:xsl/fo/flagging-from-preprocess.xsl"/>


    <xsl:output method="xml" encoding="utf-8" indent="no"/>

</xsl:stylesheet>