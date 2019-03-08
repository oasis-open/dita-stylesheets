<?xml version='1.0' encoding='utf-8'?>

<!-- ===================== CHANGE LOG ================================ -->
<!--                                                                   -->
<!-- 08 Mar 2019 KJE: Initial creation. Updated to match file shipped  -->
<!--                  with DITA-OT 3.3                                 -->
<!--                                                                   -->
<!-- =====================++++++++++++================================ -->

<xsl:stylesheet spdf:version="2.4.1" 
                exclude-result-prefixes="ditaarch opentopic spdf" 
                version="2.0"
                xmlns:ditaarch="http://dita.oasis-open.org/architecture/2005/"
                xmlns:spdf="org.oasis.spec.pdf" 
                xmlns:opentopic="http://www.idiominc.com/opentopic"
                xmlns:opentopic-func="http://www.idiominc.com/opentopic/exsl/function"
                xmlns:xs="http://www.w3.org/2001/XMLSchema" 
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  
  <!-- spec.pdf: Base imports are interleaved with spec overrides. The spec overrides are
       interleaved to minimize template precedence problems. -->  
  <xsl:import href="plugin:org.dita.base:xsl/common/dita-utilities.xsl"/>
  <xsl:import href="plugin:org.dita.base:xsl/common/dita-textonly.xsl"/>
  <xsl:import href="plugin:org.dita.base:xsl/common/related-links.xsl"/>
  <xsl:import href="plugin:org.dita.pdf2:xsl/common/attr-set-reflection.xsl"/>
  <xsl:import href="plugin:org.dita.pdf2:xsl/common/vars.xsl"/>
  
  <xsl:import href="plugin:org.dita.pdf2:cfg/fo/attrs/basic-settings.xsl"/>
  <xsl:import href="plugin:org.oasis.spec.pdf:cfg/fo/attrs/spec_basic-settings.xsl"/>
  
  <xsl:import href="plugin:org.dita.pdf2:cfg/fo/attrs/layout-masters-attr.xsl"/>
  <!--<xsl:import href="plugin:org.oasis.spec.pdf:cfg/fo/attrs/spec_layout-masters-attr.xsl"/>-->
  <xsl:import href="plugin:org.dita.pdf2:cfg/fo/layout-masters.xsl"/>
  <xsl:import href="plugin:org.oasis.spec.pdf:cfg/fo/spec_layout-masters.xsl"/>
  
  <xsl:import href="plugin:org.dita.pdf2:cfg/fo/attrs/links-attr.xsl"/>
  <xsl:import href="plugin:org.oasis.spec.pdf:cfg/fo/attrs/spec_links-attr.xsl"/>
  <xsl:import href="plugin:org.dita.pdf2:xsl/fo/links.xsl"/>
  <xsl:import href="plugin:org.oasis.spec.pdf:xsl/fo/spec_links.xsl"/>
  
  <xsl:import href="plugin:org.dita.pdf2:cfg/fo/attrs/lists-attr.xsl"/>
  <xsl:import href="plugin:org.oasis.spec.pdf:cfg/fo/attrs/spec_lists-attr.xsl"/>
  <xsl:import href="plugin:org.dita.pdf2:xsl/fo/lists.xsl"/>
  <xsl:import href="plugin:org.oasis.spec.pdf:xsl/fo/spec_lists.xsl"/>
  
  <xsl:import href="plugin:org.dita.pdf2:cfg/fo/attrs/tables-attr.xsl"/>
  <xsl:import href="plugin:org.dita.pdf2.axf:cfg/fo/attrs/tables-attr_axf.xsl"/>
  <xsl:import href="plugin:org.oasis.spec.pdf:cfg/fo/attrs/spec_tables-attr.xsl"/>  
  <xsl:import href="plugin:org.dita.pdf2:xsl/fo/tables.xsl"/>
  <xsl:import href="plugin:org.oasis.spec.pdf:xsl/fo/spec_tables.xsl"/>
  
  <xsl:import href="plugin:org.dita.pdf2:xsl/fo/root-processing.xsl"/>
    <xsl:import href="plugin:org.dita.pdf2:cfg/fo/attrs/topic-attr.xsl"/>
    <xsl:import href="plugin:org.dita.pdf2:cfg/fo/attrs/concept-attr.xsl"/>
    <xsl:import href="plugin:org.dita.pdf2:cfg/fo/attrs/commons-attr.xsl"/>
  <xsl:import href="plugin:org.oasis.spec.pdf:cfg/fo/attrs/spec_commons-attr.xsl"/>
  <xsl:import href="plugin:org.dita.pdf2:xsl/fo/commons.xsl"/>
  <xsl:import href="plugin:org.oasis.spec.pdf:xsl/fo/spec_commons.xsl"/>
  
  <xsl:import href="plugin:org.dita.pdf2:cfg/fo/attrs/toc-attr.xsl"/>
  <xsl:import href="plugin:org.dita.pdf2.axf:cfg/fo/attrs/toc-attr_axf.xsl"/>
  <xsl:import href="plugin:org.oasis.spec.pdf:cfg/fo/attrs/spec_toc-attr.xsl"/>
  <xsl:import href="plugin:org.dita.pdf2:xsl/fo/toc.xsl"/>
  <xsl:import href="plugin:org.oasis.spec.pdf:xsl/fo/spec_toc.xsl"/>
  
  <xsl:import href="plugin:org.dita.pdf2:xsl/fo/bookmarks.xsl"/>
  
  <xsl:import href="plugin:org.dita.pdf2:cfg/fo/attrs/index-attr.xsl"/>
  <xsl:import href="plugin:org.dita.pdf2.axf:cfg/fo/attrs/index-attr_axf.xsl"/>
  <!--<xsl:import href="plugin:org.oasis.spec.pdf:cfg/fo/attrs/spec_index-attr.xsl"/>-->
  <xsl:import href="plugin:org.dita.pdf2:xsl/fo/index.xsl"/>
  <xsl:import href="plugin:org.dita.pdf2.axf:xsl/fo/index_axf.xsl"/>
  
  <xsl:import href="plugin:org.dita.pdf2:cfg/fo/attrs/front-matter-attr.xsl"/>
  <xsl:import href="plugin:org.oasis.spec.pdf:cfg/fo/attrs/spec_front-matter-attr.xsl"/>
  <xsl:import href="plugin:org.dita.pdf2:xsl/fo/front-matter.xsl"/>
  <xsl:import href="plugin:org.oasis.spec.pdf:xsl/fo/spec_front-matter.xsl"/>
  
  <xsl:import href="plugin:org.dita.pdf2:xsl/fo/preface.xsl"/>
  
  <xsl:import href="plugin:org.dita.pdf2:cfg/fo/attrs/map-elements-attr.xsl"/>
  <xsl:import href="plugin:org.dita.pdf2:xsl/fo/map-elements.xsl"/>
  
  <xsl:import href="plugin:org.dita.pdf2:cfg/fo/attrs/task-elements-attr.xsl"/>
  <xsl:import href="plugin:org.oasis.spec.pdf:cfg/fo/attrs/spec_task-elements-attr.xsl"/>
  <xsl:import href="plugin:org.dita.pdf2:xsl/fo/task-elements.xsl"/>
  <!--<xsl:import href="plugin:org.oasis.spec.pdf:xsl/fo/spec_task-elements.xsl"/>-->
  
  <xsl:import href="plugin:org.dita.pdf2:cfg/fo/attrs/reference-elements-attr.xsl"/>  
  <xsl:import href="plugin:org.oasis.spec.pdf:cfg/fo/attrs/spec_reference-elements-attr.xsl"/>
  <xsl:import href="plugin:org.dita.pdf2:xsl/fo/reference-elements.xsl"/>
  
  <xsl:import href="plugin:org.dita.pdf2:cfg/fo/attrs/sw-domain-attr.xsl"/>  
  <xsl:import href="plugin:org.oasis.spec.pdf:cfg/fo/attrs/spec_sw-domain-attr.xsl"/>
  <xsl:import href="plugin:org.dita.pdf2:xsl/fo/sw-domain.xsl"/>
  
  <xsl:import href="plugin:org.dita.pdf2:cfg/fo/attrs/pr-domain-attr.xsl"/>
  <xsl:import href="plugin:org.oasis.spec.pdf:cfg/fo/attrs/spec_pr-domain-attr.xsl"/>
  <xsl:import href="plugin:org.dita.pdf2:xsl/fo/pr-domain.xsl"/>
  
  <xsl:import href="plugin:org.dita.pdf2:cfg/fo/attrs/hi-domain-attr.xsl"/>
  <xsl:import href="plugin:org.oasis.spec.pdf:cfg/fo/attrs/spec_hi-domain-attr.xsl"/>
  <xsl:import href="plugin:org.dita.pdf2:xsl/fo/hi-domain.xsl"/>
  
  <xsl:import href="plugin:org.dita.pdf2:cfg/fo/attrs/ui-domain-attr.xsl"/>
  <xsl:import href="plugin:org.dita.pdf2:xsl/fo/ui-domain.xsl"/>
  
  <xsl:import href="plugin:org.dita.pdf2:xsl/fo/ut-domain.xsl"/>
  
  <xsl:import href="plugin:org.dita.pdf2:xsl/fo/abbrev-domain.xsl"/>
  
  <xsl:import href="plugin:org.dita.pdf2:cfg/fo/attrs/markup-domain-attr.xsl"/>
  <xsl:import href="plugin:org.dita.pdf2:xsl/fo/markup-domain.xsl"/>
  <xsl:import href="plugin:org.dita.pdf2:cfg/fo/attrs/xml-domain-attr.xsl"/>
  <xsl:import href="plugin:org.oasis.spec.pdf:cfg/fo/attrs/spec_xml-domain-attr.xsl"/>
  <xsl:import href="plugin:org.dita.pdf2:xsl/fo/xml-domain.xsl"/>
  <xsl:import href="plugin:org.oasis.spec.pdf:xsl/fo/spec_xml-domain.xsl"/>
    <xsl:import href="plugin:org.dita.pdf2:cfg/fo/attrs/svg-domain-attr.xsl"/>
    <xsl:import href="plugin:org.dita.pdf2:xsl/fo/svg-domain.xsl"/>
    <xsl:import href="plugin:org.dita.pdf2:cfg/fo/attrs/hazard-d-attr.xsl"/>
    <xsl:import href="plugin:org.dita.pdf2:xsl/fo/hazard-d.xsl"/>
    
    <xsl:import href="plugin:org.dita.pdf2:cfg/fo/attrs/static-content-attr.xsl"/>
    <xsl:import href="plugin:org.dita.pdf2:xsl/fo/static-content.xsl"/>
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
